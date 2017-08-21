//
//  CSCouponSelectView.h
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSShippingSelectView;

@protocol CSShippingSelectViewDelegate <NSObject>

- (void)didFinishSelectingShipping;


@end




@interface CSShippingSelectView : UIView

@property (nonatomic, readonly) NSMutableArray *shippingList;

@property (nonatomic, weak)id<CSShippingSelectViewDelegate> delegate;

- (instancetype)init;

- (void)showShippingList:(NSArray*)shippingList;
- (void)dismiss;
@end
