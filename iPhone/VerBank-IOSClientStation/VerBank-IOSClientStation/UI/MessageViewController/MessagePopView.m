//
//  MessagePopView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MessagePopView.h"
#import "IosLayoutDefine.h"
#import "TopBarView.h"
#import "LangCaptain.h"
#import "TradeApi.h"

@interface MessagePopView() {
    UIView *contentView;
    
    UILabel *_title;
    UILabel *_time;
    UITextView *_textView;
    
    CGFloat titleHeight;
}

@end

@implementation MessagePopView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
        [self initLayout];
    }
    return self;
}

- (void)setMessage:(MessageToAccount *)message {
    _message = [[TradeApi getInstance] queryMessage:[message getGuid]];
    [self updateValue];
}

- (void)updateValue {
    [_title setText:[_message getTitle]];
    [_title setNumberOfLines:0];
    CGSize constraint = CGSizeMake(SCREEN_WIDTH - 20, 20000.0f);
    CGSize size = [[_message getTitle] sizeWithFont:[UIFont systemFontOfSize:20.0f]
                                  constrainedToSize:constraint
                                      lineBreakMode:NSLineBreakByWordWrapping];
    
    [_title setFrame:CGRectMake(0, 0, size.width, size.height)];
    CGPoint point = [_title center];
    titleHeight = size.height + 30;
    point.x = SCREEN_WIDTH / 2;
    [_title setCenter:point];
    [_time setText:[JEDIDateTime stringUIFromDate:[_message getTime]]];
    [_textView setText:[_message getContext]];
    [self initLayout];
}

- (void)initLayout {
    CGRect contentViewRect = CGRectMake(0, SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT);
    CGRect titleRect = CGRectMake(0, 5, SCREEN_WIDTH, titleHeight);
    CGRect timeRect = CGRectMake(0, titleHeight, SCREEN_WIDTH, 20);
    CGRect contRect = CGRectMake(0, titleHeight + 40, SCREEN_WIDTH, SCREEN_HEIGHT - 90 - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT - titleHeight);
    
    [contentView setFrame:contentViewRect];
    [_title setFrame:titleRect];
    [_time setFrame:timeRect];
    [_textView setFrame:contRect];
}

- (void)initComponent {
    [self initTopBar];
    [self initContentView];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)initTopBar{
    TopBarView *topBar = [[TopBarView alloc] init];
    
    [topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"NoticeInformation"] withMidButton:nil];
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

- (void)initContentView {
    titleHeight = 30.0f;
    
    contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    _title = [[UILabel alloc] init];
    
    [_title setTextColor:[UIColor whiteColor]];
    [_title setFont:[UIFont systemFontOfSize:20.0f]];
    [_title setTextAlignment:NSTextAlignmentCenter];
    [contentView addSubview:_title];
    
    _time = [[UILabel alloc] init];
    [_time setTextColor:[UIColor whiteColor]];
    [_time setFont:[UIFont systemFontOfSize:14.0f]];
    [_time setTextAlignment:NSTextAlignmentCenter];
    [contentView addSubview:_time];
    
    _textView = [[UITextView alloc] init];
    [_textView setTextColor:[UIColor whiteColor]];
    [_textView setFont:[UIFont systemFontOfSize:18.0f]];
    [_textView setBackgroundColor:[UIColor clearColor]];
    _textView.userInteractionEnabled = true;
    [_textView setEditable:false];
    [contentView addSubview:_textView];
    
}

- (void)reback {
    [self removeFromSuperview];
}


@end
