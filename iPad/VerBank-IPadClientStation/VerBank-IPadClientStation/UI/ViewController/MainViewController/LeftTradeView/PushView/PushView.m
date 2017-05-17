//
//  NewsView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PushView.h"
#import "ConcretePush.h"
#import "PushViewCell.h"
#import "PushFromSystem.h"
#import "MTP4CommDataInterface.h"
#import "ShowAlertManager.h"
#import "LangCaptain.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "SortUtils.h"

const static CGFloat cellHeight = 70.0f;

@interface PushView()<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray  *contentArray;
    ConcretePush    *concretePush;
}

@end

@implementation PushView

@synthesize contentTableView;

- (void)initContent {
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    [contentTableView setBackgroundColor:[UIColor blackColor]];
    concretePush = [ConcretePush newInstance];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)updateView {
    [self initData];
}

- (void)initData {
    NSString *clientAeid = [[ClientAPI getInstance] aeid];
    TradeResult_SimpleReport *result = [[TradeApi getInstance] report_PushFromSystemAll:clientAeid];
    
    if (![result succeed]) {
        return;
    }
    
    if (contentArray == nil || [contentArray count] == 0) {
        contentArray = [result reportList];
        
    } else {
        NSMutableArray *guidArray = [[NSMutableArray alloc] init];
        for (PushFromSystem *push in contentArray) {
            [guidArray addObject:[push getGuid]];
        }
        
        for (PushFromSystem *push in [result reportList]) {
            if (![guidArray containsObject:[push getGuid]]) {
                [contentArray addObject:push];
            }
        }
    }
    [SortUtils sortPushToAccountArray:contentArray];
}

#pragma UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"contentPushViewCell";
    PushViewCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"PushViewCell" bundle:nil];
        [self.contentTableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
        cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
        
    }
    
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    PushFromSystem *push = [contentArray objectAtIndex:[indexPath row]];
    
    if ([[push getContext] containsString:[[LangCaptain getInstance] getLangByCode:@"NotEnough"]]) {
        [cell.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"MarginCallNotEnough"]];
    } else {
        [cell.titleLabel setText:[push getContext]];
    }
    
    
    [cell.timeLabel setText:[JEDIDateTime stringUIFromDate:[push getTime]]];
    
    if ([push getIsRead] == _TRUE) {
        [self setSelect:cell];
    } else {
        [self setDeselect:cell];
    }
    return cell;
}

- (void)setSelect:(UITableViewCell *)cell {
    PushViewCell *cellView = (PushViewCell *)cell;
    [cellView.titleLabel setTextColor:[UIColor whiteColor]];
    [cellView.timeLabel setTextColor:[UIColor whiteColor]];
    [cellView setRead:true];
}

- (void)setDeselect:(UITableViewCell *)cell {
    PushViewCell *cellView = (PushViewCell *)cell;
    [cellView.titleLabel setTextColor:[UIColor blackColor]];
    [cellView.timeLabel setTextColor:[UIColor blackColor]];
    [cellView setRead:false];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PushFromSystem *push = [contentArray objectAtIndex:[indexPath row]];
    //    [self selectMa:ma];
//    push = [[TradeApi getInstance] queryMessage:[ma getGuid]];
    
    [[TradeApi getInstance] readPushMessage:[[ClientAPI getInstance] aeid]
                                       guid:[push getGuid]];
    [push setIsRead:_TRUE];
    
    [contentArray replaceObjectAtIndex:[indexPath row] withObject:push];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setSelect:cell];
    
//    [concretePush updateWithMessage:push];
    [concretePush updateWithPush:push];
    [self addSubview:concretePush];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setSelect:cell];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PushFromSystem *push = [contentArray objectAtIndex:[indexPath row]];
    if ([push getIsRead] == _TRUE) {
        [self setSelect:cell];
    } else {
        [self setDeselect:cell];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [concretePush setFrame:self.bounds];
}

#pragma listener

//- (void)addListener {
//    [API_IDEventCaptain addListener:DATA_ON_MessageReceive observer:self listener:@selector(messageChange)];
//    
//}
//- (void)removeListener {
//    [API_IDEventCaptain removeListener:DATA_ON_MessageReceive observer:self];
//}

//- (void)messageChange {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self removeListener];
//        [self initData];
//        [self.contentTableView reloadData];
//        [self addListener];
//    });
//}

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
}

@end
