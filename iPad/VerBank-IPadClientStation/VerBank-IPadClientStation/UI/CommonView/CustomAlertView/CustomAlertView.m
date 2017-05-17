//
//  CustomAlertView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CustomAlertView.h"

// alertView layout
static const CGFloat alertViewWidth     = 270.0;
static const CGFloat alertViewHeight    = 220;
static const CGFloat titleHeight        = 50.0;
static const CGFloat imageViewHeight    = 120;
static const CGFloat buttonHeight       = 50;

@interface CustomAlertView()

@property (strong, nonatomic)UIView      *alertview;
@property (strong, nonatomic)UIView      *backgroundview;
@property (strong, nonatomic)NSString    *alertTitle;
@property (strong, nonatomic)NSString    *alertCancelButtonTitle;
@property (strong, nonatomic)NSString    *alertOkButtonTitle;
@property (strong, nonatomic)NSString    *alertContentMessage;

@end

@implementation CustomAlertView

@synthesize alertview;
@synthesize backgroundview;
@synthesize alertTitle;
@synthesize alertCancelButtonTitle;
@synthesize alertOkButtonTitle;
@synthesize alertContentMessage;
@synthesize contentMessageButton;

#pragma init
-(instancetype)initWithTitle:(NSString *)title
              contentMessage:(NSString *)contentMessage
                cancelButton:(NSString *)cancelButton
                    okButton:(NSString *)okButton {
    if (self = [super initWithFrame:[[UIApplication sharedApplication] keyWindow].frame]) {
        self.alertTitle = title;
        self.alertContentMessage = contentMessage;
        self.alertCancelButtonTitle = cancelButton;
        self.alertOkButtonTitle = okButton;
        [self setUp];
    }
    return self;
}

#pragma mark -  private function
-(UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title {
    UIButton * button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor blueColor];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    return button;
}

- (UIButton *)createContentButtonWithFrame:(CGRect)frame title:(NSString *)title {
    UIButton * button = [[UIButton alloc] initWithFrame:frame];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    CGFloat size = 14.0f;
    if ([title length] > 100) {
        size = 12.0f;
    }
    
    if ([title length] <100 && [title length] > 50) {
        size = 14.0f;
    }
    
    if ([title length] < 50) {
        size = 16.0f;
    }
    [button.titleLabel setFont: [UIFont systemFontOfSize:size]];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;

    //    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    button.titleLabel.minimumScaleFactor = 0.5;
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [button setShowsTouchWhenHighlighted:NO];
    return button;
}

-(void)clickButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(customAlert:didClickButtonAtIndex:)]) {
//        [self.delegate didClickButtonAtIndex:(button.tag -1)];
        [self.delegate customAlert:self didClickButtonAtIndex:button.tag - 1];
    }
    [self dismiss];
}

-(void)setUp{
    self.backgroundview = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].frame];
    self.backgroundview.backgroundColor = [UIColor blackColor];
    self.backgroundview.alpha = 0.4;
    [self addSubview:self.backgroundview];
    
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    //    [self.backgroundview addGestureRecognizer:tap];
    
    self.alertview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertViewWidth, alertViewHeight)];
    self.alertview.layer.cornerRadius = 17;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    self.alertview.center = CGPointMake(CGRectGetMidX(keywindow.frame), CGRectGetMidY(keywindow.frame));
    self.alertview.backgroundColor = [UIColor whiteColor];
    self.alertview.clipsToBounds = YES;
    
    [self addSubview:self.alertview];
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,alertViewWidth,titleHeight)];
    titleLabel.text = self.alertTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.alertview addSubview:titleLabel];
    
    CGRect contentButtonFrame = CGRectMake(0, titleHeight, alertViewWidth, imageViewHeight - 10);
    if (self.alertContentMessage.length != 0 && self.alertContentMessage != nil) {
        self.contentMessageButton = [self createContentButtonWithFrame:contentButtonFrame title:self.alertContentMessage];
        [self.alertview addSubview:self.contentMessageButton];
    }
    
    CGRect cancelButtonFrame = CGRectMake(0, titleHeight + imageViewHeight,alertViewWidth,buttonHeight);
    if (self.alertOkButtonTitle.length != 0 && self.alertOkButtonTitle !=nil) {
        cancelButtonFrame = CGRectMake(alertViewWidth / 2 ,titleHeight + imageViewHeight, alertViewWidth / 2,buttonHeight);
        CGRect okButtonFrame = CGRectMake(0,titleHeight + imageViewHeight, alertViewWidth / 2,buttonHeight);
        UIButton * okButton = [self createButtonWithFrame:okButtonFrame title:self.alertOkButtonTitle];
        okButton.tag = 2;
        [self.alertview addSubview:okButton];
        
    }
    UIButton * cancelButton = [self createButtonWithFrame:cancelButtonFrame title:self.alertCancelButtonTitle];
    cancelButton.tag = 1;
    [self.alertview addSubview:cancelButton];
}

#pragma mark -  Action
-(void)dismiss{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.0;
        CGAffineTransform rotate = CGAffineTransformMakeRotation(0.0);
        CGAffineTransform scale = CGAffineTransformMakeScale(0.1, 0.1);
        self.alertview.transform = CGAffineTransformConcat(rotate, scale);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];
}

- (void)show {
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self];
    
    [UIView animateWithDuration:0.1 animations:^{
        CGAffineTransform rotate = CGAffineTransformMakeRotation(0.0);
        CGAffineTransform scale = CGAffineTransformMakeScale(1.2, 1.2);
        self.alertview.transform = CGAffineTransformConcat(rotate, scale);
    } completion:^(BOOL finished) {
        //        [self removeFromSuperview];
        //        self.alertview = nil;
    }];
    
}

#pragma mark - Gesture

-(void)click:(UITapGestureRecognizer *)sender{
    CGPoint tapLocation = [sender locationInView:self.backgroundview];
    CGRect alertFrame = self.alertview.frame;
    if (!CGRectContainsPoint(alertFrame, tapLocation)) {
        [self dismiss];
    }
}

@end
