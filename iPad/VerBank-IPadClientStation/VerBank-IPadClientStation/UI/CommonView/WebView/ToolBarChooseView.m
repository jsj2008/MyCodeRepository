//
//  ToolBarChooseView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/10.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "ToolBarChooseView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"

#import "KChartWebView.h"
#import "UIView+AddLine.h"
#import "TiArgumentConfig.h"
#import "MAData.h"
#import "ParamTable.h"

//#import "KChartParam.h"
//#import "KChartView.h"
//#import "TiArgumentConfig.h"
//#import "MAData.h"

#define MaxHeight 170
#define CellHeight 40
//#define CellHeight 60

#define ImageTag 101
#define CellTextTag 102

@interface ToolBarChooseView()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *_contentTableView;
    //    id <chooseProtocol>_delegate;
    NSArray *_contentArray;
    //    int _type;
    //    TiArgumentConfig *tiArgumentConfig;
    
    ChooseType _currentChooseType;
}

@end

@implementation ToolBarChooseView

@synthesize subChooseView;

@synthesize saveData;

- (id)init {
    if (self = [super init]) {
        [self initTableView];
        [self initDefault];
    }
    return self;
}

- (void)initTableView {
    _contentTableView = [[UITableView alloc] init];
    _contentTableView.bounces = NO;
    _contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //        mTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [_contentTableView scrollsToTop];
    [_contentTableView setBackgroundColor:[UIColor blackColor]];
    [_contentTableView setDelegate:self];
    [_contentTableView setDataSource:self];
    _contentTableView.layer.cornerRadius = 5.0f;
    [self addSubview:_contentTableView];
}

- (void)initDefault {
    self.layer.cornerRadius = 5.0f;
    _currentChooseType = ChooseTypeUnknow;
}

- (void)setDelegate:(id<chooseProtocol>)delegate {
    _delegate = delegate;
}

- (void)showWithType:(ChooseType)type {
    _currentChooseType = type;
    [self setHidden:false];
    CGFloat superViewWidth = self.superview.frame.size.width;
    CGFloat superViewHeight = self.superview.frame.size.height;
    CGFloat tableViewX = superViewWidth / 7 * 0.5;
    switch (_currentChooseType) {
        case ChooseTypeCandleStickType:
            _contentArray = [self getKChartTypeArray];
            tableViewX = superViewWidth / 7 * 0.5;
            break;
        case ChooseTypeCycleChooseType:
            _contentArray = [self getCycleTypeArray];
            tableViewX = superViewWidth / 7 * 1.5;
            break;
        case ChooseTypeDrawType:
            _contentArray = [self getDrawTypeArray];
            tableViewX = superViewWidth / 7 * 2.5;
            break;
        case ChooseTypeTechnologyType:
            _contentArray = [self getTechnologyArray];
            tableViewX = superViewWidth / 7 * 3.5;
            break;
        case ChooseTypeMaSubArrayType:
            _contentArray = [self getMASubChooseArray];
            tableViewX = superViewWidth / 7 * 5;
            break;
        default:
            break;
    }
    
    CGFloat count = [_contentArray count] > 4 ? 4 : [_contentArray count];
    
    CGFloat tableViewHeight = CellHeight * count;
    CGFloat tableViewWidth  = SCREEN_WIDTH / 7 * 1.5;
    CGFloat tableViewY = superViewHeight - tableViewHeight - 40;
    [self setFrame:CGRectMake(tableViewX, tableViewY, tableViewWidth, tableViewHeight)];
    
    [_contentTableView reloadData];
}

- (NSArray *)getCycleTypeArray {
    NSNumber *min1 = [[NSNumber alloc] initWithInt:ChartCycleMin1];
    NSNumber *min5 = [[NSNumber alloc] initWithInt:ChartCycleMin5];
    //    NSNumber *min10 = [[NSNumber alloc] initWithInt:303];
    NSNumber *min15 = [[NSNumber alloc] initWithInt:ChartCycleMin15];
    NSNumber *min30 = [[NSNumber alloc] initWithInt:ChartCycleMin30];
    NSNumber *min60 = [[NSNumber alloc] initWithInt:ChartCycleMin60];
    //    NSNumber *min90 = [[NSNumber alloc] initWithInt:ChartCycleMin90];
    //    NSNumber *min180 = [[NSNumber alloc] initWithInt:ChartCycleMin180];
    NSNumber *day = [[NSNumber alloc] initWithInt:ChartCycleDay];
    NSNumber *week = [[NSNumber alloc] initWithInt:ChartCycleWeek];
    NSNumber *month = [[NSNumber alloc] initWithInt:ChartCycleMonth];
    //    NSNumber *year = [[NSNumber alloc] initWithInt:ChartCycleYear];
    NSNumber *hour2 = [[NSNumber alloc] initWithInt:ChartCycleHour2];
    NSNumber *hour4 = [[NSNumber alloc] initWithInt:ChartCycleHour4];
    //    NSNumber *hour6 = [[NSNumber alloc] initWithInt:ChartCycleHour6];
    //    NSNumber *hour8 = [[NSNumber alloc] initWithInt:ChartCycleHour8];
    return  [[NSArray alloc] initWithObjects:
             min1, min5, min15, min30, min60, hour2,
             hour4, day, week,month,  nil];
}

- (NSArray *)getTechnologyArray {
    return  [[NSArray alloc] initWithObjects:
             MA, AO, ARBR, ATR,
             BIAS,BIASAB,BOLLINGERBAND,CCI,DMI,
             KDJ,MACD,MTM,
             PSY,ROC,RSI,RSISMOOTH,
             WR, OSMA, SAR, nil];
}

- (NSArray *)getDrawTypeArray {
    return [[NSArray alloc] initWithObjects:
            @"Line",@"HorizontalLine",@"PriceTangent",
            @"Channel",@"GoldenSection",@"GoldenBands",
            @"GoldenCircle",@"GannFan",@"LinearRegression",nil];
}

- (NSArray *)getKChartTypeArray {
    return [[NSArray alloc] initWithObjects:CANDLESTICK, BAR, nil];
}

- (NSArray *)getMASubChooseArray {
    return [[NSArray alloc] initWithObjects:@"MA1",@"MA2",@"MA3",@"MA4",@"MA5", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (_contentArray == nil) ? 0 : [_contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    switch (_currentChooseType) {
        case ChooseTypeCycleChooseType:
            return [self cycleChooseCell:row uitableView:tableView];
        case ChooseTypeTechnologyType:
            return [self tiChooseCell:row uitableView:tableView];
        case ChooseTypeDrawType:
            return [self drawChooseCell:row uitableView:tableView];
        case ChooseTypeCandleStickType:
            return [self kChartChooseCell:row uitableView:tableView];
        case ChooseTypeMaSubArrayType:
            return [self maSubArrayChooseCell:row uitableView:tableView];
        default:
            break;
    }
    return nil;
}

- (UITableViewCell *)cycleChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView{
    static NSString *cycleIdentifier = @"CycleChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cycleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cycleIdentifier];
        [cell addHeaderBottomLineWithWidth:0.4f bgColor:[UIColor whiteColor]];
    }
    
    NSString *cycleName = [[LangCaptain getInstance] getLangByCode:[[_contentArray objectAtIndex:row] stringValue]];
    cell.textLabel.text = cycleName;
    //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
    
    if ([[_contentArray objectAtIndex:row] intValue] == [self.saveData chartCycleType]) {
        if ([cell viewWithTag:ImageTag] == nil) {
            CGRect frame = CGRectMake(0, 0, CellHeight - 15, CellHeight - 15);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setTag:ImageTag];
            [imageView setCenter:CGPointMake(self.frame.size.width - CellHeight, CellHeight / 2)];
            [imageView setImage:[UIImage imageNamed:@"images/normal/select"]];
            [cell addSubview:imageView];
        }
    } else {
        if ([cell viewWithTag:ImageTag] != nil) {
            [[cell viewWithTag:ImageTag] removeFromSuperview];
        }
    }
    return cell;
}

- (UITableViewCell *)maSubArrayChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView{
    static NSString *cycleIdentifier = @"MaSubArrayChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cycleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cycleIdentifier];
        [cell addHeaderBottomLineWithWidth:0.4f bgColor:[UIColor whiteColor]];
    }
    
    //    NSString *cycleName = [[LangCaptain getInstance] getLangByCode:[chooseArray objectAtIndex:row]];
    NSArray *maArray = [[self.saveData tiArgumentConfig] maDataArray];
    MAData *data = [maArray objectAtIndex:row];
    int period = [[data maPeriod] intValue];
    
    NSString *maName = [[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"MA%d", period]];
    cell.textLabel.text = maName;
    //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
    
    //    if ([[[KChartParam getInstance] mutableTechnologyArray] containsObject:[chooseArray objectAtIndex:row]]) {
    //    if (![[[[KChartParam getInstance] mutableTechnologyArray] objectAtIndex:row] isEqualToString:@"MA0"]) {
    if (![[[self.saveData maNameArray] objectAtIndex:row] isEqualToString:@"MA0"]) {
        if ([cell viewWithTag:ImageTag] == nil) {
            CGRect frame = CGRectMake(0, 0, CellHeight - 15, CellHeight - 15);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setTag:ImageTag];
            [imageView setCenter:CGPointMake(self.frame.size.width - CellHeight, CellHeight / 2)];
            [imageView setImage:[UIImage imageNamed:@"images/normal/select"]];
            [cell addSubview:imageView];
        }
    } else {
        cell.textLabel.text = @"MA0";
        if ([cell viewWithTag:ImageTag] != nil) {
            [[cell viewWithTag:ImageTag] removeFromSuperview];
        }
    }
    return cell;
}

- (UITableViewCell *)tiChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView {
    //        NSString *cycleName = [[LangCaptain getInstance] getLangByCode:[[chooseArray objectAtIndex:row] stringValue]];
    
    static NSString *tiIdentifier = @"TiChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             tiIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tiIdentifier];
        [cell addHeaderBottomLineWithWidth:0.4f bgColor:[UIColor whiteColor]];
    }
    [cell setBackgroundColor:[UIColor blackColor]];
    
    UILabel *textLabel = [cell viewWithTag:CellTextTag];
    if (textLabel == nil) {
        CGRect frame = CGRectMake(10, 0, cell.frame.size.width - 120, CellHeight);
        textLabel = [[UILabel alloc] initWithFrame:frame];
        [textLabel setTag:CellTextTag];
        //        [textLabel setCenter:CGPointMake(cell.frame.size.width / 2  + 5, CellHeight / 2)];
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [textLabel setFont:[UIFont systemFontOfSize:13.0f]];
        textLabel.numberOfLines = 0;
        [cell addSubview:textLabel];
    }
    
    NSMutableString *text = [NSMutableString stringWithString:[[LangCaptain getInstance] getLangByCode:[_contentArray objectAtIndex:row]]];
    
    [textLabel setText:[text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    Boolean needShowMa = false;
    if ([[_contentArray objectAtIndex:row] isEqualToString:@"ma"]) {
        for (NSString *maTemp in self.saveData.maNameArray) {
            if (![maTemp isEqualToString:@"MA0"]) {
                needShowMa = true;
                break;
            }
        }
    }
    
    if ([[self.saveData technologyNameArray] containsObject:[_contentArray objectAtIndex:row]] || needShowMa) {
        if ([cell viewWithTag:ImageTag] == nil) {
            CGRect frame = CGRectMake(0, 0, CellHeight - 15, CellHeight - 15);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setTag:ImageTag];
            [imageView setCenter:CGPointMake(self.frame.size.width - CellHeight, CellHeight / 2)];
            [imageView setImage:[UIImage imageNamed:@"images/normal/select"]];
            [cell addSubview:imageView];
        }
    } else {
        if ([cell viewWithTag:ImageTag] != nil) {
            [[cell viewWithTag:ImageTag] removeFromSuperview];
        }
    }
    
    
    
    return cell;
}

- (UITableViewCell *)drawChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView {
    static NSString *drawIdentifier = @"DrawChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:drawIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:drawIdentifier];
        [cell addHeaderBottomLineWithWidth:0.4f bgColor:[UIColor whiteColor]];
    }
    cell.textLabel.text = [_contentArray objectAtIndex:row];
    //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setText:[[LangCaptain getInstance] getLangByCode:[_contentArray objectAtIndex:row]]];
    [cell setBackgroundColor:[UIColor blackColor]];
    return cell;
}

- (UITableViewCell *)kChartChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView {
    static NSString *kChartIdentifier = @"KChartChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChartIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChartIdentifier];
        [cell addHeaderBottomLineWithWidth:0.4f bgColor:[UIColor whiteColor]];
    }
    [cell setBackgroundColor:[UIColor blackColor]];
    
    UILabel *textLabel = [cell viewWithTag:CellTextTag];
    if (textLabel == nil) {
        CGRect frame = CGRectMake(10, 0, cell.frame.size.width - 120, CellHeight);
        textLabel = [[UILabel alloc] initWithFrame:frame];
        [textLabel setTag:CellTextTag];
        //        [textLabel setCenter:CGPointMake(cell.frame.size.width / 2  + 5, CellHeight / 2)];
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [textLabel setFont:[UIFont systemFontOfSize:13.0f]];
        textLabel.numberOfLines = 0;
        [cell addSubview:textLabel];
    }
    
    NSMutableString *text = [NSMutableString stringWithString:[[LangCaptain getInstance] getLangByCode:[_contentArray objectAtIndex:row]]];
    
    [textLabel setText:[text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    //    if ([[[KChartParam getInstance] kChartType] isEqualToString:[_contentArray objectAtIndex:row]]) {
    if ([[self.saveData chartType] isEqualToString:[_contentArray objectAtIndex:row]]) {
        if ([cell viewWithTag:ImageTag] == nil) {
            CGRect frame = CGRectMake(0, 0, CellHeight - 15, CellHeight - 15);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setTag:ImageTag];
            [imageView setCenter:CGPointMake(self.frame.size.width - CellHeight, CellHeight / 2)];
            [imageView setImage:[UIImage imageNamed:@"images/normal/select"]];
            [cell addSubview:imageView];
        }
    } else {
        if ([cell viewWithTag:ImageTag] != nil) {
            [[cell viewWithTag:ImageTag] removeFromSuperview];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didSelectAtIndex:value:type:)]) {
        [_delegate didSelectAtIndex:(int)[indexPath row] value:[_contentArray objectAtIndex:[indexPath row]] type:_currentChooseType];
        [tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (subChooseView != nil) {
        [subChooseView setHidden:true];
    }
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    if (hidden && subChooseView != nil) {
        [subChooseView setHidden:hidden];
    }
    
    if (!hidden) {
        [_contentTableView reloadData];
    }
}


@end
