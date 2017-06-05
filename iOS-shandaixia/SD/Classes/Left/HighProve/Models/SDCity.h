//
//  SDCity.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDCity : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)cityWithDict:(NSDictionary *)dict;


@end
