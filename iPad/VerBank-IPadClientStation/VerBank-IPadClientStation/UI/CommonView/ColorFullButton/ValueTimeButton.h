//
//  ValueTimeButton.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValueTimeButton : UIButton

@property UIButton *timeShowButton;
@property NSInteger valueTimeButtonType;

- (void)setDateType:(NSUInteger)type;
- (NSUInteger)getDateType;

- (void)setDateValueTime:(NSDate *)valueDate;
- (NSString *)getDateValueTime;
- (NSDate *)getDateValueDate;

@end
