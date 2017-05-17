//
//  NewsView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "NewsView.h"
#import "ConcreteNews.h"
#import "NewsViewCell.h"
#import "MTP4CommDataInterface.h"
#import "ShowAlertManager.h"
#import "LangCaptain.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "ClientSystemConfig.h"

#import "IDNFeedParser.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"
#import "SortUtils.h"

const static CGFloat cellHeight = 70.0f;

@interface NewsView()<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray  *contentArray;
    ConcreteNews    *concreteNews;
}

@end

@implementation NewsView

@synthesize contentTableView;

- (void)initContent {
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    [contentTableView setBackgroundColor:[UIColor blackColor]];
    concreteNews = [ConcreteNews newInstance];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)updateView {
    [self initData];
}

- (void)initData {
    contentArray = [self getItemArray];
    [SortUtils sortRSSMessage:contentArray];
}

- (NSMutableArray *)getItemArray {
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    NSArray *oriUrls = [[ClientSystemConfig getInstance] rssResourceArray];
    for (NSString *url in oriUrls) {
        if (![urlArray containsObject:url]) {
            [urlArray addObject:url];
        }
    }
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSString *url in urlArray) {
        NSArray *itemArray = [IDNFeedParser feedItemsWithUrl:url];
        if (itemArray == nil || [itemArray count] == 0) {
            continue;
        }
        [tempArray addObjectsFromArray:itemArray];
    }
    //    [self sortArray:tempArray];
    return tempArray;
}


#pragma UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"contentNewsViewCell";
    NewsViewCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"NewsViewCell" bundle:nil];
        [self.contentTableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
        cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
        
    }
    
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    IDNFeedItem *item = [contentArray objectAtIndex:[indexPath row]];
    [cell.titleLabel setText:[item title]];
    [cell.timeLabel setText:[JEDIDateTime stringUIFromDate:[item date]]];
    [cell.newsTypeLabel setText:[item messageTitle]];
    return cell;
}

- (void)setSelect:(UITableViewCell *)cell {
    NewsViewCell *cellView = (NewsViewCell *)cell;
    [cellView.newsTypeLabel setTextColor:[UIColor whiteColor]];
    [cellView.titleLabel setTextColor:[UIColor whiteColor]];
    [cellView.timeLabel setTextColor:[UIColor whiteColor]];
    [cellView setRead:true];
}

- (void)setDeselect:(UITableViewCell *)cell {
    NewsViewCell *cellView = (NewsViewCell *)cell;
    [cellView.newsTypeLabel setTextColor:[UIColor blackColor]];
    [cellView.titleLabel setTextColor:[UIColor blackColor]];
    [cellView.timeLabel setTextColor:[UIColor blackColor]];
    [cellView setRead:false];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    IDNFeedItem *item = [contentArray objectAtIndex:[indexPath row]];
    [concreteNews updateWithFeedItem:item];
    [self addSubview:concreteNews];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [self setSelect:cell];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     [self setDeselect:cell];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setSelect:cell];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [concreteNews setFrame:self.bounds];
}

#pragma listener

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
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_FOREGIN subType:APP_OPT_TYPE_FOREGIN_ITEM_1];
}

@end
