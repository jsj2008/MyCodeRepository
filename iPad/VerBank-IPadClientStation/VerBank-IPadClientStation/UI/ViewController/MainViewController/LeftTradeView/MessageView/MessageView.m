//
//  MessageView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MessageView.h"
#import "UIColor+CustomColor.h"
#import "UIFormat.h"
#import "MessageToAccount.h"
#import "MessageViewCell.h"
#import "ShowAlertManager.h"
#import "LangCaptain.h"

#import "ClientAPI.h"
#import "TradeApi.h"

#import "ConcreteMessage.h"

#import "SortUtils.h"
#import "API_IDEventCaptain.h"

//const static CGFloat titleHeight = 30.0f;
const static CGFloat cellHeight = 70.0f;

@interface MessageView()<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *contentArray;
    ConcreteMessage *concreteMessage;
}

@end

@implementation MessageView

@synthesize contentTableView;

- (void)initContent {
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    [contentTableView setBackgroundColor:[UIColor blackColor]];
    concreteMessage = [ConcreteMessage newInstance];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)updateView {
    [self initData];
}

- (void)initData {
    NSString *clientAeid = [[ClientAPI getInstance] aeid];
    TradeResult_SimpleReport *result = [[TradeApi getInstance] report_MessageToAccount:clientAeid];
    
    if (![result succeed]) {
        return;
    }
    //    contentArray = [result reportList];
    NSDate *monthBeforDate = [NSDate dateWithTimeInterval:-24 * 60 *60 * 30 sinceDate:[NSDate date]];
    contentArray = [[NSMutableArray alloc] init];
    for (MessageToAccount *ma in  [result reportList]) {
        if ([[ma getTime] compare:monthBeforDate] == NSOrderedDescending) {
            [contentArray addObject:ma];
        }
    }
    [SortUtils sortMessageToAccountArray:contentArray];
    
    
    for (MessageToAccount *ma in contentArray) {
        if ([ma getIsRead] != _TRUE) {
            isAllRead = false;
            return;
        }
    }
    isAllRead = true;
}

#pragma UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"contentMessageViewCell";
    MessageViewCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"MessageViewCell" bundle:nil];
        [self.contentTableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
        cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
        
    }
    
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    MessageToAccount *ma = [contentArray objectAtIndex:[indexPath row]];
    [cell.titleLabel setText:[ma getTitle]];
    [cell.timeLabel setText:[JEDIDateTime stringUIFromDate:[ma getTime]]];
    
    if ([ma getIsRead] == _TRUE) {
        [self setSelect:cell];
    } else {
        [self setDeselect:cell];
    }
    return cell;
}

- (void)setSelect:(UITableViewCell *)cell {
    MessageViewCell *cellView = (MessageViewCell *)cell;
    [cellView.titleLabel setTextColor:[UIColor whiteColor]];
    [cellView.timeLabel setTextColor:[UIColor whiteColor]];
    [cellView setRead:true];
}

- (void)setDeselect:(UITableViewCell *)cell {
    MessageViewCell *cellView = (MessageViewCell *)cell;
    [cellView.titleLabel setTextColor:[UIColor blackColor]];
    [cellView.timeLabel setTextColor:[UIColor blackColor]];
    [cellView setRead:false];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MessageToAccount *ma = [contentArray objectAtIndex:[indexPath row]];
    //    [self selectMa:ma];
    ma = [[TradeApi getInstance] queryMessage:[ma getGuid]];
    [contentArray replaceObjectAtIndex:[indexPath row] withObject:ma];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setSelect:cell];
    
    [concreteMessage updateWithMessage:ma];
    [self addSubview:concreteMessage];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setSelect:cell];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MessageToAccount *ma = [contentArray objectAtIndex:[indexPath row]];
    if ([ma getIsRead] == _TRUE) {
        [self setSelect:cell];
    } else {
        [self setDeselect:cell];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [concreteMessage setFrame:self.bounds];
}

#pragma listener

- (void)addListener {
    [API_IDEventCaptain addListener:DATA_ON_MessageReceive observer:self listener:@selector(messageChange)];
    
}
- (void)removeListener {
    [API_IDEventCaptain removeListener:DATA_ON_MessageReceive observer:self];
}

- (void)messageChange {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self initData];
        [self.contentTableView reloadData];
        [self addListener];
    });
}

#pragma override
- (void)reloadPageData {
    [super reloadPageData];
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self.contentTableView];
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

+ (Boolean)getIsAllRead {
    return isAllRead;
}

@end
