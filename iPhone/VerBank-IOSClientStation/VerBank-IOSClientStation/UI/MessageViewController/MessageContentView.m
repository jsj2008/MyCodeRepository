//
//  MessageContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MessageContentView.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "MessageToAccount.h"
#import "UIColor+CustomColor.h"
#import "UIFormat.h"
#import "MessageCellView.h"
#import "JEDIDateTime.h"
#import "IosLayoutDefine.h"
#import "ShowAlert.h"
#import "DataCenter.h"

#import "MessagePopView.h"
#import "MTP4CommDataInterface.h"

#import "NSArraySortUtil.h"
#import "RefreshHeadView.h"
#import "MessageSelectView.h"

#import "CustomFont.h"
#import "PushFromSystem.h"
#import "LangCaptain.h"
#import "PushPopView.h"
#import "EconomicData.h"
#import "EconomicCellView.h"

#import "OptRecordTable.h"
#import "OperationRecordsSave.h"

#import <EventKitUI/EventKitUI.h>

const static CGFloat cellHeigh = 60;
const static CGFloat economicCellHeigh = 100;
const static CGFloat headHeight = 40.0f;

#define Type_Infor  0
#define Type_Economic 1
#define Type_Push   2

@interface MessageContentView()<UITableViewDataSource, UITableViewDelegate, CustomSecmentControlViewDelegate>{
    MessageSelectView *_messageSelectView;
    MessagePopView *_messagePopView;
    PushPopView *_pushPopView;
    
    RefreshHeadView *refreshHeadView;
    
    int _currentType;
}
@end

@implementation MessageContentView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _currentType = Type_Infor;
        [self initMessageTableView];
        [self initData];
        [self initPopView];
        [self addListener];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self getOrderHisArray:[selectSliderView getCurrentIndex] + 1];
        
        [self initData];
        [contentTableView reloadData];
        
        [refreshHeadView endRefreshing];
    });
}

- (void)initPopView {
    _messagePopView = [[MessagePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _pushPopView = [[PushPopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)initData {
    NSMutableArray *temp;
    if (_currentType == Type_Infor) {
        NSDate *monthBeforDate = [NSDate dateWithTimeInterval:-24 * 60 *60 * 30 sinceDate:[NSDate date]];
        temp = [[NSMutableArray alloc] init];
        for (MessageToAccount *ma in  [[DataCenter getInstance] reportList]) {
            if ([[ma getTime] compare:monthBeforDate] == NSOrderedDescending) {
                [temp addObject:ma];
            }
        }
        [self sortArray:temp];
    }
    
    if (_currentType == Type_Push) {
        [[DataCenter getInstance] queryPushMessage];
        temp = [[NSMutableArray alloc] initWithArray:[[DataCenter getInstance] pushList]];
        [self sortArray:temp];
    }
    
    if (_currentType == Type_Economic) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        TradeResult_SimpleList *result = [[TradeApi getInstance] queryEconomicDatas];
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[result dataList]];
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
        temp = [[NSMutableArray alloc] initWithArray:[tempDic allValues]];
    }
    self.contentArray = temp;
    
    //    [contentTableView reloadData];
}

- (void)sortArray:(NSMutableArray *)array {
    if (_currentType == Type_Infor) {
        for (MessageToAccount *ma in array) {
            //        [ma setSortTag:[@([ma getTime]) stringValue]];
            [ma setSortTag:[JEDIDateTime stringUIFromDate:[ma getTime]]];
            
        }
        [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
        //        [NSArraySortUtil sortDESCNumberArray:<#(NSMutableArray *)#> sortSelector:<#(NSString *)#>];
    }
    
    if (_currentType == Type_Push) {
        for (PushFromSystem *push in array) {
            [push setSortTag:[JEDIDateTime stringUIFromDate:[push getTime]]];
        }
        [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
    }
    
    //    if (_currentType == Type_Economic) {
    //
    //    }
}

- (void)sortEconomicDataArray:(NSMutableArray *)array {
    for (EconomicData *data in array) {
        NSDate *date = [JEDIDateTime dateFromString:[data getDate] withFormat:@"yyyy-MM-dd"];
        [data setSortTag:[JEDIDateTime stringUIFromDate:date]];
    }
    [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
}


- (void)initMessageTableView{
    CGRect rect = self.frame;
    rect.size.height -= 42;
    
    [contentTableView setFrame:rect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    contentTableView.bounces = YES;
    [self addSubview:contentTableView];
    
    rect.origin.y = rect.size.height;
    rect.size.height = 40;
    
    _messageSelectView = [[MessageSelectView alloc] initWithFrame:rect];
    [_messageSelectView setSegmentDelegate:self];
    [self addSubview:_messageSelectView];
}

#pragma tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_currentType == Type_Infor) {
        MessageToAccount *ma = [self.contentArray objectAtIndex:[indexPath row]];
        [self updateViewCell:cell ma:ma];
    } else if (_currentType == Type_Push) {
        PushFromSystem *push = [self.contentArray objectAtIndex:[indexPath row]];
        [self updateViewCell:cell push:push];
    } else if (_currentType == Type_Economic) {
        EconomicData *data = [[self.contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        [self updateViewCell:cell economic:data];
        //        [self setDeselect:cell];
        
    }
    return cell;
}

- (void)updateViewCell:(UITableViewCell *)cell ma:(MessageToAccount *)ma {
    
    MessageCellView *cellView = [MessageCellView newInstance];
    [cellView.titleLabel setText:[ma getTitle]];
    [cellView.timeLabel setText:[JEDIDateTime stringUIFromDate:[ma getTime]]];
    
    [cellView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellHeigh - 2)];
    cellView.layer.cornerRadius = 10.0f;
    cellView.layer.borderWidth = 1.0f;
    cellView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    [cellView setBackgroundColor:[UIColor blackColor]];
    
    [cellView.titleLabel setFont:[CustomFont getCNNormalWithSize:17.0f]];
    [cellView.timeLabel setFont:[CustomFont getENNormalWithSize:15.0f]];
    
    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubview:cellView];
    [cell setBackgroundColor:[UIColor backgroundColor]];
    if ([ma getIsRead] == _TRUE) {
        [self setSelect:cell];
    } else {
        [self setDeselect:cell];
    }
}

- (void)updateViewCell:(UITableViewCell *)cell push:(PushFromSystem *)push {
    
    MessageCellView *cellView = [MessageCellView newInstance];
    [cellView.titleLabel setText:[push getContext]];
    [cellView.timeLabel setText:[JEDIDateTime stringHHmmFromDate:[push getTime]]];
    
    [cellView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellHeigh - 2)];
    cellView.layer.cornerRadius = 10.0f;
    cellView.layer.borderWidth = 1.0f;
    cellView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    [cellView setBackgroundColor:[UIColor blackColor]];
    
    [cellView.titleLabel setFont:[CustomFont getCNNormalWithSize:17.0f]];
    [cellView.timeLabel setFont:[CustomFont getENNormalWithSize:15.0f]];
    
    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubview:cellView];
    [cell setBackgroundColor:[UIColor backgroundColor]];
    if ([push getIsRead] == _TRUE) {
        [self setSelect:cell];
    } else {
        [self setDeselect:cell];
    }
}

- (void)updateViewCell:(UITableViewCell *)cell economic:(EconomicData *)data {
    
    EconomicCellView *cellView = [EconomicCellView newInstance];
    [cellView.titleLabel setText:[data getEconomicData]];
    
    int value = [[data getTime] intValue];
    if (value % 100 < 10) {
        [cellView.timeLabel setText:[NSString stringWithFormat:@"%d:0%d", value/100, value%100]];
    } else {
        [cellView.timeLabel setText:[NSString stringWithFormat:@"%d:%d", value/100, value%100]];
    }
    
    [cellView.countryLabel setText:[data getCountry]];
    [cellView.monthLabel setText:[data getPublishedTime]];
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
    [cellView.actionButton setImage:[UIImage imageNamed:@"images/normal/ecoadd.png"] forState:UIControlStateNormal];
    [cellView.actionButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [cellView.actionButton setTitle:@"" forState:UIControlStateNormal];
    
    //    [cellView.titleLabel setTextColor:[UIColor blackColor]];
    //    [cellView.timeLabel setTextColor:[UIColor blackColor]];
    
    [cellView.timeLabel setTextColor:[UIColor blackColor]];
    [cellView.countryLabel setTextColor:[UIColor blackColor]];
    [cellView.monthLabel setTextColor:[UIColor blackColor]];
    [cellView.forecastsLabel setTextColor:[UIColor blackColor]];
    [cellView.beforeLabel setTextColor:[UIColor blackColor]];
    [cellView.titleLabel setTextColor:[UIColor blackColor]];
    
    [UIFormat setComplexGrayViewColor:cellView.backgroundImageView];
    [UIFormat setCorner:UIRectCornerAllCorners
             WithUIView:cellView
             withCorner:10.0f];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentType == Type_Economic) {
        //    EconomicData *data = [[contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        //        return cellHeigh + 20 + [[data getEconomicData] length] / cellBufferNumber * 30;
        return economicCellHeigh;
    }
    return cellHeigh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_currentType == Type_Economic) {
        //    EconomicData *data = [[contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        //        return cellHeigh + 20 + [[data getEconomicData] length] / cellBufferNumber * 30;
        return headHeight;
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor blackColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, headHeight)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    //    titleLabel.text=[self.keys objectAtIndex:section];
    //    [titleLabel setText:@"iooi"];
    NSString *dateString = [[[self.contentArray objectAtIndex:section] objectAtIndex:0] getDate];
    [titleLabel setText:dateString];
    [headerView addSubview:titleLabel];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_currentType == Type_Economic) {
        return [[self.contentArray objectAtIndex:section] count];
    } else {
        return [self.contentArray count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_currentType == Type_Economic) {
        return [self.contentArray count];
    } else {
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_currentType == Type_Infor) {
        MessageToAccount *ma = [self.contentArray objectAtIndex:[indexPath row]];
        
        [self selectMa:ma];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self setSelect:cell];
    } else if (_currentType == Type_Push) {
        PushFromSystem *push = [self.contentArray objectAtIndex:[indexPath row]];
        
        [self selectPush:push];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self setSelect:cell];
    }
}

- (void)selectMa:(MessageToAccount *)ma {
    [_messagePopView setMessage:ma];
    [ma setIsRead:_TRUE];
    [self.superview.superview addSubview:_messagePopView];
}

- (void)selectPush:(PushFromSystem *)push {
    [_pushPopView setPushMessage:push];
    [push setIsRead:_TRUE];
    [self.superview.superview addSubview:_pushPopView];
}

- (void)setSelect:(UITableViewCell *)cell {
    MessageCellView *cellView = [[cell subviews] objectAtIndex:0];
    [cellView.titleLabel setTextColor:[UIColor whiteColor]];
    [cellView.timeLabel setTextColor:[UIColor whiteColor]];
    [UIFormat setComplexClearViewColor:cellView.backgroundImageView];
    [UIFormat setCorner:UIRectCornerAllCorners
             WithUIView:cellView
             withCorner:10.0f];
}

- (void)setDeselect:(UITableViewCell *)cell {
    MessageCellView *cellView = [[cell subviews] objectAtIndex:0];
    [cellView.titleLabel setTextColor:[UIColor blackColor]];
    [cellView.timeLabel setTextColor:[UIColor blackColor]];
    [UIFormat setComplexGrayViewColor:cellView.backgroundImageView];
    [UIFormat setCorner:UIRectCornerAllCorners
             WithUIView:cellView
             withCorner:10.0f];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    MessageCellView *cellView = [[cell subviews] objectAtIndex:0];
//
//    [cellView.titleLabel setTextColor:[UIColor whiteColor]];
//    [cellView.timeLabel setTextColor:[UIColor whiteColor]];
//
//    [UIFormat setComplexClearViewColor:cellView.backgroundImageView];
//    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:cellView.backgroundImageView withCorner:10.0f];
////    [cellView setBackgroundColor:[UIColor clearColor]];
//}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentType == Type_Economic) {
        return;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setSelect:cell];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentType == Type_Economic) {
        return;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MessageToAccount *ma = [self.contentArray objectAtIndex:[indexPath row]];
    if ([ma getIsRead] == _TRUE) {
        [self setSelect:cell];
    } else {
        [self setDeselect:cell];
    }
}

- (void)addListener {
    //    [API_IDEventCaptain fireEventChanged:DATA_ON_MessageReceive eventData:[tinfo getMessage]];
    [API_IDEventCaptain addListener:DATA_ON_MessageReceive observer:self listener:@selector(reloadData:)];
}

- (void)removeListener {
    [API_IDEventCaptain removeListener:DATA_ON_MessageReceive observer:self];
}

- (void)reloadData:(NSNotification *) notification{
    id obj = [notification object];
    if (_currentType == Type_Infor) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.contentArray];
        if ([obj isKindOfClass:[MessageToAccount class]]) {
            //        [contentArray insertObject:obj atIndex:0];
            [tempArray addObject:obj];
            [self sortArray:tempArray];
        }
        
        self.contentArray = tempArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [contentTableView reloadData];
        });
    }
    
    //    [[DataCenter getInstance] queryPriceWarning];
    //    [self initData];
    
}

- (void)dealloc {
    [self removeListener];
}

#pragma segementDelegate
- (void)customSecmentControlClick:(NSInteger)index {
    switch (index) {
        case 0:
            _currentType = Type_Infor;
            
            break;
            //        case 1:
            //            _currentType = Type_Economic;
            //            [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_FOREGIN subType:APP_OPT_TYPE_FOREGIN_ITEM_2];
            //            break;
        case 1:
            //        [[IosLogic getInstance] gotoReviewViewController];
            _currentType = Type_Push;
            
            break;
            
        default:
            break;
    }
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsQuery"]
                                                   onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            [contentTableView reloadData];
        });
    });
}

@end
