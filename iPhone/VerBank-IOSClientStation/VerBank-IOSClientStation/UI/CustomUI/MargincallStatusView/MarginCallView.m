//
//  MarginCallView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/25.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MarginCallView.h"
#import "IosLayoutDefine.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"
#import "LangCaptain.h"
#import "MarginCallCellView.h"
#import "MarginCallDataInitUtil.h"
#import "QuoteDataStore.h"
#import "MarginCallDataInitUtil.h"
#import "ClientAPI.h"
#import "AccountUtil.h"
#import "CertificateUtil.h"
#import "PhonePinInputView.h"
#import "IosLogic.h"
#import "TradeApi.h"
#import "ShowAlert.h"

#define MarginCellHeight [ScreenAuotoSizeScale CGAutoMakeFloat:25.0f]
#define AccountHeight [ScreenAuotoSizeScale CGAutoMakeFloat:60.0f]
#define Edge [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f]

#define SubviewTag 101
#define SubviewLineTag 102

@interface MarginCallView()<UITableViewDataSource, UITableViewDelegate, API_Event_QuoteDataStore>{
    UITableView *contentTableView;
    UIButton * certificateButton;
    
    NSArray *contentArray;
    NSDictionary *contentDic;
    PhonePinInputView *phonePinInputView;
}

@end

@implementation MarginCallView

- (id)initWithContentArray:(NSArray *)array {
    
    double currentHeight = [array count] * MarginCellHeight + TitleHeight + AccountHeight + BottomHeight;
    double height = currentHeight > ShowViewMaxHeight ? ShowViewMaxHeight : currentHeight;
    CGRect frame = CGRectMake((SCREEN_WIDTH - ShowViewWidth) / 2,
                              ShowViewDistanceFromTop,
                              ShowViewWidth,
                              height);
    
    if (self = [super initWithFrame:frame]) {
        contentArray = array;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initLayout];
        [self initTableView];
        [self initData];
        [self addListener];
    }
    return self;
}

- (void)initLayout {
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:15.0f];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ShowViewWidth, TitleHeight)];
    [titleView setBackgroundColor:[UIColor marginCallViewTitleColor]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.bounds];
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"MarginCallStatus"]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    UIView *accountView = [[UIView alloc] init];
    [accountView setFrame:CGRectMake(0, TitleHeight, ShowViewWidth, AccountHeight)];
    
    UILabel *accountLabel = [[UILabel alloc] init];
    [accountLabel setFrame:CGRectMake(Edge, 0, ShowViewWidth - Edge * 2, AccountHeight / 2)];
    [accountLabel setText:[NSString stringWithFormat:@"%@:%@",[[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    
    UILabel *certificateLabel = [[UILabel alloc] init];
    [certificateLabel setFrame:CGRectMake(Edge, AccountHeight / 2, ShowViewWidth / 2 - Edge, AccountHeight / 2)];
    [certificateLabel setText:[[LangCaptain getInstance] getLangByCode:@"CertificatePwdStatus"]];
    
    // button title style
    //    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[[LangCaptain getInstance] getLangByCode:@"Reinput"]];
    //    NSRange contentRange = {0,[content length]};
    //    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    //    [content addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:contentRange];
    
    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(0, AccountHeight / 2 , ShowViewWidth, 1.0f)];
    [middleLine setBackgroundColor:[UIColor marginCallViewTitleColor]];
    
    certificateButton = [[UIButton alloc] init];
    [certificateButton setFrame:CGRectMake(ShowViewWidth / 2, AccountHeight / 2, ShowViewWidth / 2 - Edge, AccountHeight / 2)];
    [certificateButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [titleView addSubview:titleLabel];
    [self addSubview:titleView];
    [self addSubview:accountView];
    [accountView addSubview:accountLabel];
    [accountView addSubview:certificateLabel];
    [accountView addSubview:certificateButton];
    [accountView addSubview:middleLine];
    
    //    [self addCertificateButtonTitle];
    
    self.userInteractionEnabled = YES;
}

- (void)addCertificateButtonTitle {
    
    UIView *subView = [certificateButton viewWithTag:SubviewTag];
    if (subView != nil) {
        [subView removeFromSuperview];
    }
    
    subView = [certificateButton viewWithTag:SubviewLineTag];
    if (subView != nil) {
        [subView removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setTag:SubviewTag];
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePingStateChecking"]
                                                   onView:self.superview];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Boolean isNeedInputPhonePin = [CertificateUtil checkPhonePinByValidate];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            if (isNeedInputPhonePin) {
                [label setText:[[LangCaptain getInstance] getLangByCode:@"Reinput"]];
            } else {
                [label setText:[[LangCaptain getInstance] getLangByCode:@"InputAlready"]];
            }
            [label sizeToFit];
            CGRect buttonFrame = certificateButton.bounds;
            CGRect labelFrame = label.frame;
            CGPoint centerPoint = CGPointMake(buttonFrame.size.width - labelFrame.size.width / 2, buttonFrame.size.height / 2);
            [label setCenter:centerPoint];
            [label setTextColor:[UIColor redColor]];
            
            CGRect textLineFrame = label.frame;
            textLineFrame.origin.y += textLineFrame.size.height;
            textLineFrame.size.height = 1.0f;
            UIView *textLine = [[UIView alloc] initWithFrame:textLineFrame];
            [textLine setBackgroundColor:[UIColor redColor]];
            [textLine setTag:SubviewLineTag];
            [certificateButton addSubview:textLine];
        });
    });
    
    
    [certificateButton addSubview:label];
    
}

- (void)initTableView {
    
    CGRect tableViewRect = CGRectMake(0, TitleHeight + AccountHeight, ShowViewWidth, self.frame.size.height - TitleHeight * 2);
    
    contentTableView = [[UITableView alloc] init];
    [contentTableView setFrame:tableViewRect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    
    
    [self addSubview:contentTableView];
}

- (void)initData {
    MarginCallDataInitUtil *util = [[MarginCallDataInitUtil alloc] init];
    contentDic = [util getMarginCallDic];
    //    contentDic = [[MarginCallDataInitUtil getInstance] getMarginCallDic];
}

- (void)click {
    //    NSLog(@"click");
    
    if ([CertificateUtil checkIsneedputPhonePin]) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        phonePinInputView = [PhonePinInputView newInstance];
        [phonePinInputView setFrame:InputPinViewRect];
        UIView *rootView = [[[IosLogic getInstance] getWindow] rootViewController].view;
        [rootView addSubview:backView];
        [backView addSubview:phonePinInputView];
        [phonePinInputView.inputFeild setText:@""];
        [phonePinInputView.cancelButton addTarget:self
                                           action:@selector(phonePinCancel:)
                                 forControlEvents:UIControlEventTouchUpInside];
        [phonePinInputView.commitButton addTarget:self
                                           action:@selector(phonePinCommit:)
                                 forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)phonePinCancel:(id)sender {
    [[[sender superview] superview] removeFromSuperview];
}

- (void)phonePinCommit:(id)sender {
    [[(PhonePinInputView *)[sender superview] inputFeild] resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        long long account = [[ClientAPI getInstance] getAccount];
        NSString *phonePin = ((PhonePinInputView *)[sender superview]).inputFeild.text;
        if (phonePin == nil || [phonePin isEqualToString:@""]) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinIsNil"]];
            return;
        }
        int checkType = [[TradeApi getInstance] checkAccount:account
                                                    phonePin:phonePin];
        if (checkType == CA_TRADE_SUCCEED) {
            [[DataCenter getInstance] setPhonePin:phonePin];
            [[DataCenter getInstance] resetPhonePinErr];
            [CertificateUtil resetTimeTickIsEnterBackground:false];
            [[[sender superview] superview] removeFromSuperview];
            //        [self doClosePositionAction];
            //        UILabel *label = (UILabel *)[certificateButton viewWithTag:SubviewTag];
            //        if ([CertificateUtil needInputPhonePin]) {
            //            [label setText:[[LangCaptain getInstance] getLangByCode:@"Reinput"]];
            //        } else {
            //            [label setText:[[LangCaptain getInstance] getLangByCode:@"InputAlready"]];
            //        }
            //        [label sizeToFit];
            [self addCertificateButtonTitle];
        } else if (checkType == USERIDENTIFY_RESULT_ERR_NETERR) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"ERR_NetErr"]];
        } else {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinErr"]];
            [[DataCenter getInstance] phonePinErr];
        }
    });
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *keyName = [contentArray objectAtIndex:[indexPath row]];
    
    MarginCallCellView *cellView = [MarginCallCellView newInstance];
    CGRect cellViewRect = CGRectMake(0, 0, ShowViewWidth, MarginCellHeight);
    [cellView setFrame:cellViewRect];
    [cellView layoutIfNeeded];
    [cell addSubview:cellView];
    
    [cellView.keyName setText:keyName];
    [cellView.value setText:[contentDic objectForKey:keyName]];
    
    // 暫時寫最後兩行
    if ([contentArray count] - 3 < [indexPath row]) {
        if ([cellView.value.text doubleValue] > 0.0001) {
            [cellView.value setTextColor:[UIColor blueColor]];
        } else {
            [cellView.value setTextColor:[UIColor redColor]];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MarginCellHeight;
}

#pragma listener
- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    //    contentDic = [[MarginCallDataInitUtil getInstance] getMarginCallDic];
    MarginCallDataInitUtil *util = [[MarginCallDataInitUtil alloc] init];
    contentDic = [util getMarginCallDic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [contentTableView reloadData];
    });
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self removeListener];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[phonePinInputView superview] removeFromSuperview];
}

@end
