//
//  YPCacheTool.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/3.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPCacheTool.h"

#define kChannelTitleArrayKey @"ChannelTitleArrayKey"

@implementation YPCacheTool

+ (NSArray *)channelTitleArray
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kChannelTitleArrayKey];
}

+ (void)saveChannelTitleArray:(NSArray *)titleArray
{
    [[NSUserDefaults standardUserDefaults] setObject:[titleArray copy] forKey:kChannelTitleArrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com