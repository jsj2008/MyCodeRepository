//
//  ODTotalBarView.h
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

@protocol ODTotalBarDelegate <NSObject>

- (void) payButtonDidTappedWithPayLink:(NSString *)payLink;
- (void) receiptButtonDidTapped;
- (void) rateButtonDidTappedWithRateLink:(NSString *)rateLink;
- (void) deleteButtonDidTapped;
- (void) cancelButtonDidTapped;
@end

@interface ODTotalBarView : UIView

@property (nonatomic, weak) id<ODTotalBarDelegate> delegate;

//@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *totalPrice;

@property (nonatomic, strong) id viewData;

- (void)reloadData;
@end
