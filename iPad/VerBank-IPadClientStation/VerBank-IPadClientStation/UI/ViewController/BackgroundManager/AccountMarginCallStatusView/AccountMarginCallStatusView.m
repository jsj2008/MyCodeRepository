//
//  AccountMarginCallStatusView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AccountMarginCallStatusView.h"
#import "IOSLayoutDefine.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
//#import "MarginCallCellView.h"
#import "AccountMarginCallStatusCell.h"
#import "UIView+AddLine.h"
#import "UIFormat.h"
#import "MarginCallDataInitUtil.h"
#import "ShowAlertManager.h"
#import "CertificateUtil.h"
#import "AccountUtil.h"
#import "QuoteDataStore.h"
#import "PhonePinChecker.h"
#import "LayoutCenter.h"
#import "TradeActionUtil.h"

static const CGFloat titleLabelHeight          = 50.0f;
static const CGFloat accountLabelHeight        = 45.0f;
static const CGFloat certificatePwdLabelHeight = 45.0f;
static const CGFloat contentTableViewCellHeight= 42.0f;

@interface AccountMarginCallStatusView()<UITableViewDataSource, UITableViewDelegate, API_Event_QuoteDataStore> {
    UILabel                         *_titleLabel;
    AccountMarginCallStatusCell     *_accountLabel;
    AccountMarginCallStatusCell     *_certificatePwdStatusLabel;
    UITableView                     *_contentTableView;
    
    NSDictionary                    *contentDic;
}

@end

@implementation AccountMarginCallStatusView

- (id)init {
    if (self = [super init]) {
        [self setDefault];
        [self initData];
        [self initComponent];
    }
    return self;
}

#pragma init

- (void)initData {
    MarginCallDataInitUtil *util = [[MarginCallDataInitUtil alloc] init];
    contentDic = [util getMarginCallDic];
    
    self.contentArray = [[LangCaptain getInstance] getMarginCallConfig];
}

- (void)setDefault {
    self.status = Closed;
}

- (void)initComponent {
    [self initMarginCallTableView];
    [self initTitle];
    [self initAccountLabel];
    [self initCertificatePwdStatusLabel];
}

- (void)initTitle {
    CGRect titleLabelRect = self.bounds;
    titleLabelRect.size.height = titleLabelHeight;
    _titleLabel = [[UILabel alloc] initWithFrame:titleLabelRect];
    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"MarginCallHis"]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setBackgroundColor:[UIColor marginCallViewTitleColor]];
    [self addSubview:_titleLabel];
}

- (void)initAccountLabel {
    CGRect accountLabelRect = self.bounds;
    accountLabelRect.origin.y = titleLabelHeight;
    accountLabelRect.size.height = accountLabelHeight;
    //    _accountLabel = [MarginCallCellView newInstance];
    _accountLabel = [self getAccountMarginCallStatusCell];
    [_accountLabel setFrame:accountLabelRect];
    [_accountLabel.marginCallLeftLabel setText:[NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    [_accountLabel.marginCallRightLabel setText:@""];
    [_accountLabel addBottomLineWithWidth:1.0f bgColor:[UIColor blackColor]];
    [self addSubview:_accountLabel];
}

- (void)initCertificatePwdStatusLabel {

    //    _certificatePwdStatusLabel = [MarginCallCellView newInstance];
    _certificatePwdStatusLabel = [self getAccountMarginCallStatusCell];
    
    [_certificatePwdStatusLabel.marginCallLeftLabel setText:[[LangCaptain getInstance] getLangByCode:@"CertificatePwdStatus"]];
    [self addSubview:_certificatePwdStatusLabel];
    [self resetPhonePinState];
}

- (void)resetPhonePinState {
    CGRect certificatePwdLabelRect = self.bounds;
    certificatePwdLabelRect.origin.y = titleLabelHeight + accountLabelHeight;
    certificatePwdLabelRect.size.height = certificatePwdLabelHeight;
    
//    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePingStateChecking"]
//                                                          onView:self.superview];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Boolean isNeedInputPhonePin = [[PhonePinChecker getInstance] checkIsneedputPhonePin];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [[ShowAlertManager getInstance] hidenAlertWaitView];
            NSMutableAttributedString *content = nil;
            if (isNeedInputPhonePin) {
                content = [[NSMutableAttributedString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"Reinput"]];
            } else {
                content = [[NSMutableAttributedString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"InputAlready"]];
            }
            NSRange contentRange = NSMakeRange(0, [content length]);
            [content addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                            range:contentRange];
            _certificatePwdStatusLabel.marginCallRightLabel.attributedText = content;
            [_certificatePwdStatusLabel.marginCallRightLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCertificateState)]];
            [_certificatePwdStatusLabel.marginCallRightLabel setTextColor:[UIColor redColor]];
            _certificatePwdStatusLabel.marginCallRightLabel.userInteractionEnabled = YES;
            [_certificatePwdStatusLabel setFrame:certificatePwdLabelRect];
            
        });
    });
}

- (void)clickCertificateState {
    if ([[PhonePinChecker getInstance] checkIsneedputPhonePin]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        [[TradeActionUtil getInstance] setCurrentFunctionTrade:Function_Trade_Unknow];
    }
}

- (void)initMarginCallTableView {
    CGRect contentTableViewRect = self.bounds;
    contentTableViewRect.origin.y = titleLabelHeight + accountLabelHeight + certificatePwdLabelHeight;
    contentTableViewRect.size.height -= contentTableViewRect.origin.y;
    _contentTableView = [[UITableView alloc] initWithFrame:contentTableViewRect];
    _contentTableView.dataSource = self;
    _contentTableView.delegate = self;
    
    _contentTableView.bounces = NO;
    _contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_contentTableView];
}

#pragma action

- (void)openView {
    [super openView];
    [self addListener];
}

- (void)closeView {
    [super closeView];
    [self removeListener];
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    MarginCallDataInitUtil *util = [[MarginCallDataInitUtil alloc] init];
    contentDic = [util getMarginCallDic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_contentTableView reloadData];
        [_accountLabel.marginCallLeftLabel setText:[NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    });
}

// 暫時不想改了， 最好改成定製的規範
- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *keyName = [self.contentArray objectAtIndex:[indexPath row]];
    AccountMarginCallStatusCell *cell = [self getAccountMarginCallStatusCell];
    
    [cell.marginCallLeftLabel setText:keyName];
    [cell.marginCallRightLabel setText:[contentDic objectForKey:keyName]];
    
    if ([indexPath row] == [self.contentArray count] - 1 || [indexPath row] == [self.contentArray count] - 2) {
        NSString *valueString = cell.marginCallRightLabel.text;
        if ([valueString containsString:@"-"]) {
            [cell.marginCallRightLabel setTextColor:[UIColor redDownColor]];
        } else if ([valueString isEqualToString:@"0.00"]) {
            [cell.marginCallRightLabel setTextColor:[UIColor blackColor]];
        } else {
            [cell.marginCallRightLabel setTextColor:[UIColor blueButtonColor]];
        }
    }
    
    if ([indexPath row] == [self.contentArray count] - 1 ) {
        [cell.bottomLineView setBackgroundColor:[UIColor whiteColor]];
    } else {
        [cell.bottomLineView setBackgroundColor:[UIColor blackColor]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return contentTableViewCellHeight;
}

- (void)dealloc {
    [self removeListener];
}

- (AccountMarginCallStatusCell *)getAccountMarginCallStatusCell {
    NSString *cellIndentifier = @"MarginCallContentIdentifier";
    AccountMarginCallStatusCell *cell = (AccountMarginCallStatusCell *)[_contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"AccountMarginCallStatusCell" bundle:nil];
        [_contentTableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
        cell = [_contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

@end
