//
//  CSCouponSelectView.h
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSCouponSelectView;

@protocol CSCouponSelectViewDelegate <NSObject>

- (void)didFinishSelectingCoupon;


@end




@interface CSCouponSelectView : UIView

@property (nonatomic, strong) NSMutableArray *coupons;

@property (nonatomic, weak)id<CSCouponSelectViewDelegate> delegate;

- (instancetype)initWithCoupons:(NSArray*)coupons;

- (void)show;
- (void)dismiss;
@end
