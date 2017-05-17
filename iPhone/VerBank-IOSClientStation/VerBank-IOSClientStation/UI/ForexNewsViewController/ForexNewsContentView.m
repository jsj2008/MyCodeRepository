//
//  ForexNewsContentView.m
//
//
//  Created by Allone on 15/9/17.
//
//

#import "ForexNewsContentView.h"
#import "ForexNewsCellView.h"
#import "JEDIDateTime.h"
#import "IosLayoutDefine.h"
#import "UIFormat.h"
#import "ForexNewsSelectView.h"
#import "IosLogic.h"
#import "ShowAlert.h"
#import "IDNFeedParser.h"
#import "ForexNewsPopView.h"
#import "LangCaptain.h"
#import "ClientSystemConfig.h"
#import "RefreshHeadView.h"
#import "NSArraySortUtil.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"
#import "TradeApi.h"
#import "EconomicData.h"
#import "EconomicCellView.h"
#import "CustomFont.h"

#import <EventKitUI/EventKitUI.h>

//#define CellHeigh 60

const static CGFloat cellHeigh = 60;
const static CGFloat economicCellHeigh = 100;
const static CGFloat headHeight = 40.0f;

#define Type_News 0
#define Type_EconomicData 1
#define Type_Review 2

@interface ForexNewsContentView ()<UITableViewDataSource, UITableViewDelegate, CustomSecmentControlViewDelegate> {
    ForexNewsSelectView *_forexNewsSelectView;
    int _currentType;
    ForexNewsPopView *_forexNewsPopView;
    NSMutableDictionary *contentDictionary;
    RefreshHeadView *refreshHeadView;
}
@end

@implementation ForexNewsContentView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initForexNewsTableView];
        selectCellIndex = _kDefaultSelectedCell;
        _currentType = Type_News;
        [self reInitData];
        [self initForexNewsPopView];
        contentDictionary = [[NSMutableDictionary alloc] init];
        [self setupHeader];
    }
    return self;
}

- (void)setupHeader {
    refreshHeadView = [RefreshHeadView newInstance];
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeadView addToScrollView:contentTableView];
    [refreshHeadView addTarget:self refreshAction:@selector(refreshTableView)];
}

- (void)refreshTableView {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *itemArray;
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        TradeResult_SimpleList *result;
        if (_currentType == Type_News) {
            itemArray = [self getItemArray];
        }
        
        if (_currentType == Type_EconomicData) {
            result = [[TradeApi getInstance] queryEconomicDatas];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //        [self getOrderHisArray:[selectSliderView getCurrentIndex] + 1];
            if (_currentType == Type_News) {
                if (itemArray == nil) {
                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                        andMessage:[[LangCaptain getInstance] getLangByCode:@"LoadingFailed"]];
                } else {
                    self.contentArray = [[NSMutableArray alloc] initWithArray:itemArray];
                }
                [contentTableView reloadData];
                [refreshHeadView endRefreshing];
            }
            
            if (_currentType == Type_EconomicData) {
                // 排序
//                NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[result dataList]];
//                 // 要求和 PC 端保持一致， 所以不需要排序
//                [self sortEconomicDataArray:tempArray];
//                if ([result succeed]) {
//                    for (EconomicData *data in tempArray) {
//                        NSMutableArray *array = [tempDic objectForKey:[data getDate]];
//                        if (array == nil) {
//                            array = [[NSMutableArray alloc] init];
//                            [tempDic setObject:array forKey:[data getDate]];
//                        }
//                        [array addObject:data];
//                    }
//                }
//                self.contentArray = [[NSMutableArray alloc] initWithArray:[tempDic allValues]];
//                [contentTableView reloadData];
//                [refreshHeadView endRefreshing];
                
                // 不排序
                NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[result dataList]];
                // 要求和 PC 端保持一致， 所以不需要排序
                [self sortEconomicDataArray:tempArray];
                NSMutableArray *contentList = [[NSMutableArray alloc] init];
                if ([result succeed]) {
                    NSString *dateValue = @"-";
                    NSMutableArray *array = nil;
                    
                    for (EconomicData *data in tempArray) {
                        if (array == nil) {
                            array = [[NSMutableArray alloc] init];
                        }
                        if ([dateValue isEqualToString:[data getDate]]) {
                            [array addObject:data];
                        } else {
                            dateValue = [data getDate];
                            array = [[NSMutableArray alloc] init];
                            [array addObject:data];
                            [contentList addObject:array];
                        }
                    }
                }
////                self.contentArray = [[NSMutableArray alloc] initWithArray:[tempDic allValues]];
                self.contentArray = contentList;
                [contentTableView reloadData];
                [refreshHeadView endRefreshing];
            }
            
        });
    });
}

- (void)initForexNewsPopView{
    _forexNewsPopView = [[ForexNewsPopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)reInitData {
    
    if (_currentType == Type_News) {
        //        NSString *url = @"http://rss.sina.com.cn/roll/finance/hot_roll.xml";
        //        NSString *url = @"http://news.baidu.com/n?cmd=1&class=civilnews&tn=rss";
        //    NSString *url = @"http://www.zhihu.com/rss";
        
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 获取文章列表
            
            NSArray *tempArray = [self getItemArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] hidenAlertWaitView];
                if (tempArray == nil) {
                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                        andMessage:[[LangCaptain getInstance] getLangByCode:@"LoadingFailed"]];
                } else {
                    self.contentArray = [[NSMutableArray alloc] initWithArray:tempArray];
                    [contentTableView reloadData];
                }
            });
        });
    }
    
    if (_currentType == Type_EconomicData) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            TradeResult_SimpleList *result = [[TradeApi getInstance] queryEconomicDatas];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] hidenAlertWaitView];
                NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[result dataList]];
                
                //////
                [self sortEconomicDataArray:tempArray];
                NSMutableArray *contentList = [[NSMutableArray alloc] init];
                if ([result succeed]) {
                    NSString *dateValue = @"-";
                    NSMutableArray *array = nil;
                    
                    for (EconomicData *data in tempArray) {
                        if (array == nil) {
                            array = [[NSMutableArray alloc] init];
                        }
                        if ([dateValue isEqualToString:[data getDate]]) {
                            [array addObject:data];
                        } else {
                            dateValue = [data getDate];
                            array = [[NSMutableArray alloc] init];
                            [array addObject:data];
                            [contentList addObject:array];
                        }
                    }
                }
//                //                self.contentArray = [[NSMutableArray alloc] initWithArray:[tempDic allValues]];
                self.contentArray = contentList;
                [contentTableView reloadData];
                //////
                
                /*
                [self sortEconomicDataArray:tempArray];
                if ([result succeed]) {
                    for (EconomicData *data in tempArray) {
                        NSMutableArray *array = [tempDic objectForKey:[data getDate]];
                        if (array == nil) {
                            array = [[NSMutableArray alloc] init];
                            [tempDic setObject:array forKey:[data getDate]];
                        }
                        [array addObject:data];
                    }
                }
                self.contentArray = [[NSMutableArray alloc] initWithArray:[tempDic allValues]];
                [contentTableView reloadData];
                 */
            });
        });
    }
}

- (void)sortEconomicDataArray:(NSMutableArray *)array {
    for (EconomicData *data in array) {
        NSString *time = @"";
        if ([[data getTime]isEqualToString:@""] || [data getTime] == nil) {
            time = @"00:00";
        } else {
            time = [data getTime];
        }
        NSString *timeString = [NSString stringWithFormat:@"%@%@", [data getDate], time];
        NSDate *date = [JEDIDateTime dateFromString:timeString withFormat:@"yyyy-MM-ddHH:mm"];
//        NSDate *date = [JEDIDateTime dateFromString:[data getDate] withFormat:@"yyyy-MM-dd"];
        [data setSortTag:[JEDIDateTime stringUIFromDate:date]];
    }
    [NSArraySortUtil sortASCStringArray:array sortSelector:@"sortTag"];
}

- (NSArray *)getItemArray {
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    NSArray *oriUrls = [[ClientSystemConfig getInstance] rssResourceArray];
    for (NSString *url in oriUrls) {
        if (![urlArray containsObject:url]) {
            [urlArray addObject:url];
        }
    }
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSString *url in urlArray) {
        //        IDNFeedInfo *info = [IDNFeedParser feedInfoWithUrl:url];
        NSArray *itemArray = [IDNFeedParser feedItemsWithUrl:url];
        if (itemArray == nil || [itemArray count] == 0) {
            continue;
        }
        //        for (IDNFeedItem *item in itemArray) {
        //            [item setMessageTitle:[info title]];
        //        }
        [tempArray addObjectsFromArray:itemArray];
    }
    [self sortArray:tempArray];
    return tempArray;
}

- (void)sortArray:(NSMutableArray *)array {
    for (IDNFeedItem *item in array) {
        [item setSortTag:[JEDIDateTime stringUIFromDate:[item date]]];
    }
    [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
}

- (void)initForexNewsTableView{
    
    CGRect rect = self.frame;
    rect.size.height = rect.size.height - 40;
    
    [contentTableView setFrame:rect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    contentTableView.bounces = YES;
    
    rect.origin.y = rect.origin.y + rect.size.height;
    rect.size.height = 40.0f;
    
    _forexNewsSelectView = [[ForexNewsSelectView alloc] initWithFrame:rect];
    [_forexNewsSelectView setSegmentDelegate:self];
    [self addSubview:_forexNewsSelectView];
    [self addSubview:contentTableView];
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_currentType == Type_EconomicData) {
        return [[self.contentArray objectAtIndex:section] count];
    } else {
        return [self.contentArray count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_currentType == Type_EconomicData) {
        return [self.contentArray count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_currentType == Type_News) {
        IDNFeedItem *info = [self.contentArray objectAtIndex:[indexPath row]];
        [self updateViewCell:cell info:info];
    }
    
    if (_currentType == Type_EconomicData) {
        EconomicData *data = [[self.contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        [self updateViewCell:cell economic:data];
    }
    
    return cell;
}

- (void)updateViewCell:(UITableViewCell *)cell economic:(EconomicData *)data {
    
    EconomicCellView *cellView = [EconomicCellView newInstance];
    [cellView.titleLabel setText:[data getEconomicData]];
    
//    int value = [[data getTime] intValue];
//    if (value % 100 < 10) {
//        [cellView.timeLabel setText:[NSString stringWithFormat:@"%d:0%d", value/100, value%100]];
//    } else {
//        [cellView.timeLabel setText:[NSString stringWithFormat:@"%d:%d", value/100, value%100]];
//    }
    
    [cellView.timeLabel setText:[data getTime]];
    
    NSString *level = [data getLevel];
    if ([level isEqualToString:[[LangCaptain getInstance] getLangByCode:@"L"]]) {
        [cellView.levelLabel setBackgroundColor:[UIColor lowColor]];
    } else if ([level isEqualToString:[[LangCaptain getInstance] getLangByCode:@"H"]]) {
        [cellView.levelLabel setBackgroundColor:[UIColor highColor]];
    } else if ([level isEqualToString:[[LangCaptain getInstance] getLangByCode:@"M"]]) {
        [cellView.levelLabel setBackgroundColor:[UIColor middleColor]];
    }
    
    [cellView.countryLabel setText:[data getCountry]];
    [cellView.monthLabel setText:[data getPublishedTime]];
    
    //    [cellView.levelLabel setText:[data get]];
    [cellView.levelLabel setText:[[LangCaptain getInstance] getLangByCode:[data getLevel]]];
    NSString *forecastsValueString = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"ForecastsValue"], [data getForecastsValue]];
    NSString *beforeString = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"BeforeTheValue"], [data getBeforeTheValue]];
    [cellView.forecastsLabel setText:forecastsValueString];
    [cellView.beforeLabel setText:beforeString];
    
    [cellView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, economicCellHeigh - 2)];
    cellView.layer.cornerRadius = 10.0f;
    cellView.layer.borderWidth = 1.0f;
    cellView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    //    [cellView setBackgroundColor:[UIColor blackColor]];
    
    [cellView.titleLabel setFont:[CustomFont getCNNormalWithSize:17.0f]];
    [cellView.timeLabel setFont:[CustomFont getENNormalWithSize:15.0f]];
    
    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubview:cellView];
    [cell setBackgroundColor:[UIColor backgroundColor]];
    
    [cellView.actionButton addTarget:self action:@selector(didClickAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [cellView.actionButton setImage:[UIImage imageNamed:@"images/normal/ecoadd.png"] forState:UIControlStateNormal];
    [cellView.actionButton setTitle:@"+" forState:UIControlStateNormal];
    //    [cellView.actionButton set];
    //    [cellView.actionButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    //    [cellView.titleLabel setTextColor:[UIColor blackColor]];
    //    [cellView.timeLabel setTextColor:[UIColor blackColor]];
    
    [cellView.timeLabel setTextColor:[UIColor whiteColor]];
    [cellView.countryLabel setTextColor:[UIColor whiteColor]];
    [cellView.monthLabel setTextColor:[UIColor whiteColor]];
    [cellView.forecastsLabel setTextColor:[UIColor whiteColor]];
    [cellView.beforeLabel setTextColor:[UIColor whiteColor]];
    [cellView.titleLabel setTextColor:[UIColor whiteColor]];
    [cellView.levelLabel setTextColor:[UIColor whiteColor]];
    
    //    [UIFormat setComplexGrayViewColor:cellView.backgroundImageView];
    [cellView setBackgroundColor:[UIColor blackColor]];
    [UIFormat setCorner:UIRectCornerAllCorners
             WithUIView:cellView
             withCorner:10.0f];
    
    cellView.levelLabel.layer.cornerRadius = 5.0f;
    cellView.levelLabel.layer.masksToBounds = true;
}

- (void)updateViewCell:(UITableViewCell *)cell info:(IDNFeedItem *)info {
    ForexNewsCellView *cellView = [ForexNewsCellView newInstance];
    
    [cellView.titleLabel setText:[info title]];
    [cellView.timeLabel setText:[JEDIDateTime stringUIFromDate:[info date]]];
    //        [cellView.newsTypeLabel setText:[info author]];
    //        [cellView.newsTypeLabel setText:@"Type_News"];
    [cellView.newsTypeLabel setText:[info messageTitle]];
    
    [cellView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellHeigh - 2)];
    cellView.layer.cornerRadius = 10.0f;
    cellView.layer.borderWidth = 1.0f;
    cellView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    [cellView setBackgroundColor:[UIColor blackColor]];
    
    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubview:cellView];
    [cell setBackgroundColor:[UIColor blackColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentType == Type_EconomicData) {
        return economicCellHeigh;
    }
    return cellHeigh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_currentType == Type_EconomicData) {
        //    EconomicData *data = [[contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        //        return cellHeigh + 20 + [[data getEconomicData] length] / cellBufferNumber * 30;
        return headHeight;
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor blackColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 180, headHeight)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    //    titleLabel.text=[self.keys objectAtIndex:section];
    //    [titleLabel setText:@"iooi"];
    NSString *dateString = [[[self.contentArray objectAtIndex:section] objectAtIndex:0] getDate];
    [titleLabel setText:dateString];
    [headerView addSubview:titleLabel];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_currentType == Type_News) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ForexNewsCellView *cellView = [[cell subviews] objectAtIndex:0];
        
        [cellView.titleLabel setTextColor:[UIColor blackColor]];
        [cellView.timeLabel setTextColor:[UIColor blackColor]];
        [cellView.newsTypeLabel setTextColor:[UIColor blackColor]];
        
        [UIFormat setComplexGrayViewColor:cellView.backgroundView];
        [UIFormat setCorner:UIRectCornerAllCorners WithUIView:cellView.backgroundView withCorner:10.0f];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_currentType == Type_News) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ForexNewsCellView *cellView = [[cell subviews] objectAtIndex:0];
        
        [cellView.titleLabel setTextColor:[UIColor whiteColor]];
        [cellView.timeLabel setTextColor:[UIColor whiteColor]];
        [cellView.newsTypeLabel setTextColor:[UIColor whiteColor]];
        
        [UIFormat setComplexClearViewColor:cellView.backgroundView];
        [UIFormat setCorner:UIRectCornerAllCorners WithUIView:cellView.backgroundView withCorner:10.0f];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentType == Type_News) {
        IDNFeedItem *info = [self.contentArray objectAtIndex:[indexPath row]];
        [_forexNewsPopView setInf:info];
        [self.superview.superview addSubview:_forexNewsPopView];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)didClickAction:(id)sender {
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    NSIndexPath *indexPath = [contentTableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    
    EconomicData *data = [[self.contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    
    //    int value = [[data getTime] intValue];
    //    NSString *HH = @"";
    //    NSString *mm = @"";
    //    if (value % 100 < 10) {
    //        mm = [NSString stringWithFormat:@"0%d", value%100];
    //    } else {
    //        mm = [NSString stringWithFormat:@"%d", value%100];
    //    }
    //
    //    if (value / 100 < 10) {
    //        HH = [NSString stringWithFormat:@"0%d", value/100];
    //    } else {
    //        HH = [NSString stringWithFormat:@"%d", value/100];
    //    }
    
    NSString *timeString = [NSString stringWithFormat:@"%@%@", [data getDate], [data getTime]];
    NSDate *date = [JEDIDateTime dateFromString:timeString withFormat:@"yyyy-MM-ddHH:mm"];
    
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    //    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    //    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,
                                                                      NSError *error) {
        // handle access here
        EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
        
        NSString *timeString = [data getTime];
        //        int value = [[data getTime] intValue];
        //        if (value % 100 < 10) {
        //            timeString = [NSString stringWithFormat:@"%d:0%d", value/100, value%100];
        //        } else {
        //            timeString = [NSString stringWithFormat:@"%d:%d", value/100, value%100];
        //        }
        
        NSString *country = [data getCountry];
        NSString *title = [data getEconomicData];
        NSString *publishedTime = [data getPublishedTime];
        NSString *forecastsValueString = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"ForecastsValue"], [data getForecastsValue]];
        NSString *beforeString = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"BeforeTheValue"], [data getBeforeTheValue]];
        
        myEvent.title = title;
        myEvent.notes = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@", timeString, country, title, publishedTime, forecastsValueString, beforeString];
        
        
        //        NSString *dataString = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", timeString, [data getCountry], [data getEconomicData], [data getPublishedTime]];
        //        myEvent.title     = dataString;
        myEvent.startDate = date;
        
        myEvent.endDate   = date;
        myEvent.allDay = NO;
        [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
        NSError *err;
        [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err];
    }];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow:"]];
    //    NSDate *date = [NSDate date];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"calshow:%f", [date timeIntervalSinceReferenceDate]]]];

}


#pragma segementDelegate
- (void)customSecmentControlClick:(NSInteger)index {
    switch (index) {
        case 0:
            _currentType = Type_News;
            [self reInitData];
            [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_FOREGIN subType:APP_OPT_TYPE_FOREGIN_ITEM_1];
            break;
        case 1:
            _currentType = Type_EconomicData;
            [self reInitData];
            [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_FOREGIN subType:APP_OPT_TYPE_FOREGIN_ITEM_2];
            break;
        case 2:
            [[IosLogic getInstance] gotoReviewViewController];
            [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_FOREGIN subType:APP_OPT_TYPE_FOREGIN_ITEM_3];
            break;
            
        default:
            break;
    }
}

@end
