//
//  ChooseDataCenter.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseDataCenter : NSObject

@property NSArray* accountChooseArray;

+ (ChooseDataCenter *)getInstance;

- (void)resetData;

@end
