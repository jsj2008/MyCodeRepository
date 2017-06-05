//
//  SDFields.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDFields : NSObject

/*
 "label":"客户号",
 "name":"user_name",
 "type":"text"
 */
@property (nonatomic, copy) NSString *label;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *type;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)fieldsWithDict:(NSDictionary *)dict;



@end
