//
//  SystemMainConfigContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "SystemMainConfigContentView.h"
#import "ClientSystemConfig.h"
#import "LangCaptain.h"
#import "API_IDEventCaptain.h"
#import "LayoutCenter.h"
#import "JumpDataCenter.h"
#import "CertificateManager.h"
#import "UIView+AddLine.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"
@interface SystemMainConfigContentView()<UITableViewDataSource, UITableViewDelegate> {
    
}

@property NSMutableArray *contentArray;

@end

@implementation SystemMainConfigContentView

@synthesize contentArray;

@synthesize titleLabel;
@synthesize contentTableView;

- (void)initContent {
    [self initData];
    [self initComponent];
    [self setBackgroundColor:[UIColor grayColor]];
}

- (void)resetContentView {
    [self initData];
}

#pragma init
- (void)initData {
    [self loadData];
    [self.contentTableView reloadData];
}

- (void)loadData {
    NSArray *currencyChooseArray = [[NSArray alloc] initWithObjects:@"CurrencyChoose", nil];
    NSArray *passwordChangeArray = [[NSArray alloc] initWithObjects:@"LoginPasswordChange", nil];
    NSArray *phonePinChangeArray = [[NSArray alloc] initWithObjects:@"PhonePinChange", nil];
    NSArray *openPositionSortArray = [[NSArray alloc] initWithObjects:@"OpenPositionSort", @"Currency", @"OpenPrice", @"FloatPL", @"TradeTime", nil];
    NSArray *orderSortArray = [[NSArray alloc] initWithObjects:@"OrderSort", @"Currency", @"PriceDESC", @"PriceACS", nil];
    NSArray *positionSumSortArray = [[NSArray alloc] initWithObjects:@"PositionSumSort", @"Currency", @"FloatPL", nil];
    
    // 从配置文件中获取
    NSArray *amountArray = [[ClientSystemConfig getInstance] amountCustomArray];
    NSArray *amountConfigArray = [[NSArray alloc] initWithObjects:@"AmountCustom", [amountArray objectAtIndex:0], [amountArray objectAtIndex:1], [amountArray objectAtIndex:2], nil];
    
    //    NSArray *columnConfigArray = [[NSArray alloc] initWithObjects:@"ColumnNotice", @"Highest", @"Lowest", @"UpDown", @"UpDown", @"UpDownPercent", @"UpdateTime", nil];
    //    NSArray *columnConfigArray = [[NSArray alloc] initWithObjects:@"ColumnNotice", @"Highest", @"Lowest", @"UpDown", @"UpdateTime", nil];
    
    NSArray *rssArray = [[NSArray alloc] initWithObjects:@"RSS", nil];
    NSArray *kChartNumberArray = [[NSArray alloc] initWithObjects:@"KChartNumberChoose", @"", @"", @"", @"", nil];
    
    NSArray *certificateArray = [[NSArray alloc] initWithObjects:@"CertificateManagement", nil];
    
    NSArray *quoteListUpDownTypeArray = [[NSArray alloc] initWithObjects:@"QuoteList", @"UpDown", @"UpDownPercent", nil];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObject:currencyChooseArray];
    [tempArray addObject:passwordChangeArray];
    [tempArray addObject:certificateArray];
    [tempArray addObject:phonePinChangeArray];
    [tempArray addObject:openPositionSortArray];
    [tempArray addObject:orderSortArray];
    [tempArray addObject:positionSumSortArray];
    [tempArray addObject:amountConfigArray];
    
    [tempArray addObject:quoteListUpDownTypeArray];
    //    [tempArray addObject:columnConfigArray];
    [tempArray addObject:rssArray];
    [tempArray addObject:kChartNumberArray];
    
    self.contentArray = tempArray;
}

- (void)initComponent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"SystemConfig"]];
    
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
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
    NSString * instrument = [[self.contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    // 不需要重用
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    [cell addBottomLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setText:[[LangCaptain getInstance] getLangByCode:instrument]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor whiteColor]];

    [self setBackgroundView:cell indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath section] == CurrencyChoose) {
        // 跳转到货币选择界面
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showInstrumentOrderView];
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_1];
        return;
    }
    
    if ([indexPath section] == PasswordChange) {
        // 跳转到 密码修改界面
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showLoginPwdView];
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_1];
        return;
    }
    
    if ([indexPath section] == PhonePinChange) {
        // 跳转到 电话下单密码修改
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showPhonePinPwdView];
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
        [API_IDEventCaptain fireEventChanged:SystemConfig_OpenSortChanged eventData:nil];
        [self.contentTableView reloadData];
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
        [API_IDEventCaptain fireEventChanged:SystemConfig_OrderSortChanged eventData:nil];
        [contentTableView reloadData];
        return;
    }
    
    if ([indexPath section] == QuoteListUpDownType) {
        if ([indexPath row] == 0) {
            return;
        }
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_12];
        // 涨跌、涨跌幅 显示
        [[ClientSystemConfig getInstance] setQuoteListUpDownType:[NSNumber numberWithInt:(int)([indexPath row] - 1)]];
        [[ClientSystemConfig getInstance] saveConfigData];
        [API_IDEventCaptain fireEventChanged:SystemConfig_UpDownTypeChanged eventData:nil];
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
        [API_IDEventCaptain fireEventChanged:SystemConfig_PositionSumSortChanged eventData:nil];
        [contentTableView reloadData];
        return;
    }
    
    if ([indexPath section] == AmountCustom) {
        
        if ([indexPath row] == 0) {
            return;
        }
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SYSTEMSETTING subType:APP_OPT_TYPE_SYSTEMSETTING_ITEM_11];
        
        [[JumpDataCenter getInstance] setCustomAmountIndex:(int)([indexPath row] - 1)];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showCustomAmountView];
        return;
    }
    
    if ([indexPath section] == Rss) {
        // 跳转到Rss选择界面
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showRssResourceView];
        return;
    }
    
    if ([indexPath section] == Certificate) {
        // 跳转到Rss选择界面
        [[CertificateManager getInstance] showCertificateView];
        return;
    }
    
    if ([indexPath section] == KChartNumber) {
        if ([indexPath row] == 0) {
            return;
        }
        NSInteger selectIndex = [indexPath row];
        NSNumber *currentNumber = [[NSNumber alloc] initWithInteger:selectIndex];
        [[ClientSystemConfig getInstance] setCurrentKChartNumber:currentNumber];
        [[ClientSystemConfig getInstance] saveConfigData];
        [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:NormalScreenStatus];
        [contentTableView reloadData];
        return;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return contentTableViewCellHeight;
}

#pragma privateFunc

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
        
        if ([indexPath section] == QuoteListUpDownType) {
            NSNumber *quoteListUpDown = [self getQuoteUpDownType];
            if ([quoteListUpDown intValue] == [indexPath row] - 1) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLight2.png"]]];
            } else {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLightDefault.png"]]];
            }
        }
        
        if ([indexPath section] == KChartNumber) {
            NSNumber *currentKChartNumber = [self getKChartNumber];
            if ([currentKChartNumber intValue] == [indexPath row]) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLight2.png"]]];
            } else {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/grayLightDefault.png"]]];
            }
            if (cell.subviews.count <= 3) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"images/chartNumber/kChartNumber%ld", (long)[indexPath row]]]];
                [imageView setFrame:CGRectMake(14, 6, 35, contentTableViewCellHeight - 12)];
                [cell addSubview:imageView];
            }
        }
        
    }
}

#pragma getSetFunc
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

- (NSNumber *)getQuoteUpDownType {
    return [[ClientSystemConfig getInstance] quoteListUpDownType];
}

- (NSNumber *)getKChartNumber {
    return [[ClientSystemConfig getInstance] currentKChartNumber];
}

@end
