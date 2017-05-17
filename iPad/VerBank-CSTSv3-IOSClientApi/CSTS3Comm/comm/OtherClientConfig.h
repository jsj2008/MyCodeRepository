//
//  OtherClientConfig.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface OtherClientConfig : AbstractJsonData
jsonValueInterface(Key,NSString*)
jsonValueInterface(Locale,NSString*)
jsonValueInterface(Type,int)
jsonValueInterface(Link ,NSString*)
jsonValueInterface(Content ,NSString*)
jsonValueInterface(Value,NSString*)
@end
