//
//  RssResoursePopView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/16.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "RssResourcePopView.h"
#import "ClientSystemConfig.h"
#import "IosLayoutDefine.h"
#import "TopBarView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "UIView+FreezeTableView.h"
#import "RssResourceAddOrModifyView.h"
#import "IosLogic.h"
#import "ImageUtils.h"
#import "LeftViewController.h"
#import "ShowAlert.h"

#define CellHeight 50.0f

@interface RssResourcePopView()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    UIView *_backgroundView;;
    UIView *contentView;
    UITableView *contentTableView;
    NSMutableArray *contentArray;
    RssResourceAddOrModifyView *rssResourceAddOrModifyView;
    UILongPressGestureRecognizer *longPressGr;
    int deleteIndex;
}

@end

@implementation RssResourcePopView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initRecognizer];
        [self initData];
        [self initComponent];
        [self initLayout];
    }
    return self;
}

#pragma init

- (void)initRecognizer {
    longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressToDo:)];
    longPressGr.minimumPressDuration = 0.8;
}

- (void)initData {
    contentArray = [[ClientSystemConfig getInstance] rssResourceArray];
}

- (void)initComponent {
    [self initTopBar];
    [self initContentView];
    [self initBackground];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)initBackground {
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    rssResourceAddOrModifyView = [RssResourceAddOrModifyView newInstance];
    [rssResourceAddOrModifyView setIndex:-1];
    [rssResourceAddOrModifyView setTarget:self];
    [rssResourceAddOrModifyView setFrame:CGRectMake(20, 110, SCREEN_WIDTH - 40, 115)];
    [rssResourceAddOrModifyView layoutIfNeeded];
    [_backgroundView addSubview:rssResourceAddOrModifyView];
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:rssResourceAddOrModifyView
                                                                               action:@selector(returnKeyboard)];
    
    [_backgroundView addGestureRecognizer:tapGesture];
}

- (void)initLayout {
    [contentView setFrame:CGRectMake(0,SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT)];
    
    //    CGRect contentRect = contentView.frame;
    //    contentRect.origin.y = 0.0f;
    //    contentRect.size.height -= 45.0f;
    //    contentRect.origin.y += 45.0f;
    CGRect contentRect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT);
    [contentTableView setFrame:contentRect];
    
    //    CGRect buttonViewRect = contentView.frame;
    //    buttonViewRect.origin.y = 0.0f;
    //    buttonViewRect.size.height = 45.0f;
    //    [buttonView setFrame:buttonViewRect];
}

- (void)initTopBar{
    
    UIButton *centerButton = [[UIButton alloc] init];
    [centerButton setBackgroundImage:[UIImage imageNamed:@"images/normal/addButton.png"] forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    TopBarView *topBar = [[TopBarView alloc] init];
    //    [topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"SystemConfig"] withMidButton:nil];
    [topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"RSS"] withMidButton:centerButton];
    [self addSubview:topBar];
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    CGPoint centerPoint = CGPointMake(SCREEN_TOPST_HEIGHT / 2, SCREEN_TOPST_HEIGHT / 2);
    CGRect imageRect = CGRectMake(0, 0, 20, 20);
    
    //    [leftButton setFrame:[ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(12, 12, 28, 28)]];
    [leftButton setFrame:CGRectMake(0, SCREEN_STATUS_BAR, SCREEN_TOPST_HEIGHT, SCREEN_TOPST_HEIGHT)];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton addTarget:self action:@selector(reback) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:imageRect]];
    [leftButton addSubview:leftView];
    [leftView setImage:[UIImage imageNamed:@"images/normal/reback.png"]];
    [leftView setCenter:centerPoint];
    
    [topBar addSubview:leftButton];
}

- (void)addAction {
    [rssResourceAddOrModifyView setIndex:-1];
    [rssResourceAddOrModifyView setTitleString:[[LangCaptain getInstance] getLangByCode:@"RssAdd"]];
    UIView *rootView = [[[IosLogic getInstance] getWindow] rootViewController].view;
    UIImage *backImage = [ImageUtils imageWithView:rootView];
    backImage = [backImage blurredImageWithRadius:kDefaultRadius iterations:kDefaultIterations tintColor:[UIColor blackColor]];
    _backgroundView.backgroundColor = [UIColor colorWithPatternImage:backImage];
    [self addSubview:_backgroundView];
}

- (void)initContentView {
    contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    contentTableView = [[UITableView alloc] init];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    [contentTableView setBackgroundColor:[UIColor backgroundColor]];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    
    
    [contentTableView addGestureRecognizer:longPressGr];
    
    [contentView addSubview:contentTableView];
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
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell.textLabel setText:rssResourceURL];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [rssResourceAddOrModifyView setIndex:(int)[indexPath row]];
    [rssResourceAddOrModifyView setTitleString:[[LangCaptain getInstance] getLangByCode:@"RssModify"]];
    UIView *rootView = [[[IosLogic getInstance] getWindow] rootViewController].view;
    UIImage *backImage = [ImageUtils imageWithView:rootView];
    backImage = [backImage blurredImageWithRadius:kDefaultRadius iterations:kDefaultIterations tintColor:[UIColor blackColor]];
    _backgroundView.backgroundColor = [UIColor colorWithPatternImage:backImage];
    [self addSubview:_backgroundView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

- (void)reback {
    [self removeFromSuperview];
}

- (void)updateTable {
    [self initData];
    [contentTableView reloadData];
}

-(void)LongPressToDo:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:contentTableView];
        NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return;
        deleteIndex = (int)[indexPath row];
        [[ShowAlert getInstance] showChooseableAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SystemNotice"]
                                                      andMessage:[[LangCaptain getInstance] getLangByCode:@"RssDeleteWarning"]
                                                        delegate:self];
        
    }
}

#pragma alert delegate

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    // 若点确定
    if (alertView == [[ShowAlert getInstance] chooseableAlertView] && buttonIndex == 1) {
        [contentArray removeObjectAtIndex:deleteIndex];
        [[ClientSystemConfig getInstance] saveConfigData];
        [contentTableView reloadData];
        return;
    }
}
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//    if (alertView == [[ShowAlert getInstance] alertView]) {
//        [[IosLogic getInstance] gotoOrderPositionViewController];
//        return;
//    }
//
//    // 若点确定
//    if (alertView == [[ShowAlert getInstance] chooseableAlertView] && buttonIndex == 1) {
//        [self doOrderTrade];
//        return;
//    }
//}

@end
