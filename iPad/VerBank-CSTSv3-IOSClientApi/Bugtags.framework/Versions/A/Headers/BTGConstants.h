//
//  BTGConstants.h
//  Bugtags
//
//  Created by Stephen Zhang on 15/6/4.
//  Copyright (c) 2016 bugtags.com. All rights reserved.
//

#ifndef Bugtags_BTGConstants_h
#define Bugtags_BTGConstants_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  Bugtags 呼出方式
 *  所有方式都会自动收集 Crash 信息（如果允许）
 */
typedef enum BTGInvocationEvent {
    
    // 静默模式，只收集 Crash 信息（如果允许）
    BTGInvocationEventNone,
    
    // 通过摇一摇呼出 Bugtags
    BTGInvocationEventShake,
    
    // 通过悬浮小球呼出 Bugtags
    BTGInvocationEventBubble
    
} BTGInvocationEvent;

/**
 *  Bugtags 数据获取模式，目前只对远程配置及在线修复有效
 */
typedef enum BTGDataMode {
    
    // 获取生产环境的数据
    BTGDataModeProduction,

    // 获取测试环境的数据
    BTGDataModeTesting,
    
    // 获取本地的数据文件
    // 远程配置，自动读取本地 mainBundle 的 main.local.plist 文件
    // 在线修复，自动读取本地 mainBundle 的 main.local.js 文件
    BTGDataModeLocal
    
} BTGDataMode;

/**
 *  远程配置状态
 */
typedef enum BTGRemoteConfigState {
    
    BTGRemoteConfigStateNone,
    
    // 已从本地缓存中获取数据
    BTGRemoteConfigStateLoadedFromCache,
    
    // 已从 Bugtags 云端获取数据
    BTGRemoteConfigStateLoadedFromRemote,

} BTGRemoteConfigState;

/**
 *  在线修复状态
 */
typedef enum BTGHotfixState {
    
    BTGHotfixStateNone,
    
    // 已执行本地缓存的脚本
    BTGHotfixStateExecutedFromCache,
    
    // 已执行从 Bugtags 云端获取的脚本
    BTGHotfixStateExecutedFromRemote,
    
    // 脚本有更新
    BTGHotfixStateUpdate,
    
    // 脚本更新完成
    BTGHotfixStateUpdateDone,
    
} BTGHotfixState;

typedef void (^BTGRemoteConfigCallback)(BTGRemoteConfigState state, NSDictionary *data);

typedef void (^BTGHotfixCallback)(BTGHotfixState state, NSDictionary *data, NSError *error);

UIKIT_EXTERN NSString *const BTGUserStepLogCapacityKey;
UIKIT_EXTERN NSString *const BTGConsoleLogCapacityKey;
UIKIT_EXTERN NSString *const BTGBugtagsLogCapacityKey;
UIKIT_EXTERN NSString *const BTGNetworkLogCapacityKey;

#endif
