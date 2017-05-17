//
//  AccountChooseView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AccountChooseView.h"
#import "ChooseDataCenter.h"
#import "UIView+AddLine.h"
#import "LangCaptain.h"
#import "ShowAlertManager.h"
#import "IosLogic.h"
#import "UserDefaultsSettingKey.h"
#import "TradeApi.h"
#import "ClientAPI.h"
#import "CommDocCaptain.h"
#import "SendDeviceUtil.h"
#import "CheckUtils.h"
#import "LayoutCenter.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

static const CGFloat cellHeight = 40.0f;

@interface AccountChooseView()<UITableViewDelegate, UITableViewDataSource> {}

@end

@implementation AccountChooseView

- (id)init {
    if (self = [super init]) {
        [self setTableViewDelegate];
        [self initData];
        [self setTitle:[[LangCaptain getInstance] getLangByCode:@"AccountChoose"]];
    }
    return self;
}

- (void)setTableViewDelegate {
    [self.contentTableView setDelegate:self];
    [self.contentTableView setDataSource:self];
}

- (void)initData {
    self.contentArray = [[ChooseDataCenter getInstance] accountChooseArray];
    [[ChooseDataCenter getInstance] resetData];
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIndentifier = @"tradeContentView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: CellIndentifier];
        [cell addBottomLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    }
    NSLog(@"%ld", [indexPath row]);
    
    [self setLeftTableViewCell:cell withIndex:indexPath];
    cell.selectedBackgroundView.backgroundColor = [UIColor greenColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (void) setLeftTableViewCell:(UITableViewCell *) cell withIndex:(NSIndexPath *)indexPath {
    AccountBasic *ac = [self.contentArray objectAtIndex:[indexPath row]];
    [cell.textLabel setText:[@([ac getAccount]) stringValue]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    long long account = [@([[self.contentArray objectAtIndex:[indexPath row]] getAccount]) longLongValue];
    [[ClientAPI getInstance] setAccountID:account];
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsInitDoc"] onView:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        Boolean flag = [[IosLogic getInstance] setAccount:account];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            
            if(flag){
                // iosDelay
                //                if ([[DataCenter getInstance] messageIsAllRead]) {
                //                    [[IosLogic getInstance] gotoQuoteListViewController];
                //                } else {
                //                    [[IosLogic getInstance] gotoMessageViewController];
                //                }
              
                
                [[IosLogic getInstance] gotoMainViewController];
//                if (![CheckUtils messageIsAllRead]) {
//                    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_Message];
//                }
                
                // 另起线程
                [SendDeviceUtil sendDevice:[@(account) stringValue]];
                [SendDeviceUtil sendPriceWarningRead];
                //                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //                    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
                //                    [[TradeApi getInstance] setDeviceTokenAeid:[[ClientAPI getInstance] aeid]
                //                                                     accountID:[@(account) stringValue]
                //                                                     groupName:[[[CommDocCaptain getInstance] getUserDocCaptain] getGroupNameByAccount:account]
                //                                                   deviceToken:deviceToken
                //                                                    deviceType:PUSH_TYPE_IPHONE];
                //                });
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_LOGIN subType:APP_OPT_TYPE_NONE];
                [[OperationRecordsSave getInstance] sendToServer];
            }else{
                NSString * errMsg=[[LangCaptain getInstance] getErrMessageByCode:@"initDocFailed"];
                [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"]
                                                                  andMessage:errMsg
                                                                    delegate:nil];
                //                 showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"] andMessage:errMsg];
            }
        });
    });
}

@end
