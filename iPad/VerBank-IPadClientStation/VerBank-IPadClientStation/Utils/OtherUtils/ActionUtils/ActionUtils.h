//
//  ActionUtils.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionUtils : NSObject

+ (ActionUtils *)getInstance;

- (void)showDatePickView:(id)sender;

- (void)instrumentPick;

- (void)showSystemConfigView;
@end
