//
//  SystemConfigContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SystemConfigContentView.h"
#import "LangCaptain.h"
#import "ClientSystemConfig.h"
#import "UIView+FreezeTableView.h"
#import "IosLayoutDefine.h"
#import "InstrumentChoosePopView.h"
#import "DefaultAmountChangePopView.h"
#import "IosLogic.h"
#import "ImageUtils.h"
#import "LeftViewController.h"
#import "UIFormat.h"

#import "PasswordChangePopView.h"
#import "CertificateChangePopView.h"
#import "RssResourcePopView.h"
#import "CertificatePopView.h"

#import "OptRecordTable.h"
#import "OperationRecordsSave.h"

#define CellHeight 40
#define SwitchTag 100

typedef NS_ENUM(NSInteger, SectionName) {
    // 系统设定栏位
    CurrencyChoose = 0,
    PasswordChange = 1,
    Certificate = 2,
    CertificateChange = 3, // 电话下单密码
    OpenPositionSort = 4,
    OrderSort = 5,
    PositionSumSort = 6,
    AmountCustom = 7,
    ColumnChoose = 8,
    Rss = 9,
    
};

@interface SystemConfigContentView()<UITableViewDataSource, UITableViewDelegate> {
    UIView *_backgroundView;
    DefaultAmountChangePopView *defaultAmountChangePopView;
    PasswordChangePopView *passwordChangePopView;
    CertificateChangePopView *certificateChangePopView;
}
@end

@implementation SystemConfigContentView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSystemConfigTableView];
        //        [self loadData];
        [self initData];
        [self initBackgroundView];
    }
    return self;
}

- (void)initBackgroundView {
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    defaultAmountChangePopView = [DefaultAmountChangePopView newInstance];
    [defaultAmountChangePopView setFrame:CGRectMake(20, 110, SCREEN_WIDTH - 40, 115)];
    [defaultAmountChangePopView layoutIfNeeded];
    [_backgroundView addSubview:defaultAmountChangePopView];
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:defaultAmountChangePopView action:@selector(returnKeyboard)];
    
    [_backgroundView addGestureRecognizer:tapGesture];
    
    passwordChangePopView = [[PasswordChangePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) leftButton:true];
    
    certificateChangePopView = [[CertificateChangePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)initSystemConfigTableView{
//    CGRect contentRect = self.frame;
//    contentRect.size.height -= AUTOHOTTOPIC_HEIGHT;
    
    [contentTableView setFrame:self.frame];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    //    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self addSubview:contentTableView];
}

- (void)loadData {
    NSArray *currencyChooseArray = [[NSArray alloc] initWithObjects:@"CurrencyChoose", nil];
    NSArray *passwordChangeArray = [[NSArray alloc] initWithObjects:@"LoginPasswordChange", nil];
    NSArray *certificateChangeArray = [[NSArray alloc] initWithObjects:@"CertificateChange", nil];
    
    NSArray *openPositionSortArray = [[NSArray alloc] initWithObjects:@"OpenPositionSort",
                                      @"Currency", @"OpenPrice", @"FloatPL", @"TradeTime", nil];
    
    NSArray *orderSortArray = [[NSArray alloc] initWithObjects:@"OrderSort",
                               @"Currency", @"PriceDESC", @"PriceACS", nil];
    
    NSArray *positionSumSortArray = [[NSArray alloc] initWithObjects:@"PositionSumSort",
                                     @"Currency", @"FloatPL", nil];
    
    // 从配置文件中获取
    NSArray *amountArray = [[ClientSystemConfig getInstance] amountCustomArray];
    NSArray *amountConfigArray = [[NSArray alloc] initWithObjects:@"AmountCustom", [amountArray objectAtIndex:0], [amountArray objectAtIndex:1], [amountArray objectAtIndex:2], nil];
    
    //    NSArray *columnConfigArray = [[NSArray alloc] initWithObjects:@"ColumnNotice", @"Highest", @"Lowest", @"UpDown", @"UpDown", @"UpDownPercent", @"UpdateTime", nil];
    NSArray *columnConfigArray = [[NSArray alloc] initWithObjects:@"ColumnNotice", @"Highest", @"Lowest", @"UpDown", @"UpdateTime", nil];
    
    NSArray *rssArray = [[NSArray alloc] initWithObjects:@"RSS", nil];
    
    NSArray *certificateArray = [[NSArray alloc] initWithObjects:@"CertificateManagement", nil];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObject:currencyChooseArray];
    [tempArray addObject:passwordChangeArray];
    [tempArray addObject:certificateArray];
    [tempArray addObject:certificateChangeArray];
    [tempArray addObject:openPositionSortArray];
    [tempArray addObject:orderSortArray];
    [tempArray addObject:positionSumSortArray];
    [tempArray addObject:amountConfigArray];
    [tempArray addObject:columnConfigArray];
    [tempArray addObject:rssArray];
    self.contentArray = tempArray;
    
}

- (void)initData {
    self.contentArray = [[NSMutableArray alloc] init];
}

#pragma tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.contentArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.contentArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    NSString * instrument = [[self.contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    if (cell == nil) {
        //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.textLabel setText:[[LangCaptain getInstance] getLangByCode:instrument]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor whiteColor]];
    //    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/blue1.png"]]];
    [self setBackgroundView:cell indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath section] == CurrencyChoose) {
        // 跳转到货币选择界面
        InstrumentChoosePopView *instrumentChoosePopView = [[InstrumentChoosePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.superview.superview addSubview:instrumentChoosePopView];
        
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_1];
        return;
    }
    
    if ([indexPath section] == PasswordChange) {
        // 跳转到 密码修改界面
        [self.superview.superview addSubview:passwordChangePopView];
        
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_2];
        return;
    }
    
    if ([indexPath section] == CertificateChange) {
        // 跳转到 电话下单密码修改
        [self.superview.superview addSubview:certificateChangePopView];
        
        return;
    }
    
    if ([indexPath section] == OpenPositionSort) {
        
        if ([indexPath row] == 0) {
            return;
        }
        
        switch ([indexPath row]) {
            case 1:
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_3];
                break;
            case 2:
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_4];
                break;
            case 3:
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_5];
                break;
            case 4:
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_6];
                break;
                
            default:
                break;
        }
        
        // 开仓单排序 选择
        [[ClientSystemConfig getInstance] setOpenPositionSortType:[NSNumber numberWithInt:(int)([indexPath row] - 1)]];
        [[ClientSystemConfig getInstance] saveConfigData];
        [contentTableView reloadData];
        return;
    }
    
    if ([indexPath section] == OrderSort) {
        
        if ([indexPath row] == 0) {
            return;
        }
        
        switch ([indexPath row]) {
            case 1:
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_7];
                break;
            case 2:
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_8];
                break;
                
            default:
                break;
        }
        
        // 挂单排序 选择
        [[ClientSystemConfig getInstance] setOrderSortType:[NSNumber numberWithInt:(int)([indexPath row] - 1)]];
        [[ClientSystemConfig getInstance] saveConfigData];
        [contentTableView reloadData];
        return;
    }
    
    if ([indexPath section] == PositionSumSort) {
        
        if ([indexPath row] == 0) {
            return;
        }
        switch ([indexPath row]) {
            case 1:
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_9];
                break;
            case 2:
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_10];
                break;
                
            default:
                break;
        }
        
        // 部位汇总排序 选择
        [[ClientSystemConfig getInstance] setPositionSumSortType:[NSNumber numberWithInt:(int)([indexPath row] - 1)]];
        [[ClientSystemConfig getInstance] saveConfigData];
        [contentTableView reloadData];
        return;
    }
    
    if ([indexPath section] == AmountCustom) {
        
        if ([indexPath row] == 0) {
            return;
        }
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_11];
        
        // 自定义输入金额选择
        
        [defaultAmountChangePopView setIndex:(int)([indexPath row] - 1)];
        [defaultAmountChangePopView setTarget:self];
        
        UIView *rootView = [[[IosLogic getInstance] getWindow] rootViewController].view;
        UIImage *backImage = [ImageUtils imageWithView:rootView];
        backImage = [backImage blurredImageWithRadius:kDefaultRadius iterations:kDefaultIterations tintColor:[UIColor blackColor]];
        _backgroundView.backgroundColor = [UIColor colorWithPatternImage:backImage];
        [rootView addSubview:_backgroundView];
        return;
    }
    
    //    if ([indexPath section] == ColumnChoose) {
    //
    //        // 標題欄不選
    //        if ([indexPath row] == 0) {
    //            return;
    //        }
    //
    //        // 栏位选择
    //        // 若漲跌為false 沒有點的需要了
    //        if (![[[self getColumnChooseArray] objectAtIndex:2] isEqualToString:@"true"]) {
    //            return;
    //        }
    //
    //        if ([indexPath row] != 4 && [indexPath row] != 5) {
    //            return;
    //        }
    //
    //        NSMutableArray *columnArray = [self getColumnChooseArray];
    //
    //        int index = (int)[indexPath row] - 1;
    //        if ([[columnArray objectAtIndex:index] isEqualToString:@"true"]) {
    //            [columnArray replaceObjectAtIndex:index withObject:@"false"];
    //        } else {
    //            [columnArray replaceObjectAtIndex:index withObject:@"true"];
    //
    //        }
    //
    //        [[ClientSystemConfig getInstance] setColumnChooseArray:columnArray];
    //        [[ClientSystemConfig getInstance] saveConfigData];
    //        [self reloadColumnChoose];
    //    }
    
    if ([indexPath section] == Rss) {
        // 跳转到Rss选择界面
        RssResourcePopView *rssResourcePopView = [[RssResourcePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.superview.superview addSubview:rssResourcePopView];
        return;
    }
    
    if ([indexPath section] == Certificate) {
        // 跳转到Rss选择界面
        //        RssResourcePopView *rssResourcePopView = [[RssResourcePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        //        [self.superview.superview addSubview:rssResourcePopView];
        //        CertificatePopView *certi
        CertificatePopView *certificatePopView = [[CertificatePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.superview.superview addSubview:certificatePopView];
        
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

#pragma privateFunc

//- (void)reloadColumnChoose {
//    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
//    [reloadArray addObject:[NSIndexPath indexPathForRow:4 inSection:7]];
//    [reloadArray addObject:[NSIndexPath indexPathForRow:5 inSection:7]];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
//    });
//}

- (void)setBackgroundView:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    int count = (int)[[self.contentArray objectAtIndex:[indexPath section]] count];
    if (count == 1) {
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/blue1.png"]]];
    } else if([indexPath row] == 0){
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/blueDefault.png"]]];
    } else {
        //        int selectIndex = [[[contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] intValue];
        // 返回数据强转
        
        if ([indexPath section] == OpenPositionSort) {
            NSNumber *openPositionType = [self getOpenPositionSort];
            if ([openPositionType intValue] == [indexPath row] - 1) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLight2.png"]]];
            } else {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLightDefault.png"]]];
            }
        }
        
        if ([indexPath section] == OrderSort) {
            NSNumber *orderSortType = [self getOrderSort];
            if ([orderSortType intValue] == [indexPath row] - 1) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLight2.png"]]];
            } else {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLightDefault.png"]]];
            }
        }
        
        if ([indexPath section] == PositionSumSort) {
            NSNumber *positionSumSortType = [self getSumPositionSort];
            if ([positionSumSortType intValue] == [indexPath row] - 1) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLight2.png"]]];
            } else {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLightDefault.png"]]];
            }
        }
        
        if ([indexPath section] == AmountCustom) {
            [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLight1.png"]]];
        }
        
        
        if ([indexPath section] == ColumnChoose) {
            
            NSString *chooseBool = [[self getColumnChooseArray] objectAtIndex:[indexPath row] - 1];
            //            if ([chooseBool isEqualToString:@"true"]) {
            //            if ([indexPath row] == 1 || [indexPath row] == 2 || [indexPath row] == 3 || [indexPath row] == 6) {
            
            // 设定指定view
            UISwitch *mSwitch = (UISwitch *)[cell viewWithTag:SwitchTag];
            if (mSwitch == nil) {
                mSwitch = [self getSwitch];
                CGPoint point = CGPointMake(SCREEN_WIDTH - 30.0f, cell.frame.size.height / 2);
                [mSwitch setCenter:point];
                [mSwitch setTag:SwitchTag];
                [cell addSubview:mSwitch];
            }
            
            [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLightDefault.png"]]];
            if ([chooseBool isEqualToString:@"true"]) {
                [mSwitch setOn:true];
            } else {
                [mSwitch setOn:false];
            }
        }
        //            if ([indexPath row] == 4 ||[indexPath row] ==  5) {
        //                if ([[[self getColumnChooseArray] objectAtIndex:2] isEqualToString:@"true"]) {
        //                    if ([chooseBool isEqualToString:@"true"]) {
        //                        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayHeavy2.png"]]];
        //                    } else {
        //                        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayHeavyDefault.png"]]];
        //                    }
        //                } else {
        //                    if ([chooseBool isEqualToString:@"true"]) {
        //                        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLight2.png"]]];
        //                    } else {
        //                        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLightDefault.png"]]];
        //                    }
        //                }
        //            }
        //        }
        
        [cell addHeaderBottomLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    }
}

- (UISwitch *)getSwitch {
    UISwitch *mswitch = [UISwitch new];
    [mswitch setOnTintColor:[UIColor yellowColor]];
    [mswitch setTintColor:[UIColor grayColor]];
    [mswitch setBackgroundColor:[UIColor grayColor]];
    [mswitch.layer setCornerRadius:15.0f];
    [mswitch addTarget:self action:@selector(switchSelect:) forControlEvents:UIControlEventTouchUpInside];
    return mswitch;
}

- (void)switchSelect:(id)sender {
    //    int index = (int)[[contentTableView indexPathForCell:(UITableViewCell *)[(UISwitch *)sender superview]] row];
    //    NSMutableArray *columnArray = [self getColumnChooseArray];
    //    NSString *temp = [columnArray objectAtIndex:index - 1];
    //    if ([temp isEqualToString:@"true"]) {
    //        temp = @"false";
    //        // 是否顯示漲跌
    //        if (index == 3) {
    //            [columnArray replaceObjectAtIndex:index withObject:@"false"];
    //            [columnArray replaceObjectAtIndex:index + 1 withObject:@"false"];
    //        }
    //    } else {
    //        temp = @"true";
    //    }
    //    [columnArray replaceObjectAtIndex:index - 1 withObject:temp];
    //    [[ClientSystemConfig getInstance] setColumnChooseArray:columnArray];
    //    [[ClientSystemConfig getInstance] saveConfigData];
    //    [self reloadColumnChoose];
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_12];
    int index = (int)[[contentTableView indexPathForCell:(UITableViewCell *)[(UISwitch *)sender superview]] row];
    NSMutableArray *columnArray = [self getColumnChooseArray];
    NSString *temp = [columnArray objectAtIndex:index - 1];
    if ([temp isEqualToString:@"true"]) {
        temp = @"false";
    } else {
        temp = @"true";
    }
    [columnArray replaceObjectAtIndex:index - 1 withObject:temp];
    [[ClientSystemConfig getInstance] setColumnChooseArray:columnArray];
    [[ClientSystemConfig getInstance] saveConfigData];
}



#pragma getSetFunc
//- (NSArray *)getUnselectInstrumentArray {
//    return [[ClientSystemConfig getInstance] unselectInstrumentArray];
//}

- (NSNumber *)getOpenPositionSort {
    return [[ClientSystemConfig getInstance] openPositionSortType];
}

- (NSNumber *)getOrderSort {
    return [[ClientSystemConfig getInstance] orderSortType];
}

- (NSNumber *)getSumPositionSort {
    return [[ClientSystemConfig getInstance] positionSumSortType];
}

- (NSArray *)getAmountCustomArray {
    return [[ClientSystemConfig getInstance] amountCustomArray];
}

- (NSMutableArray *)getColumnChooseArray {
    return [[ClientSystemConfig getInstance] columnChooseArray];
}
//- (id)getDataBySection:(NSInteger)section {
//    switch (section) {
////        case CurrencyChoose:
////            // 货币对选择
////            return [[ClientSystemConfig getInstance] unselectInstrumentArray];
////            break;
////        case PasswordChange:
////            // 密码修改
////            return nil;
////            break;
////        case CertificateChange:
////            // 凭证密码修改
////            return nil;
////            break;
//        case OpenPositionSort:
//            return [[ClientSystemConfig getInstance] openPositionSortType];
//            // 开仓单排序
//            break;
//        case OrderSort:
//            // 挂单排序
//            return [[ClientSystemConfig getInstance] orderSortType];
//            break;
//        case PositionSumSort:
//            // 部位汇总排序
//            return [[ClientSystemConfig getInstance] positionSumSortType];
//            break;
//        case AmountCustom:
//            // 自定输入金额
//            return [[ClientSystemConfig getInstance] amountCustomArray];
//            break;
//        case ColumnChoose:
//            // 报价栏位显示
//            break;
//        default:
//            break;
//    }
//}

#pragma public Func
- (void)tableUpdate {
    [self loadData];
    [contentTableView reloadData];
}

@end
