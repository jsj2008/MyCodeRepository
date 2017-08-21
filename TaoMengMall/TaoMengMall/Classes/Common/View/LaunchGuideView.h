//
//  LaunchGuideView.h
//  BabyDaily
//
//  Created by marco on 10/31/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const LaunchViewWillRemoveNotification;

@interface LaunchGuideView : UIView
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL showButton;
    
- (void)render;
@end
