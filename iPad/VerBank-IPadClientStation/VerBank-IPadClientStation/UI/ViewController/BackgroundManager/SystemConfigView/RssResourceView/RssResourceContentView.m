//
//  RssResourceContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "RssResourceContentView.h"
#import "LangCaptain.h"
#import "ClientSystemConfig.h"
#import "UIView+AddLine.h"
#import "JumpDataCenter.h"
#import "LayoutCenter.h"
#import "UIColor+CustomColor.h"
#import "ShowAlertManager.h"

const static CGFloat CellHeight = 50.0f;

@interface RssResourceContentView() <UITableViewDataSource, UITableViewDelegate, CustomAlertDelegate> {
    NSMutableArray *contentArray;
    
    NSInteger deleteIndex;
}
@end

@implementation RssResourceContentView

@synthesize backButton;
@synthesize titleLabel;
@synthesize addButton;
@synthesize mainTableView;

- (void)initContent {
    [backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"RSS"]];
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [addButton setBackgroundImage:[UIImage imageNamed:@"images/normal/addButton.png"] forState:UIControlStateNormal];
    
    [addButton setTitle:@"" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    mainTableView.bounces = NO;
    mainTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.showsVerticalScrollIndicator = NO;
    [mainTableView setBackgroundColor:[UIColor grayColor]];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    
    UILongPressGestureRecognizer *longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressToDo:)];
    longPressGr.minimumPressDuration = 0.8;
    [mainTableView addGestureRecognizer:longPressGr];
}

- (void)resetContentView {
    contentArray = [[ClientSystemConfig getInstance] rssResourceArray];
    [mainTableView reloadData];
}

#pragma tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    NSString *rssResourceURL = [contentArray objectAtIndex:[indexPath row]];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addBottomLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    }
    
    if ([indexPath row] == 0) {
        [cell addTopLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    }
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor grayColor]];
    [cell.textLabel setText:rssResourceURL];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[JumpDataCenter getInstance] setRssIndex:[indexPath row]];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showRssModifyView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

#pragma action
- (void)addAction {
    [[JumpDataCenter getInstance] setRssIndex:-1];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showRssModifyView];
}

- (void)backAction {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showSystemConfigView];
}

-(void)LongPressToDo:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:mainTableView];
        NSIndexPath * indexPath = [mainTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return;
        deleteIndex = (int)[indexPath row];
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SystemNotice"]
                                                      andMessage:[[LangCaptain getInstance] getLangByCode:@"RssDeleteWarning"]
                                                        delegate:self];
        
    }
}

-(void)customAlert:(CustomAlertView *)alertView didClickButtonAtIndex:(NSUInteger)index {
    if (index == 1) {
        [contentArray removeObjectAtIndex:deleteIndex];
        [[ClientSystemConfig getInstance] saveConfigData];
        [mainTableView reloadData];
        return;
    }
}

@end
