//
//  ITCouponView.h
//  FlyLantern
//
//  Created by marco on 07/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ITCouponView;

@protocol ITCouponViewDelegate <NSObject>

- (void)didTapCouponView:(ITCouponView*)coupon;

@end


@interface ITCouponView : UIView
@property (nonatomic, weak)id<ITCouponViewDelegate> delegate;
@end
