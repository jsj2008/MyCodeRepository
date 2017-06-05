//
//  BqsDeviceFingerPrinting.h
//  DeviceFingerPrinting
//
//  Created by pengjianbo on 2017/1/18.
//  Copyright © 2017年 baiqishi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BqsDeviceFingerPrinting;

/**
 SDK初始化回调协议
 */
@protocol BqsDeviceFingerPrintingDelegate <NSObject>

/**
 初始化成功
 */
-(void) onBqsDFInitSuccess:(NSString *) tokenKey;

/**
 初始化失败
 
 @param resultCode 错误码
 @param resultDesc 错误描述
 */
-(void) onBqsDFInitFailure:(NSString *) resultCode withDesc:(NSString *) resultDesc;
@end


/**
 上传联系人回调协议
 */
@protocol BqsDeviceFingerPrintingContactsDelegate <NSObject>

/**
 联系人上传成功
 */
-(void) onBqsDFContactsUploadSuccess:(NSString *) tokenKey;

/**
 联系人上传失败
 
 @param resultCode 错误码
 @param resultDesc 错误描述
 */
-(void) onBqsDFContactsUploadFailure:(NSString *) resultCode withDesc:(NSString *) resultDesc;
@end

@interface BqsDeviceFingerPrinting : NSObject
/**
 单例类方法
 @return instancetype
 */
+(instancetype)sharedBqsDeviceFingerPrinting;


/**
 设置上传联系人回调

 @param delegate 回调
 */
-(void) setBqsDeviceFingerPrintingContactsDelegate:(id<BqsDeviceFingerPrintingContactsDelegate>) delegate;


/**
 设置上传联系人回调

 @param delegate 回调
 */
-(void) setBqsDeviceFingerPrintingDelegate:(id<BqsDeviceFingerPrintingDelegate>) delegate;


/**
 获取tokenkey

 @return tokenkey
 */
-(NSString *)getTokenKey;
/**
 初始化入口方法
 
 @param params 初始化参数
 传入参数: NSDictionary
 1)partnerId: 合作方编码，必填
 2)isGatherGps: 是否采集gps，默认YES:采集 NO:不采集
 3)longitude:gps定位经度(如果app内嵌了百度、谷歌等第三方定位可以把Gps信息传给sdk)
 4)latitude:gps定位纬度(如果app内嵌了百度、谷歌等第三方定位可以把Gps信息传给sdk)
 5)isGatherContacts:是否采集通讯录，默认NO：不采集， YES:采集
 6)isEnvDev:是否对接白骑士测试环境，默认NO：生产环境, YES:测试环境
 7)deviceInfoUploadUrl:上传设备信息API
 8)contactsUploadUrl:上传联系人信息API
 9)isGatherSensorInfo:是否采集传感器信息,默认YES:采集 NO:不采集
 */
-(void)initBqsDFSdkWithParams:(NSDictionary *) params;

@end
