//
//  UIView+ViewFromXib.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewFromXib)

+ (instancetype)newInstance;

+ (instancetype)newInstanceWithClassName:(NSString *)className;

+ (instancetype)newInstanceWithNibIndex:(NSUInteger)index;

- (void)initContent;

@end
