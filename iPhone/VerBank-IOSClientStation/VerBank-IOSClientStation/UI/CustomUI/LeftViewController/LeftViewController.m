//
//  LeftViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LeftViewController.h"
#import "IosLayoutDefine.h"
#import "LeftTableViewCell.h"
#import "LangCaptain.h"
#import "ImageUtils.h"
#import "UIColor+CustomColor.h"
#import "TopBarView.h"
#import "IosLogic.h"
#import "ScreenAuotoSizeScale.h"
#import "MarginCallView.h"
#import "TradeApi.h"
#import "ClientAPI.h"
#import "ShowAlert.h"
#import "DataCenter.h"
#import "MTP4CommDataInterface.h"
#import "KChartParam.h"
#import "KChartView.h"
#import "CertificateUtil.h"
#import "ContentView.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

typedef NS_ENUM(NSInteger, LeftScreenStatus) {
    Closed = 0,
    Opened = 1,
    Unknow = 2
};

typedef NS_ENUM(NSInteger, LeftViewSelectIndex) {
    EQuoteListView = 0,
    EOpenPositionView = 1,
    EOrderPositionView = 2,
    EOrderHisView = 3,
    EClosePositionView = 4,
    EPositionSumView = 5,
    EPriceWarningView = 6,
    EForexNewsView = 7,
    EMarginCallView = 8,
    EMessageView = 9,
    ESystemConfigView = 10,
    EAbountView = 11,
    ELogoutFromServer = 12
};

// 暂时有13行
const CGFloat kTableCellNumber = 13;

const CGFloat kDefaultRadius = 2.0f;
const NSUInteger kDefaultIterations = 3;

@implementation UIImage (LeftViewController)

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor{
    //image must be nonzero size
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f) return self;
    
    //boxsize must be an odd integer
    uint32_t boxSize = (uint32_t)(radius * self.scale);
    if (boxSize % 2 == 0) boxSize ++;
    
    //create image buffers
    CGImageRef imageRef = self.CGImage;
    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    size_t bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);
    
    //create temp buffer
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    
    //copy image data
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++) {
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        //swap buffers
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }
    
    //free buffers
    free(buffer2.data);
    free(tempBuffer);
    
    //create image context from buffer
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));
    
    //apply tint
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f) {
        CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:1.55].CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }
    
    //create image from context
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    return image;
}

@end

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>{
    Boolean _isNibsRegistered;
    UITableView *_leftTableView;
    UIScrollView *leftScrollView;
    UIImage *blurredImage;
    UIImageView *blurredImageView;
    UIView *_backgroundView;
    NSInteger _selectIndex;
    Boolean _isSelect;
    TopBarView *topStatusBar;
    unsigned leftScreenStatus;
    UIImageView *rightView;
    
    ContentView *_contentView;
}

@end

@implementation LeftViewController

@synthesize leftWidth = _leftWidth;
@synthesize sideViewAlpha = _sideViewAlpha;
@synthesize backgroundImage = _backgroundImage;
@synthesize leftContentView = _leftContentView;
@synthesize centerContentView = _centerContentView;
@synthesize backgroundView = _backgroundView;
@synthesize contentView = _contentView;

#pragma init
- (id)initWithCoder:(NSCoder*)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setDefault];
    }
    return self;
}

- (id)init{
    if (self = [super init]){
        [self setDefault];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        [self setDefault];
    }
    return self;
}

- (void)setDefault{
    self.leftWidth = DEFAULT_LEFT_WIDTH;
    self.sideViewAlpha = DEFAULT_ALPHA;
    self.sideViewTintColor = [UIColor blackColor];
    // 这里有问题， 没时间修改
    [self.view setBackgroundColor:[UIColor blackColor]];
    if (IOS7_OR_LATER) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
}

#pragma init
- (void)initLayout{
    [self initTopBar];
    [self initCenterContentView];
    [self initLeftScrollView];
    [self initLeftContentView];
    [self initbackgroundView];
}

- (void)initbackgroundView{
    //add 模糊画面
    CGRect backgroundRect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _backgroundView = [[UIView alloc] initWithFrame:backgroundRect];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeSideView)];
    [_backgroundView addGestureRecognizer:tapGesture];
    [self.view insertSubview:_backgroundView aboveSubview:self.centerContentView];
    [_backgroundView setHidden:true];
}

- (void)initLeftScrollView{
    // LeftScrollView
    leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-self.leftWidth,
                                                                    SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR,
                                                                    self.leftWidth,
                                                                    SCREEN_HEIGHT - SCREEN_TOPST_HEIGHT - SCREEN_STATUS_BAR)];
    leftScrollView.contentSize = CGSizeMake(self.leftWidth, SCREEN_WIDTH - SCREEN_TOPST_HEIGHT - SCREEN_STATUS_BAR);
    [leftScrollView setScrollEnabled:false];
    [self.view insertSubview:leftScrollView aboveSubview:self.centerContentView];
}

- (void)initCenterContentView{
    // centerContentView
    self.centerContentView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR,
                                                                      SCREEN_WIDTH,
                                                                      SCREEN_HEIGHT - SCREEN_TOPST_HEIGHT - SCREEN_STATUS_BAR)];
    [self.view addSubview:self.centerContentView];
}

- (void)initLeftContentView{
    // LeftContentView
    self.leftContentView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    self.leftWidth,
                                                                    SCREEN_HEIGHT - SCREEN_TOPST_HEIGHT - SCREEN_STATUS_BAR)];
    [leftScrollView addSubview:self.leftContentView];
    
    _isNibsRegistered = false;
    _leftTableView = [[UITableView alloc] initWithFrame:self.leftContentView.frame];
    _leftTableView.backgroundColor = [UIColor blackColor];
    _leftTableView.tableFooterView = _leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.bounces = NO;
    _leftTableView.showsVerticalScrollIndicator = NO;
    [_leftTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    leftScreenStatus = Closed;
    
    [self.leftContentView addSubview:_leftTableView];
}

- (void)initTopBar{
    //topBar
    topStatusBar = [[TopBarView alloc] init];
    
    UIButton *leftButton = [[UIButton alloc] init];
    CGPoint centerPoint = CGPointMake(SCREEN_TOPST_HEIGHT / 2, SCREEN_TOPST_HEIGHT / 2);
    CGRect imageRect = CGRectMake(0, 0, 20, 20);
    
    [leftButton setFrame:CGRectMake(0, SCREEN_STATUS_BAR, SCREEN_TOPST_HEIGHT * 2 + 20, SCREEN_TOPST_HEIGHT)];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton addTarget:self action:@selector(leftScroll) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:imageRect]];
    [leftButton addSubview:leftView];
    [leftView setImage:[UIImage imageNamed:@"images/normal/more_update.png"]];
    [leftView setCenter:centerPoint];
    
    CGPoint logoViewPoint = CGPointMake(SCREEN_TOPST_HEIGHT + 20.0f, SCREEN_TOPST_HEIGHT / 2);
    CGRect logoViewRect = CGRectMake(0, 0, SCREEN_TOPST_HEIGHT + 10, [ScreenAuotoSizeScale CGAutoMakeFloat:30]);
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:logoViewRect];
    [logoView setCenter:logoViewPoint];
    [logoView setImage:[UIImage imageNamed:@"images/logo/topLogo.png"]];
    [leftButton addSubview:logoView];
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setFrame:CGRectMake(SCREEN_WIDTH - SCREEN_TOPST_HEIGHT, SCREEN_STATUS_BAR, SCREEN_TOPST_HEIGHT, SCREEN_TOPST_HEIGHT)];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    rightView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:imageRect]];
    [self resetRightView];
    [rightButton addSubview:rightView];
    [rightView setCenter:centerPoint];
    
    [topStatusBar addSubview:leftButton];
    [topStatusBar addSubview:rightButton];
    
    [self.view addSubview:topStatusBar];
}

- (void)resetRightView {
    //    UIImageView *rightView
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        Boolean needInputPhonePin = [CertificateUtil needInputPhonePin];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            if (needInputPhonePin) {
    //                [rightView setImage:[UIImage imageNamed:@"images/normal/personal.png"]];
    //            } else {
    //                [rightView setImage:[UIImage imageNamed:@"images/normal/personalwhite.png"]];
    //            }
    //        });
    //    });
    
    // 根據 datacenter 是否有phonepin 來判斷
    //    Boolean needInputPhonePin = [[DataCenter getInstance] phonePin] == nil || [[[DataCenter getInstance] phonePin] isEqualToString:@""];
    Boolean needInputPhonePin = [CertificateUtil checkIsneedputPhonePin];
    if (needInputPhonePin) {
        [rightView setImage:[UIImage imageNamed:@"images/normal/personal.png"]];
    } else {
        [rightView setImage:[UIImage imageNamed:@"images/normal/personalwhite.png"]];
    }
}

- (void)setStateBarTitle:(NSString *)title centerButton:(UIButton *)button{
    [topStatusBar setTitleName:title withMidButton:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma leftView
- (void)closeSideView{
    //移去模糊画面
    [[_backgroundView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //    [_backgroundView removeFromSuperview];
    [_backgroundView setHidden:true];
    //移去菜单栏
    CGRect rect = CGRectMake(0.0f - self.leftWidth,
                             leftScrollView.frame.origin.y,
                             leftScrollView.frame.size.width,
                             leftScrollView.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [leftScrollView setFrame:rect];
    [UIView setAnimationDidStopSelector:@selector(closeAnimationDidStop)];
    [UIView commitAnimations];
    leftScreenStatus = Closed;
    [self resetRightView];
}

-(void)closeAnimationDidStop{
    if (_isSelect) {
        switch (_selectIndex) {
            case EQuoteListView:
                [[IosLogic getInstance] gotoQuoteListViewController];
                break;
            case EOpenPositionView:
                [[IosLogic getInstance] gotoOpenPositionViewController];
                break;
            case EOrderPositionView:
                [[IosLogic getInstance] gotoOrderPositionViewController];
                break;
            case EOrderHisView:
                [[IosLogic getInstance] gotoOrderHisViewController];
                break;
            case EClosePositionView:
                [[IosLogic getInstance] gotoClosePositionViewController];
                break;
            case EPositionSumView:
                [[IosLogic getInstance] gotoPositionSumViewController];
                break;
            case EPriceWarningView:
                [self gotoPriceWarningView];
                break;
            case EForexNewsView:
                [[IosLogic getInstance] gotoForexNewsViewController];
                break;
            case EMarginCallView:
                [self marginCallHisQuery];
                break;
            case EMessageView:
                [self gotoMessageView];
                break;
            case ESystemConfigView:
                [[IosLogic getInstance] gotoSystemConfigViewController];
                break;
            case EAbountView:
                [[IosLogic getInstance] gotoAbountViewController];
                break;
            case ELogoutFromServer:
                [[IosLogic getInstance] logoutFromServer];
                break;
                
            default:
                break;
        }
        _isSelect = false;
    }
}

- (void)marginCallHisQuery{
    //    int beforWeeks = 4;
    //    NSDate *endDate = [NSDate new];
    //    NSDate *beginDate = [NSDate dateWithTimeIntervalSinceNow:beforWeeks * WeekSecInterval * -1];
    //
    ////    int list[]  =  {ACCOUNTSTREAMTYPE_DEPOSIT, ACCOUNTSTREAMTYPE_WITHDRAW, ACCOUNTSTREAMTYPE_ROLLOVER,
    ////        ACCOUNTSTREAMTYPE_TRADE, ACCOUNTSTREAMTYPE_ADJUST_FIXDEPOSIT, ACCOUNTSTREAMTYPE_LIQUIDATION};
    ////
    //    NSNumber *deposit    = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_DEPOSIT];
    //    NSNumber *withDraw   = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_WITHDRAW];
    //    NSNumber *rollover   = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_ROLLOVER];
    //    NSNumber *trade      = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_TRADE];
    //    NSNumber *adjustFixdeposit = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_ADJUST_FIXDEPOSIT];
    //    NSNumber *liquidation = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_LIQUIDATION];
    //
    //    NSArray *array = [[NSArray alloc] initWithObjects:deposit,withDraw,rollover,trade,adjustFixdeposit,liquidation, nil];
    //
    //    [[TradeApi getInstance] report_AccountStreamDetails:beginDate endDate:endDate typeVec:array];
    [[IosLogic getInstance] gotoMarginCallHisViewController];
}



- (void)openLeftView{
    [self addBlurBackground:kDefaultRadius iterations:kDefaultIterations];
    //移动 菜单栏
    CGRect rect = CGRectMake(leftScrollView.frame.origin.x + self.leftWidth,
                             leftScrollView.frame.origin.y,
                             leftScrollView.frame.size.width,
                             leftScrollView.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [leftScrollView setFrame:rect];
    [UIView commitAnimations];
    leftScreenStatus = Opened;
    [self returnKeyboard:self.centerContentView];
}

- (void)addBlurBackground:(CGFloat)radius iterations:(NSInteger)iteration {
    UIImage *backImage = [ImageUtils imageWithView:self.view];
    self.backgroundImage = [backImage blurredImageWithRadius:radius iterations:iteration tintColor:[UIColor blackColor]];
    _backgroundView.backgroundColor = [UIColor colorWithPatternImage:self.backgroundImage];
    //    [self.view insertSubview:_backgroundView aboveSubview:self.centerContentView];
    [_backgroundView setHidden:false];
}

- (void)returnKeyboard:(UIView *)view {
    for (UIView *subView in [view subviews]) {
        if ([subView isKindOfClass:[UITextField class]]) {
            [subView resignFirstResponder];
        } else {
            [self returnKeyboard:subView];
        }
    }
}

- (void)arrangeViews:(UIScrollView *)scrollView{
    if (leftScreenStatus == Closed){
        [self openLeftView];
    } else {
        [self closeSideView];
    }
}

- (void)leftScroll{
    [self arrangeViews:leftScrollView];
}

- (void)rightClick {
    [self gotoMarginCallView];
}

#pragma tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTableView) {
        return kTableCellNumber;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        static NSString *CellIndentifier = @"LeftTableViewCell";
        if(!_isNibsRegistered){
            UINib *nib=[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellIndentifier];
            _isNibsRegistered = YES;
        }
        LeftTableViewCell *cell = (LeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
        [self setLeftTableViewCell:cell withIndex:[indexPath row]];
        cell.selectedBackgroundView.backgroundColor = [UIColor backgroundColor];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LeftTableViewCellHeight;
}

- (void) setLeftTableViewCell:(LeftTableViewCell *) cell withIndex:(NSInteger)index{
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"images/LeftTableViewCell/left_%ld.png",(long)index]];
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/LeftTableViewCell/background_normal.png"]]];
    [cell setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/LeftTableViewCell/background_selected.png"]]];
    cell.nameLabel.text = [[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"left_%ld", (long)index]];
    [cell.nameLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:16.0f]]];
    [cell setBackgroundColor:[UIColor blackColor]];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftTableViewCell *cell = (LeftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.nameLabel setTextColor:[UIColor whiteColor]];
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"images/LeftTableViewCell/sleft_%ld.png",(long)[indexPath row]]];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftTableViewCell *cell = (LeftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.nameLabel setTextColor:[UIColor blackColor]];
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"images/LeftTableViewCell/left_%ld.png",(long)[indexPath row]]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        _isSelect = true;
        _selectIndex = [indexPath row];
        [self closeSideView];
    }
}

#pragma jumper
- (void)gotoMessageView {
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"]
                                                   onView:self.view];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Boolean flag = [[DataCenter getInstance] queryReportList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            if (flag) {
                [[IosLogic getInstance] gotoMessageViewController];
            } else {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"LoadingFailed"]];
            }
        });
    });
}

- (void)gotoPriceWarningView {
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"]
                                                   onView:self.view];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[DataCenter getInstance] queryPriceWarning];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            [[IosLogic getInstance] gotoPriceWarningViewController];
        });
    });
}

- (void)gotoMarginCallView {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ACCOUNT subType:APP_OPT_TYPE_NONE];
    [self addBlurBackground:kDefaultRadius iterations:kDefaultIterations];
    MarginCallView *marginCallView = [[MarginCallView alloc] initWithContentArray:[[LangCaptain getInstance] getMarginCallConfig]];
    [_backgroundView addSubview:marginCallView];
    [marginCallView addCertificateButtonTitle];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)addKChartView:(NSString *)instrumentName {
    //    [[[[self superview] superview] superview]addSubview:[KChartView getInstance]];
    [self.view insertSubview:[KChartView getInstance] belowSubview:_backgroundView];
    [[KChartView getInstance] setTag:KChartViewTag];
    [[KChartParam getInstance] setInstrumentName:instrumentName];
    [[KChartParam getInstance] resetConfig];
    [[KChartView getInstance] reloadHistoricData];
    [[KChartView getInstance] addKChartViewWithAnimation:true];
    //    [[KChartView getInstance] addKChartViewWithAnimation:true];
}

- (void)popKChartView:(NSString *)instrumentName {
    //    [[[[self superview] superview] superview]addSubview:[KChartView getInstance]];
    [self.view insertSubview:[KChartView getInstance] belowSubview:_backgroundView];
    [[KChartView getInstance] setTag:KChartViewTag];
    [[KChartParam getInstance] setInstrumentName:instrumentName];
    [[KChartParam getInstance] resetConfig];
    [[KChartView getInstance] reloadHistoricData];
    //    [[KChartView getInstance] popKChartViewWithAnimation:true];
    [[KChartView getInstance] popKChartViewWithAnimation:true];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        // 横屏
        [self.leftContentView setHidden:true];
        [self.backgroundView setHidden:true];
        [[KChartView getInstance] disableBackButton];
    } else if (toInterfaceOrientation == UIInterfaceOrientationPortrait){
        // 竖屏
        [self.leftContentView setHidden:false];
        if ([[self.backgroundView subviews] count] == 0 && leftScreenStatus == Closed) {
            [self.backgroundView setHidden:true];
        } else {
            [self.backgroundView setHidden:false];
        }
    }
    [[KChartView getInstance] setNeedsLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
