//
//  FreezeTableView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "FreezeTableView.h"
#import "UIView+FreezeTableView.h"
#import "FreezeScrollView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "MarketTradeViewController.h"
#import "QuoteView.h"
#import "IosLogic.h"
#import "IosLayoutDefine.h"
#import "ScreenAuotoSizeScale.h"
#import "OrderAddOrModifyViewController.h"
#import "QuotePopButtonView.h"
#import "OrderAddOrModifyContentView.h"
#import "APIDoc.h"
#import "KChartParam.h"
#import "KChartView.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

#define FreezeTableView_CornerRadius 0.0f
#define FreezeTableView_BorderWidth 0.0f
#define FreezeTableView_BoraerColorGray 212.0f/255.0f

#define FreezeTableView_DefaultCellWidth 250.0f
#define FreezeTableView_DefaultCellHeight 50.0f
#define FreezeTableView_DefaultTopHeaderHeight 30.0f
#define FreezeTableView_DefaultLeftHeaderWidth [ScreenAuotoSizeScale CGAutoMakeFloat:130.0f]
//#define FreezeTableView_DefaultLeftHeaderWidth 110.0f
#define FreezeTableView_DefaultSectionHeaderHeight [ScreenAuotoSizeScale CGAutoMakeFloat:30.0f]
#define FreezeTableView_DefaultBoldLineWidth 0.0f // tableView边界宽度
#define FreezeTableView_DefaultNormalVLineWidth 0.0f //cell 纵向边界宽度
#define FreezeTableView_DefaultNormalHLineWidth 0.8f//cell 横向边界宽度
#define FreezeTableView_DefaultLineGray 223.0f/255.0f

#define AddHeightTo(v, h) { CGRect f = v.frame; f.size.height += h; v.frame = f; }

#define QUOTE_OFFSET 7
#define UpDown_OFFSET 5

#define CellHeighOffSet 20

#define PopCellHeigh 30

static Boolean UpDownPriceOrUpDownPricePercent = true;

typedef NS_ENUM(NSUInteger, TableColumnSortType) {
    TableColumnSortTypeAsc,
    TableColumnSortTypeDesc,
    TableColumnSortTypeNone
};

@interface FreezeTableView()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, TradeEvent>{
    Boolean leftTableCellInited;
    Boolean rightTableCellInited;
    
    NSInteger selectIndex;
    
    //    UIButton *_addButton;
    QuotePopButtonView *_addButtonView;
    
    UILongPressGestureRecognizer *longPressGesture;
    UITapGestureRecognizer *tapPressGesture;
    
    CGRect portraitNormalRect;
    CGRect portraitPopedRect;
    CGRect landscapeRect;
}
- (void)reset;
- (void)adjustView;
- (void)setUpTopHeaderScrollView;
- (void)accessColumnPointCollection;

- (CGFloat)accessContentTableViewCellWidth:(NSUInteger)column;
- (UITableViewCell *)leftHeaderTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)contentTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation FreezeTableView{
    FreezeScrollView *topHeaderScrollView;
    FreezeScrollView *contentScrollView;
    UITableView *leftHeaderTableView;
    UITableView *contentTableView;
    UIView *vertexView;
    
    //    NSMutableDictionary *sectionFoldedStatus;
    //纵向长度
    NSArray *columnPointCollection;
    NSArray *contentDataArray;
    
    //cellDictionary
    //    NSMutableDictionary *leftCellDic;
    //    NSMutableDictionary *contentCellDic;
    
    BOOL responseToNumberSections;
    BOOL responseContentTableCellWidth;
    BOOL responseNumberofContentColumns;
}

@synthesize cellWidth,
cellHeight, topHeaderHeight, leftHeaderWidth, boldSeperatorLineWidth, normalSeperatorVLineWidth, normalSeperatorHLineWidth;
@synthesize boldSeperatorLineColor, normalSeperatorLineColor;

@synthesize leftHeaderEnable;

@synthesize datasource;

#pragma freeztableViewFunc
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        portraitNormalRect = frame;
        //        landscapeRect = frame;
        frame.size.height -= 400.0f - buttonHeight - FIXHOTTOPIC_HEIGHT;
        portraitPopedRect = frame;
        
        selectIndex = -1;
        
        _addButtonView = [[QuotePopButtonView alloc] init];
        [_addButtonView.leftButton addTarget:self action:@selector(jumpToOrderPosition) forControlEvents:UIControlEventTouchUpInside];
        [_addButtonView.rightButton addTarget:self action:@selector(jumpToPriceWarning) forControlEvents:UIControlEventTouchUpInside];
        
        [self initPressGesture];
        
        leftTableCellInited = false;
        rightTableCellInited = false;
        
        self.layer.borderColor = [[UIColor colorWithWhite:FreezeTableView_BoraerColorGray alpha:1.0f] CGColor];
        self.layer.cornerRadius = FreezeTableView_CornerRadius;
        self.layer.borderWidth = FreezeTableView_BorderWidth;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
        self.contentMode = UIViewContentModeRedraw;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        cellWidth = FreezeTableView_DefaultCellWidth;
        cellHeight = FreezeTableView_DefaultCellHeight;
        topHeaderHeight = FreezeTableView_DefaultTopHeaderHeight;
        leftHeaderWidth = FreezeTableView_DefaultLeftHeaderWidth;
        
        boldSeperatorLineWidth = FreezeTableView_DefaultBoldLineWidth;
        normalSeperatorVLineWidth = FreezeTableView_DefaultNormalVLineWidth;
        normalSeperatorHLineWidth = FreezeTableView_DefaultNormalHLineWidth;
        
        boldSeperatorLineColor = [UIColor colorWithWhite:FreezeTableView_DefaultLineGray alpha:1.0];
        normalSeperatorLineColor = [UIColor colorWithWhite:FreezeTableView_DefaultLineGray alpha:1.0];
        
        vertexView = [[UIView alloc] initWithFrame:CGRectZero];
        vertexView.backgroundColor = [UIColor clearColor];
        vertexView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:vertexView];
        
        topHeaderScrollView = [[FreezeScrollView alloc] initWithFrame:CGRectZero];
        topHeaderScrollView.backgroundColor = [UIColor clearColor];
        topHeaderScrollView.parent = self;
        topHeaderScrollView.delegate = self;
        topHeaderScrollView.showsHorizontalScrollIndicator = NO;
        topHeaderScrollView.showsVerticalScrollIndicator = NO;
        topHeaderScrollView.bounces = NO;
        topHeaderScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:topHeaderScrollView];
        
        leftHeaderTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        leftHeaderTableView.dataSource = self;
        leftHeaderTableView.delegate = self;
        //        leftHeaderTableView.allowsSelection = NO;
        leftHeaderTableView.showsHorizontalScrollIndicator = NO;
        leftHeaderTableView.showsVerticalScrollIndicator = NO;
        leftHeaderTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        leftHeaderTableView.bounces = NO;
        leftHeaderTableView.separatorStyle = NO;
        leftHeaderTableView.backgroundColor = [UIColor clearColor];
        //        [leftHeaderTableView addGestureRecognizer:longPressGesture];
        [self addSubview:leftHeaderTableView];
        
        contentScrollView = [[FreezeScrollView alloc] initWithFrame:CGRectZero];
        contentScrollView.backgroundColor = [UIColor clearColor];
        contentScrollView.parent = self;
        contentScrollView.delegate = self;
        contentScrollView.bounces = NO;
        contentScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:contentScrollView];
        
        contentTableView = [[UITableView alloc] initWithFrame:contentScrollView.bounds];
        contentTableView.dataSource = self;
        contentTableView.delegate = self;
        contentTableView.bounces = NO;
        contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        contentTableView.backgroundColor = [UIColor clearColor];
        
        [contentScrollView addSubview:contentTableView];
        
        //        leftCellDic = [[NSMutableDictionary alloc] init];
        //        contentCellDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat superWidth = self.bounds.size.width;
    CGFloat superHeight = self.bounds.size.height;
    
    if (leftHeaderEnable) {
        vertexView.frame = CGRectMake(0, 0, leftHeaderWidth, topHeaderHeight);
        topHeaderScrollView.frame = CGRectMake(leftHeaderWidth + boldSeperatorLineWidth, 0, superWidth - leftHeaderWidth - boldSeperatorLineWidth, topHeaderHeight);
        leftHeaderTableView.frame = CGRectMake(0, topHeaderHeight + boldSeperatorLineWidth, leftHeaderWidth, superHeight - topHeaderHeight - boldSeperatorLineWidth);
        contentScrollView.frame = CGRectMake(leftHeaderWidth + boldSeperatorLineWidth, topHeaderHeight + boldSeperatorLineWidth, superWidth - leftHeaderWidth - boldSeperatorLineWidth, superHeight - topHeaderHeight - boldSeperatorLineWidth);
    }else {
        topHeaderScrollView.frame = CGRectMake(0, 0, superWidth, topHeaderHeight);
        contentScrollView.frame = CGRectMake(0, topHeaderHeight + boldSeperatorLineWidth, superWidth, superHeight - topHeaderHeight - boldSeperatorLineWidth);
    }
    
    //    [self hiddenCell];
    
    
    [self adjustView];
}

- (void)reloadData {
    [leftHeaderTableView reloadData];
    [contentTableView reloadData];
}

- (void)updateCellQuoteAtIndex:(int)index{
    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
    [reloadArray addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
        [leftHeaderTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
    });
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, boldSeperatorLineWidth);
    CGContextSetAllowsAntialiasing(context, false);
    CGContextSetStrokeColorWithColor(context, [boldSeperatorLineColor CGColor]);
    
    if (leftHeaderEnable) {
        CGFloat x = leftHeaderWidth + boldSeperatorLineWidth / 2.0f;
        CGContextMoveToPoint(context, x, 0.0f);
        CGContextAddLineToPoint(context, x, self.bounds.size.height);
        CGFloat y = topHeaderHeight + boldSeperatorLineWidth / 2.0f;
        CGContextMoveToPoint(context, 0.0f, y);
        CGContextAddLineToPoint(context, self.bounds.size.width, y);
    }else {
        CGFloat y = topHeaderHeight + boldSeperatorLineWidth / 2.0f;
        CGContextMoveToPoint(context, 0.0f, y);
        CGContextAddLineToPoint(context, self.bounds.size.width, y);
    }
    
    CGContextStrokePath(context);
}

- (void)dealloc {
    topHeaderScrollView = nil;
    contentScrollView = nil;
    leftHeaderTableView = nil;
    contentTableView = nil;
    vertexView = nil;
    columnPointCollection = nil;
}

#pragma mark - property

- (void)setDatasource:(id<FreezeTableViewDataSource>)datasource_ {
    
    if (datasource_ == nil) {
        datasource = nil;
    }
    
    if (datasource != datasource_) {
        datasource = datasource_;
        
        responseToNumberSections = [datasource_ respondsToSelector:@selector(numberOfSectionsInTableView:)];
        responseContentTableCellWidth = [datasource_ respondsToSelector:@selector(tableView:contentTableCellWidth:)];
        responseNumberofContentColumns = [datasource_ respondsToSelector:@selector(arrayDataForTopHeader)];
        
        [self reset];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableView *target = nil;
    //    if (tableView == leftHeaderTableView) {
    //        target = contentTableView;
    //    }else if (tableView == contentTableView) {
    //        target = leftHeaderTableView;
    //    }else {
    //        target = nil;
    //    }
    //    [target selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectIndex == [indexPath row]) {
        return PopCellHeigh + cellHeight;
    }
    return cellHeight;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return contentDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == leftHeaderTableView) {
        return [self leftHeaderTableView:tableView cellForRowAtIndexPath:indexPath];
    }else {
        return [self contentTableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIScrollView *target = nil;
    if (scrollView == leftHeaderTableView) {
        target = contentTableView;
    }else if (scrollView == contentTableView) {
        target = leftHeaderTableView;
    }else if (scrollView == contentScrollView) {
        target = topHeaderScrollView;
    }else if (scrollView == topHeaderScrollView) {
        target = contentScrollView;
    }
    CGFloat move = scrollView.contentOffset.y - target.contentOffset.y;
    target.contentOffset = scrollView.contentOffset;
    
    //    NSLog(@"%f, %f", target.contentInset)
    CGRect frame = _addButtonView.frame;
    frame.origin.y -= move;
    _addButtonView.frame = frame;
    //    [self hiddenCell];
    CGRect bounds = _addButtonView.bounds;
    bounds.size.width += 10.0f;
    if (frame.origin.y <= topHeaderHeight + FloatPLStatusHeight) {
        bounds.origin.y = -frame.origin.y + topHeaderHeight + FloatPLStatusHeight;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:bounds];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _addButtonView.bounds;
    maskLayer.path = maskPath.CGPath;
    _addButtonView.layer.mask = maskLayer;
    //    _addButtonView.layer.masksToBounds = NO;
    
}

#pragma mark - private method

- (void)reset {
    
    [self accessDataSourceData];
    
    vertexView.backgroundColor = [UIColor backgroundColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = [[LangCaptain getInstance] getLangByCode:@"CCY"];
    [label setTextColor:[UIColor titleColor]];
    [label sizeToFit];
    
    [label setCenter:CGPointMake(leftHeaderWidth / 2 - 23,
                                 topHeaderHeight / 2)];
    [vertexView addSubview:label];
    
    [self accessColumnPointCollection];
    [self setUpTopHeaderScrollView];
    [contentScrollView reDraw];
}

- (void)adjustView {
    CGFloat width = 0.0f;
    NSUInteger count = [datasource arrayDataForTopHeader].count;
    for (int i = 1; i <= count + 1; i++) {
        if (i == count + 1) {
            width += normalSeperatorVLineWidth;
        }else {
            width += normalSeperatorVLineWidth + [self accessContentTableViewCellWidth:i - 1];
        }
    }
    
    topHeaderScrollView.contentSize = CGSizeMake(width, topHeaderHeight);
    contentScrollView.contentSize = CGSizeMake(width, self.bounds.size.height - topHeaderHeight - boldSeperatorLineWidth);
    
    contentTableView.frame = CGRectMake(0.0f, 0.0f, width, self.bounds.size.height - topHeaderHeight - boldSeperatorLineWidth);
}

- (void)setUpTopHeaderScrollView {
    
    NSUInteger count = [datasource arrayDataForTopHeader].count;
    for (int i = 0; i < count; i++) {
        
        CGFloat topHeaderW = [self accessContentTableViewCellWidth:i];
        CGFloat topHeaderH = topHeaderHeight;
        
        CGFloat widthP = [[columnPointCollection objectAtIndex:i] floatValue];
        
        //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, topHeaderW, topHeaderH)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, topHeaderW - 10.0f, topHeaderH)];
        label.clipsToBounds = YES;
        label.center = CGPointMake(widthP - 5.0f, topHeaderH / 2.0f);
        label.tag = i;
        label.text = [[datasource arrayDataForTopHeader] objectAtIndex:i];
        [label setTextColor:[UIColor titleColor]];
        if (i >= 2) {
            [label setTextAlignment:NSTextAlignmentRight];
        } else {
            [label setTextAlignment:NSTextAlignmentCenter];
        }
        
        UIColor *color = [UIColor backgroundColor];
        label.backgroundColor = color;
        // 涨跌
        if (i == 4) {
            UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapPressToDo:)];
            [label addGestureRecognizer:tapPress];
            label.userInteractionEnabled = true;
        }
        
        [topHeaderScrollView addSubview:label];
    }
    
    [topHeaderScrollView reDraw];
    
}

- (void)accessColumnPointCollection {
    NSUInteger columns = responseNumberofContentColumns ? [datasource arrayDataForTopHeader].count : 0;
    if (columns == 0)
        NSLog(@"number of content columns must more than 0");
    NSMutableArray *tmpAry = [NSMutableArray array];
    CGFloat widthColumn = 0.0f;
    CGFloat widthP = 0.0f;
    for (int i = 0; i < columns; i++) {
        CGFloat columnWidth = [self accessContentTableViewCellWidth:i];
        widthColumn += (normalSeperatorVLineWidth + columnWidth);
        widthP = widthColumn - columnWidth / 2.0f;
        [tmpAry addObject:[NSNumber numberWithFloat:widthP]];
    }
    columnPointCollection = [tmpAry copy];
}

- (CGFloat)accessContentTableViewCellWidth:(NSUInteger)column {
    return responseContentTableCellWidth ? [datasource tableView:self contentTableCellWidth:column] : cellWidth;
}

- (UITableViewCell *)leftHeaderTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *LeftCellIndentifier = @"FreezeLeftTableViewCell";
    //    if(!leftTableCellInited){
    //        UINib *nib=[UINib nibWithNibName:@"FreezeLeftTableViewCell" bundle:nil];
    //        [tableView registerNib:nib forCellReuseIdentifier:LeftCellIndentifier];
    //        leftTableCellInited = true;
    //    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //    QuoteItem *quoteItem = [contentDataArray objectAtIndex:[indexPath row]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LeftCellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addHeaderTopLineWithWidth:normalSeperatorHLineWidth bgColor:normalSeperatorLineColor];
    }
    
    QuoteItem *item = [contentDataArray objectAtIndex:indexPath.row];
    //    cell = [tableView dequeueReusableCellWithIdentifier:LeftCellIndentifier];
    
    
    [self updateLeftCell:cell withQuoteItem:item];
    return cell;
}

- (UITableViewCell *)contentTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    QuoteItem *quoteItem = [contentDataArray objectAtIndex:[indexPath row]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addTopLineWithWidth:normalSeperatorHLineWidth bgColor:normalSeperatorLineColor];
    }
    
    [self updateContentCell:cell withQuoteItem:quoteItem];
    
    return cell;
}

- (void)updateLeftCell:(UITableViewCell *)cell withQuoteItem:(QuoteItem *)quoteItem{
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 不知道为什么不能使用nib里面的控件  以后解决
    //    UILabel *instrumentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 11, 64, 21)];
    UILabel *instrumentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [instrumentLabel setTextColor:[UIColor whiteColor]];
    [instrumentLabel setText:[quoteItem instrument]];
    [instrumentLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:18.0f]]];
    [instrumentLabel sizeToFit];
    [instrumentLabel setFrame:CGRectMake([ScreenAuotoSizeScale CGAutoMakeFloat:10], 13, instrumentLabel.frame.size.width, instrumentLabel.frame.size.height)];
    
    CGPoint centerPoint =  [instrumentLabel center];
    centerPoint.y = (FreezeTableView_DefaultCellHeight + CellHeighOffSet) / 2;
    [instrumentLabel setCenter:centerPoint];
    [cell.contentView addSubview:instrumentLabel];
    
    
    
    //    CGFloat x = instrumentLabel.frame.origin.x + instrumentLabel.frame.size.width + UpDown_OFFSET;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(100, 10, 12, 15)]];
    centerPoint = [imageView center];
    centerPoint.y = (FreezeTableView_DefaultCellHeight + CellHeighOffSet) / 2;
    [imageView setCenter:centerPoint];
    
    int upOrDown = [quoteItem upDown];
    if (upOrDown == UP) {
        [imageView setImage:[UIImage imageNamed:@"images/normal/up.png"]];
    } else if(upOrDown == NORMAL) {
        [imageView setImage:[UIImage imageNamed:@"images/normal/normal.png"]];
    } else if (upOrDown == DOWN){
        [imageView setImage:[UIImage imageNamed:@"images/normal/down.png"]];
    }
    [cell.contentView addSubview:imageView];
    
    [cell setBackgroundColor:[UIColor backgroundColor]];
}

- (void)updateContentCell:(UITableViewCell *)cell withQuoteItem:(QuoteItem *)quoteItem {
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger count = [datasource arrayDataForTopHeader].count;
    // 有点乱 以后整理
    for (int i = 0; i < count; i++) {
        
        CGFloat cellW = [self accessContentTableViewCellWidth:i];
        CGFloat cellH = cellHeight + CellHeighOffSet;
        CGFloat width = [[columnPointCollection objectAtIndex:i] floatValue];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellW, cellH)];
        view.center = CGPointMake(width, cellH / 2.0f);
        view.clipsToBounds = YES;
        
        //                QuoteView *quoteView = [[QuoteView alloc] initWithFrame:CGRectMake(0, QUOTE_OFFSET, cellW, cellH - QUOTE_OFFSET * 2)];
        QuoteView *quoteView = [[QuoteView alloc] initWithFrame:CGRectMake(0, QUOTE_OFFSET, cellW, cellW / 3.5)];
        quoteView.center = CGPointMake(width, cellH / 2.0f);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        NSString *labelValue = nil;
        switch (i) {
            case 0:
                labelValue = [quoteItem bid];
                break;
            case 1:
                labelValue = [quoteItem ask];
                break;
            case 2:
                labelValue = [quoteItem highPrice];
                break;
            case 3:
                labelValue = [quoteItem lowPricel];
                break;
                //            case 4:
                //                // 空
                //                labelValue = @"";
                //                break;
            case 4:
                labelValue = UpDownPriceOrUpDownPricePercent ? [quoteItem upDownPrice] : [quoteItem upDownPricePercent];
                break;
                //            case 5:
                //                labelValue = [quoteItem upDownPricePercent];
                //                break;
            case 5:
                labelValue = [quoteItem quoteTime];
                break;
            default:
                break;
        }
        
        // colum 0 1 为行情对子
        if (i != 0 && i != 1) {
            label.text = labelValue;
            [label setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:20.0f]]];
            
            //            [label sizeToFit];
            [label setFrame:CGRectMake(0, 0, cellW - 10.0f, cellH)];
            label.center = CGPointMake(cellW / 2.0f - 5.0f, cellH / 2.0f);
            
            view.backgroundColor = [UIColor clearColor];
            label.backgroundColor = [UIColor clearColor];
            [label setTextColor:[UIColor whiteColor]];
            
            [label setTextAlignment:NSTextAlignmentRight];
            
            [view addSubview:label];
            [cell.contentView addSubview:view];
        } else {
            [cell.contentView setBackgroundColor:[UIColor backgroundColor]];
            [quoteView setInstrument:[quoteItem instrument]];
            [quoteView setIsBuySell:i];
            [quoteView setBackgroundColor:[UIColor backgroundColor]];
            [quoteView setPrice:labelValue extraDigit:[quoteItem extradigit]];
            [quoteView setDelegate:self];
            [cell.contentView addSubview:quoteView];
            
            if ([quoteItem upDown] == UP) {
                [quoteView setColor:[UIColor greenUpColor]];
            } else if([quoteItem upDown] == DOWN) {
                [quoteView setColor:[UIColor redDownColor]];
            } else{
                [quoteView setColor:[UIColor whiteColor]];
            }
        }
    }
    
    //    if (isShow) {
    //        UIButton *addView = [[UIButton alloc] initWithFrame:CGRectMake(-100, 50, 200, 30)];
    //        [addView addTarget:self action:@selector(cl) forControlEvents:UIControlEventTouchUpInside];
    //        [addView setBackgroundColor:[UIColor whiteColor]];
    //        [cell.superview addSubview:addView];
    //    }
}

- (void)jumpToOrderPosition{
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_1];

    QuoteItem *item = [contentDataArray objectAtIndex:selectIndex];
    //    [OrderAddOrModifyViewController setInstrument:[item instrument]];
    [[DataCenter getInstance] setOrder:nil];
    [[DataCenter getInstance] setOrderInstrument:[item instrument]];
    [[IosLogic getInstance] gotoOrderAddOrModifyViewController];
}

- (void)jumpToPriceWarning {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_2];
    
    QuoteItem *item = [contentDataArray objectAtIndex:selectIndex];
    [[DataCenter getInstance] setPriceWarning:nil];
    [[DataCenter getInstance] setPriceWarningInstrument:[item instrument]];
    [[IosLogic getInstance] gotoPriceWarningAddOrModifyViewController];
}

#pragma tradeEvebt delegate
- (void)touchedTradeEvent:(NSString *)instrument buySell:(int)buySell{
    [MarketTradeViewController setInstrumentName:instrument];
    [MarketTradeViewController setBuySell:buySell];
    [[IosLogic getInstance] gotoMarketTradeViewController];
}

#pragma mark - other method

- (void)accessDataSourceData {
    contentDataArray = [datasource arrayDataForContent];
}

#pragma PressGesture
- (void)initPressGesture{
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressToDo:)];
    longPressGesture.minimumPressDuration = 0.5;
    
    tapPressGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popKChartViewAction:)];
}

- (void)addLongPressGesture {
    [contentTableView addGestureRecognizer:longPressGesture];
}

- (void)removeLongPressGesture {
    [contentTableView removeGestureRecognizer:longPressGesture];
}

- (void)addTapPressGesture {
    [leftHeaderTableView addGestureRecognizer:tapPressGesture];
}

- (void)removeTapPressGesture {
    [leftHeaderTableView removeGestureRecognizer:tapPressGesture];
}

-(void)LongPressToDo:(UIGestureRecognizer *)gesture{
    
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:contentTableView];
        NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        if ([indexPath row] == selectIndex) {
            [self hiddenCell];
            return;
        } else {
            [_addButtonView setHidden:false];
        }
        [self popCellLogic:indexPath];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
    }
}

- (void)TapPressToDo:(UIGestureRecognizer *)gesture {
    UpDownPriceOrUpDownPricePercent = !UpDownPriceOrUpDownPricePercent;
    UILabel *label = (UILabel *)[topHeaderScrollView viewWithTag:4];
    if (UpDownPriceOrUpDownPricePercent) {
        [label setText:[[LangCaptain getInstance] getLangByCode:@"UpDown"]];
    } else {
        [label setText:[[LangCaptain getInstance] getLangByCode:@"UpDownPercent"]];
    }
    [contentTableView reloadData];
}

- (void)popKChartViewAction:(UIGestureRecognizer *)gesture {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_3];
    CGPoint point = [gesture locationInView:leftHeaderTableView];
    NSIndexPath * indexPath = [leftHeaderTableView indexPathForRowAtPoint:point];
    QuoteItem *item = [contentDataArray objectAtIndex:[indexPath row]];
    NSString *instrumentName = [item instrument];
    
    [((LeftViewController *)[[[IosLogic getInstance] getWindow] rootViewController]) popKChartView:instrumentName];
    
//    [leftHeaderTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)popCellLogic:(NSIndexPath *)indexPath {
    selectIndex = [indexPath row];
    NSIndexPath *path = [NSIndexPath indexPathForRow:selectIndex inSection:0];
    [contentTableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
    [leftHeaderTableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
    
    CGRect rectInTableView = [leftHeaderTableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [leftHeaderTableView convertRect:rectInTableView toView:[leftHeaderTableView superview]];
    [_addButtonView setFrame:CGRectMake(10, rect.origin.y + topHeaderHeight + cellHeight, SCREEN_WIDTH - 20, PopCellHeigh)];
    [_addButtonView setBackgroundColor:[UIColor blackColor]];
    [[[leftHeaderTableView superview] superview] addSubview:_addButtonView];
    
    [self rebackLayer];
    
    if (selectIndex == contentDataArray.count - 1) {
        [leftHeaderTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:contentDataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)hiddenCell {
    NSIndexPath *path = [NSIndexPath indexPathForRow:selectIndex inSection:0];
    selectIndex = -1;
    [contentTableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
    [leftHeaderTableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
    [_addButtonView setHidden:true];
}

- (void)rebackLayer {
    CGRect bounds = _addButtonView.bounds;
    bounds.size.width += 10.0f;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:bounds];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _addButtonView.bounds;
    maskLayer.path = maskPath.CGPath;
    _addButtonView.layer.mask = maskLayer;
    _addButtonView.layer.masksToBounds = NO;
}

- (void)setFreezeTableViewState:(int)state {
    if (IsPortrait) {
        switch (state) {
            case Landscape:
                [self autoPortraitNormal];
                break;
            case PortraitNormal:
                [self autoPortraitNormal];
                break;
            case PortraitPoped:
                [self autoPortraitPoped];
                break;
                
            default:
                break;
        }
    } else {
        switch (state) {
            case PortraitNormalForce:
                [self autoPortraitNormal];
                break;
            case PortraitPopedForce:
                [self autoPortraitPoped];
                break;
            default:
                break;
        }
    }
}

- (void)autoLandscape {
    //    [self setFrame:landscapeRect];
    //    [self setFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
}

- (void)autoPortraitNormal {
    //    CGRect rect = self.frame;
    //    if (rect.size.height < 400.0f) {
    //        rect.size.height += 400.0f - buttonHeight;
    //    }
    [self setFrame:portraitNormalRect];
}

- (void)autoPortraitPoped {
    [self setFrame:portraitPopedRect];
}

@end
