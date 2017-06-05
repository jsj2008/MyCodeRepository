//
//  MoxieSDK.h
//  MoxieSDK
//
//  Created by shenzw on 6/23/16.
//  Copyright © 2016 shenzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MoxieSDKDelegate<NSObject>
#pragma mark - SDK 代理回调接口
/**
 结果回调函数
 */
@required
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary;
@end


@interface MoxieSDK : NSObject
#pragma mark - SDK 函数接口
/**
 *  SDK单例
 */
+(MoxieSDK*)shared;
/**
 *  打开SDK功能函数，如果需要自定义，请设置loginCustom参数
 */
-(void)startFunction;
#pragma mark - SDK 基本参数（只读）
/**
 * SDK版本号
 */
@property (nonatomic,copy,readonly) NSString *mxSDKVersion;

#pragma mark - SDK 打开必传配置参数 （必传）
/**
 * 接受回调的代理
 */
@property (nonatomic,weak) id <MoxieSDKDelegate> delegate;
/**
 * 来自controller，用来做push或present
 */
@property (nonatomic,weak) UIViewController *fromController;
/**
 *  用户id标识
 */
@property (nonatomic,copy) NSString *mxUserId;
/**
 *  ApiKey
 */
@property (nonatomic,copy) NSString *mxApiKey;
/**
 * 打开的任务类型
 */
@property (nonatomic,copy) NSString *taskType;
#pragma mark - SDK 通用自定义动态传递参数列表（可选）
/**
 * 打开的任务类型
 */
@property (nonatomic,copy) NSString *loginVersion;
/**
 * 自定义登录元素
  loginCode 如网银为bankId，公积金为areaCode等，为nil时打开列表页/首页
  loginType 如网银为CREDITCARD/DEBITCARD
  如打开网银-招商银行-信用卡-身份证登录-预填username，且隐藏其他登录方式，如下：
  @{
    @"loginCode":@"CMB",
    @"loginType":@"CREDITCARD",
    @"loginParams":@{
                        @"IDCARD":@{@"username":@"330501198910101010"}
                    },
    @"loginOthersHide":@YES
  }
 */
@property (nonatomic,strong) NSDictionary *loginCustom;
/**
 *  运营商默认手机号码
 */
@property (nonatomic,copy) NSString *carrier_phone;
/**
 *  运营商默认服务密码
 */
@property (nonatomic,copy) NSString *carrier_password;
/**
 *  运营商默认姓名
 */
@property (nonatomic,copy) NSString *carrier_name;
/**
 *  运营商默认身份证
 */
@property (nonatomic,copy) NSString *carrier_idcard;

#pragma mark - SDK 通用自定义静态参数列表（可选）
/**
 *  主题色定义
 */
@property (nonatomic,strong) UIColor *themeColor;
/**
 *  协议地址
 */
@property (nonatomic,copy) NSString *agreementUrl;
/**
 *  协议入口文字
 */
@property (nonatomic,copy) NSString *agreementEntryText;
/*
 * 登录验证成功后即退出，默认为NO
 */
@property (nonatomic,assign) BOOL quitOnLoginDone;
/*
 * 任务失败的时候自动退出，默认为NO
 */
@property (nonatomic,assign) BOOL quitOnFail;
/**
 * 缓存是否生效，默认为NO
 */
@property (nonatomic,assign) BOOL cacheDisable;

#pragma mark - SDK 原生界面自定义参数列表（可选）
/**
 * 打开SDK效果，是否使用Push（PUSH方式需要fromController包含navigationController）
 * 默认为YES
 */
@property (nonatomic,assign) BOOL useNavigationPush;
/**
 * useNavigationPush为YES情况下（默认为YES），不需要设置mxNavigationController
 * useNavigationPush为NO情况下，present进入的导航器设置，可以通过设置mxNavigationController来设定内置NavBar的属性
 */
@property (nonatomic,strong) UINavigationController *mxNavigationController;
/**
 *  返回按钮图片
 */
@property (nonatomic,strong) UIImage *backImage;
/**
 *  刷新按钮图片
 */
@property (nonatomic,strong) UIImage *refreshImage;
/**
 *  邮箱列表页Banner
 */
@property (nonatomic,strong) UIView *header_banner;
@end
