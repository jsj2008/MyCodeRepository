//
//  SDGestureLoginController.h
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDGestureLoginControllerDelegate <NSObject>

@optional
- (void)gestureLoginButtonDidClicked:(NSInteger)tag;

@end

@interface SDGestureLoginController : UIViewController

@property (nonatomic, weak) id<SDGestureLoginControllerDelegate> delegate;

@end
