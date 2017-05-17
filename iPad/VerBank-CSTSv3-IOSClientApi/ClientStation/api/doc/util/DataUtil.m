//
//  DataUtil.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/3/29.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil

//四舍五入，将double精确到指定小数位
+(double)roundDouble:(double)v _scale:(int)scale{
    if(scale<0){
        @throw [[NSException alloc]initWithName:@"The scale must be a positive integer or zero" reason:@"exception" userInfo:nil];
    }
    double n = pow(10, scale);
    double absV = fabs(v);
    if(absV<1/(n*10)){
        return 0;
    }
    double mark = v/fabs(v);
    double tempV = absV * n + 0.000001;
    return mark * ((double)((long)(tempV + 0.5))) / n;
}

@end
