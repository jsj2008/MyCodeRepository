//
//  CAPointSwitchView.h
//  YouCai
//
//  Created by marco on 5/29/16.
//  Copyright © 2016 marco. All rights reserved.
//

@class CAPointSwitchView;

@protocol CAPointSwitchViewDelegate <NSObject>

- (void)pointSwitch:(CAPointSwitchView *)pointSwitch didOn:(BOOL)on;

@end

@interface CAPointSwitchView : UIView

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL disabled;

@property (nonatomic, weak) id<CAPointSwitchViewDelegate> delegate;
@property (nonatomic, assign) NSInteger balance;

- (instancetype)initWithFrame:(CGRect)frame
                     iconName:(NSString*)iconName
                  channelName:(NSString *)channelName
                  description:(NSString *)description;

@end
