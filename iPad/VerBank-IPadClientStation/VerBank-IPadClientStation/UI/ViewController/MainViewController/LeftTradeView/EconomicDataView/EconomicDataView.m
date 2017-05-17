//
//  EconomicDataView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "EconomicDataView.h"
#import "ConcreteEconomicView.h"
#import "TradeApi.h"
#import "EconomicDataViewCell.h"
#import "ShowAlertManager.h"
#import "LangCaptain.h"
#import "SortUtils.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"
#import "UIColor+CustomColor.h"

const static CGFloat cellHeight = 90.0f;
const static int cellBufferNumber = 17;
const static CGFloat headHeight = 40.0f;

@interface EconomicDataView()<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray          *contentArray;
    ConcreteEconomicView    *concreteEconomicView;
}

@end

@implementation EconomicDataView

@synthesize contentTableView;

- (void)initContent {
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    [contentTableView setBackgroundColor:[UIColor blackColor]];
    concreteEconomicView = [ConcreteEconomicView newInstance];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)updateView {
    [self initData];
}

- (void)initData {
    contentArray = [[NSMutableArray alloc] initWithArray:[self getItemArray]];
}

- (NSArray *)getItemArray {
    //    NSMutableArray *array = [[NSMutableArray alloc] init];
//    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    TradeResult_SimpleList *result = [[TradeApi getInstance] queryEconomicDatas];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[result dataList]];
    
    ////////
    
//    
//    [SortUtils sortEconomicDataArray:tempArray];
//    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
//    if ([result succeed]) {
//        
//        for (EconomicData *data in tempArray) {
//            NSMutableArray *array = [tempDic objectForKey:[data getDate]];
//            if (array == nil) {
//                array = [[NSMutableArray alloc] init];
//                [tempDic setObject:array forKey:[data getDate]];
//                [returnArray addObject:array];
//            }
//            [array addObject:data];
//        }
//        
//    }
    /////////
    
    NSMutableArray *contentList = [[NSMutableArray alloc] init];
    [SortUtils sortEconomicDataArray:tempArray];
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

    return contentList;
}

#pragma UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[contentArray objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"contentEconomicDataViewCell";
    EconomicDataViewCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"EconomicDataViewCell" bundle:nil];
        [self.contentTableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
        cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    }
    
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    EconomicData *data = [[contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    [cell.titleLabel setText:[data getEconomicData]];
    [cell.titleLabel setTextColor:[UIColor whiteColor]];
    [cell.titleLabel setBackgroundColor:[UIColor clearColor]];
    
    NSString *level = [data getLevel];
    if ([level isEqualToString:[[LangCaptain getInstance] getLangByCode:@"L"]]) {
        [cell.levelLabel setBackgroundColor:[UIColor lowColor]];
    } else if ([level isEqualToString:[[LangCaptain getInstance] getLangByCode:@"H"]]) {
        [cell.levelLabel setBackgroundColor:[UIColor highColor]];
    } else if ([level isEqualToString:[[LangCaptain getInstance] getLangByCode:@"M"]]) {
        [cell.levelLabel setBackgroundColor:[UIColor middleColor]];
    }
    [cell.levelLabel setText:[[LangCaptain getInstance] getLangByCode:[data getLevel]]];
    [cell.levelLabel setTextColor:[UIColor whiteColor]];
    cell.levelLabel.layer.cornerRadius = 5.0f;
    cell.levelLabel.layer.masksToBounds = true;
    
    
//    [cell.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
//    [cell.titleLabel setUserInteractionEnabled:false];
//    [cell.actionButton setBackgroundImage:[UIImage imageNamed:@"images/arrow/ecoadd.png"] forState:UIControlStateNormal];
//    [cell.actionButton setImage:[UIImage imageNamed:@"images/arrow/ecoadd.png"] forState:UIControlStateNormal];
//    [cell.actionButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [cell.actionButton setTitle:@"+" forState:UIControlStateNormal];
//    [cell.actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cell.actionButton addTarget:self action:@selector(didClickActionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *value = [data getTime];
//    if (value % 100 < 10) {
//        [cell.timeLabel setText:[NSString stringWithFormat:@"%d:0%d", value/100, value%100]];
//    } else {
//        [cell.timeLabel setText:[NSString stringWithFormat:@"%d:%d", value/100, value%100]];
//    }
    [cell.timeLabel setText:value];
    
    [cell.countryLabel setText:[data getCountry]];
    [cell.monthLabel setText:[data getPublishedTime]];
    NSString *forecastsValueString = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"ForecastsValue"], [data getForecastsValue]];
    NSString *beforeString = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"BeforeTheValue"], [data getBeforeTheValue]];
    [cell.forecastsLabel setText:forecastsValueString];
    [cell.beforeLabel setText:beforeString];
    //    [cell.timeLabel setText:[JEDIDateTime stringUIFromDate:[item date]]];
    //    [cell.newsTypeLabel setText:[item messageTitle]];
    [self setSelect:cell];
    return cell;
}

- (void)didClickActionButton:(id)sender {
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    NSIndexPath *indexPath = [contentTableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    
    EconomicData *data = [[contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    
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

- (void)setSelect:(UITableViewCell *)cell {
    EconomicDataViewCell *cellView = (EconomicDataViewCell *)cell;
    //    [cellView.newsTypeLabel setTextColor:[UIColor whiteColor]];
    [cellView.titleLabel setTextColor:[UIColor whiteColor]];
    //    [cellView.titleTextView setBackgroundColor:[UIColor blackColor]];
    [cellView.timeLabel setTextColor:[UIColor whiteColor]];
    [cellView.countryLabel setTextColor:[UIColor whiteColor]];
    [cellView.monthLabel setTextColor:[UIColor whiteColor]];
    [cellView.forecastsLabel setTextColor:[UIColor whiteColor]];
    [cellView.beforeLabel setTextColor:[UIColor whiteColor]];
    [cellView setRead:true];
}

- (void)setDeselect:(UITableViewCell *)cell {
    EconomicDataViewCell *cellView = (EconomicDataViewCell *)cell;
    //    [cellView.newsTypeLabel setTextColor:[UIColor blackColor]];
    
    [cellView.titleLabel setTextColor:[UIColor blackColor]];
    //    [cellView.titleTextView setBackgroundColor:[UIColor whiteColor]];
    [cellView.timeLabel setTextColor:[UIColor blackColor]];
    [cellView.countryLabel setTextColor:[UIColor blackColor]];
    [cellView.monthLabel setTextColor:[UIColor blackColor]];
    [cellView.forecastsLabel setTextColor:[UIColor blackColor]];
    [cellView.beforeLabel setTextColor:[UIColor blackColor]];
    [cellView setRead:false];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    EconomicData *data = [[contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
//    return cellHeight + [[data getEconomicData] length] / cellBufferNumber * 30;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor blackColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 180, headHeight)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    //    titleLabel.text=[self.keys objectAtIndex:section];
    //    [titleLabel setText:@"iooi"];
    NSString *dateString = [[[contentArray objectAtIndex:section] objectAtIndex:0] getDate];
    [titleLabel setText:dateString];
    [headerView addSubview:titleLabel];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    EconomicData *data = [[contentArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
//    [concreteEconomicView updateWithEconomicData:data];
//    [self addSubview:concreteEconomicView];
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    [self setSelect:cell];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [self setDeselect:cell];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [self setSelect:cell];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [concreteEconomicView setFrame:self.bounds];
}

#pragma override
- (void)reloadPageData {
    [super reloadPageData];
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [self.contentTableView reloadData];
        });
    });
}

- (void)pageUnSelect {
    [super pageUnSelect];
}

- (void)pageSelect {
    [super pageSelect];
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_FOREGIN subType:APP_OPT_TYPE_FOREGIN_ITEM_2];
}

@end
