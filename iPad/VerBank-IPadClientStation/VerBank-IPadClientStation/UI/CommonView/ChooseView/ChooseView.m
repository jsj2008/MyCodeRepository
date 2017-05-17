//
//  ChooseView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ChooseView.h"
#import "IOSLayoutDefine.h"
#import "UIView+AddLine.h"

static const CGFloat titleLabelHeight = 40.0f;

@interface ChooseView() {
//    NSArray         *_chooseArray;
    
    UIView          *contentView;
    UILabel         *titleLabel;
//    UITableView     *contentTableView;
}

@end

@implementation ChooseView

@synthesize contentArray;
@synthesize contentTableView;

- (id)init {
    if (self = [super init]) {
        [self initChooseView];
    }
    return self;
}

- (void)initChooseView {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self setBackgroundColor:[UIColor grayColor]];
    [self initContentView];
    [self initTitleLabel];
    [self initTableView];
}

- (void)initContentView {
    CGFloat contentViewWidth = SCREEN_WIDTH / 3;
    CGFloat contentViewHeight = SCREEN_HEIGHT / 4 * 3;
    CGFloat contentViewLeft = (SCREEN_WIDTH - contentViewWidth) / 2;
    CGFloat contentViewTop = (SCREEN_HEIGHT - contentViewHeight) / 2;
    CGRect contentViewRect = CGRectMake(contentViewLeft, contentViewTop, contentViewWidth, contentViewHeight);
    contentView = [[UIView alloc] initWithFrame:contentViewRect];
    contentView.layer.cornerRadius = 10.0f;
    [contentView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:contentView];
}

- (void)initTitleLabel {
    CGRect titleLabelRect = CGRectMake(0, 0, contentView.frame.size.width, titleLabelHeight);
    titleLabel = [[UILabel alloc] initWithFrame:titleLabelRect];
    [titleLabel setText:@"DefaultTitle"];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel addBottomLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    [contentView addSubview:titleLabel];
}

- (void)initTableView {
    CGRect tableViewRect = CGRectMake(0, titleLabelHeight, contentView.frame.size.width, contentView.frame.size.height - titleLabelHeight * 2);
    contentTableView = [[UITableView alloc] initWithFrame:tableViewRect];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
//    [contentTableView setDelegate:self];
//    [contentTableView setDataSource:self];
    [contentTableView setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:contentTableView];
}

- (void)setTitle:(NSString *)title {
    [titleLabel setText:title];
}



@end
