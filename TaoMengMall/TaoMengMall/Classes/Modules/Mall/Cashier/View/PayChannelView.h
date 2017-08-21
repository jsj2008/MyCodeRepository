//
//  PayChannelView.h
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

@class PayChannelView;

@protocol PayChannelDelegate <NSObject>

- (void)payChannelView:(PayChannelView *)payChannelView didSelect:(BOOL)selected;

@end

@interface PayChannelView : UIView

@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, weak) id<PayChannelDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame iconName:(NSString *)iconName channelName:(NSString *)channelName description:(NSString *)description;
    
@end
