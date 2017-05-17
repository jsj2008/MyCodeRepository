//
//  ChooseViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/20.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ChooseViewController.h"
#import "IosLayoutDefine.h"
#import "AccountBasic.h"
#import "ShowAlert.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "TopBarView.h"
#import "IosLogic.h"
#import "UIView+FreezeTableView.h"
#import "UserDefaultsSettingKey.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "CommDocCaptain.h"
#import "SendDeviceUtil.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface ChooseViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *_chooseTableView;
    
    NSArray *_chooseArray;
    NSString *_title;
    
    int _chooseType;
}

@end

@implementation ChooseViewController

- (id)initWithChooseType:(int)type chooseArray:(NSArray *)array{
    if (self = [super init]) {
        _chooseType = type;
        
        if (_chooseType == AccountChoose) {
            _title = [[LangCaptain getInstance] getLangByCode:@"AccountChoose"];
        }
        
        if (_chooseType == InstrumentChoose) {
            // 新增价格提示
            _title = [[LangCaptain getInstance] getLangByCode:@"InstrumentChoose"];
        }
        
        if (_chooseType == OrderChoose) {
            // 新增挂单 商品选择
            _title = [[LangCaptain getInstance] getLangByCode:@"InstrumentChoose"];
        }
        
        _chooseArray = array;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self initPreData];
    [self initLayout];
}

//- (void)initPreData{
//    switch (_chooseType) {
//        case AccountChoose:
//            _title = @"账户选择";
//            break;
//        default:
//            _title = @"none";
//            break;
//    }
//}

- (void)initLayout{
    [self initTableView];
    [self initTopBar];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_chooseTableView];
    
    if (IOS7_OR_LATER) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

- (void)initTableView{
    CGRect tableViewRect = CGRectMake(0,
                                      SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT,
                                      SCREEN_WIDTH,
                                      SCREEN_HEIGHT - SCREEN_TOPST_HEIGHT - SCREEN_STATUS_BAR);
    
    _chooseTableView = [[UITableView alloc] initWithFrame:tableViewRect];
    [_chooseTableView setDelegate:self];
    [_chooseTableView setDataSource:self];
    _chooseTableView.bounces = false;
    _chooseTableView.rowHeight = 45;
    _chooseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_chooseTableView setBackgroundColor:[UIColor backgroundColor]];
}

- (void)initTopBar{
    TopBarView *topBar = [[TopBarView alloc] init];
    
    [topBar setTitleName:_title withMidButton:nil];
    [self.view addSubview:topBar];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *chooseIdentifier = @"ChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             chooseIdentifier];
    
    if (_chooseType == AccountChoose) {
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseIdentifier];
        }
        
        NSUInteger row = [indexPath row];
        cell.textLabel.text = [@([[_chooseArray objectAtIndex:row] getAccount]) stringValue];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell setBackgroundColor:[UIColor backgroundColor]];
        if ([indexPath row] == 0) {
            [cell addTopLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
        }
        
        [cell addBottomLineWithWidth:0.8f bgColor:[UIColor whiteColor]];
    }
    
    if (_chooseType == InstrumentChoose || _chooseType == OrderChoose) {
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:chooseIdentifier];
        }
        
        cell.textLabel.text = [_chooseArray objectAtIndex:[indexPath row]] ;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell setBackgroundColor:[UIColor backgroundColor]];
        [cell addBottomLineWithWidth:0.8f bgColor:[UIColor whiteColor]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_chooseType == AccountChoose) {
        
        long long account = [[_chooseArray objectAtIndex:[indexPath row]] getAccount];
        
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsInitDoc"] onView:self.view];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            Boolean flag = [[IosLogic getInstance] setAccount:account];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] hidenAlertWaitView];
                
                if(flag){
                    if ([[DataCenter getInstance] messageIsAllRead]) {
                        [[IosLogic getInstance] gotoQuoteListViewController];
                    } else {
                        [[IosLogic getInstance] gotoMessageViewController];
                    }
                    
//                    [NSThread detachNewThreadSelector:@selector(setDeviceToken:)
//                                             toTarget:self
//                                           withObject:[@(account) stringValue]];
                    [SendDeviceUtil sendDevice:[@(account) stringValue]];
                    [SendDeviceUtil sendPriceWarningRead];
                    
                    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_LOGIN subType:APP_OPT_TYPE_NONE];
                    [[OperationRecordsSave getInstance] sendToServer];
                    //                    // 另起线程
                    //                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    //                        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
                    //                        [[TradeApi getInstance] setDeviceTokenAeid:[[ClientAPI getInstance] aeid]
                    //                                                         accountID:[@(account) stringValue]
                    //                                                         groupName:[[[CommDocCaptain getInstance] getUserDocCaptain] getGroupNameByAccount:account]
                    //                                                       deviceToken:deviceToken
                    //                                                        deviceType:PUSH_TYPE_IPHONE];
                    //                    });
                }else{
                    NSString * errMsg=[[LangCaptain getInstance] getErrMessageByCode:@"initDocFailed"];
                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"] andMessage:errMsg];
                }
            });
        });
    }
    
    if (_chooseType == InstrumentChoose) {
        NSString *instrument = [_chooseArray objectAtIndex:[indexPath row]];
        [[DataCenter getInstance] setPriceWarning:nil];
        [[DataCenter getInstance] setPriceWarningInstrument:instrument];
        [[IosLogic getInstance] gotoPriceWarningAddOrModifyViewController];
    }
    
    if (_chooseType == OrderChoose) {
        NSString *instrument = [_chooseArray objectAtIndex:[indexPath row]];
        [[DataCenter getInstance] setOrder:nil];
        [[DataCenter getInstance] setOrderInstrument:instrument];
        [[IosLogic getInstance] gotoOrderAddOrModifyViewController];
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (_chooseArray == nil) ? 0 : [_chooseArray count];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
