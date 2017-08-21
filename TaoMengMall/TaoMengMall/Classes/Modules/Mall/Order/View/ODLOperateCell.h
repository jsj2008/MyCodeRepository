//
//  ODLOperateCell.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol ODLOperateCellDelegate <NSObject>

- (void) payButtonDidTappedWithPayLink:(NSString *)payLink;
- (void) receiptButtonDidTappedWithOrderId:(NSString *)orderId;
- (void) rateButtonDidTappedWithRateLink:(NSString *)rateLink;
- (void) deleteButtonDidTappedWithOrderId:(NSString *)orderId;
- (void) cancelButtonDidTappedWithOrderId:(NSString *)orderId;

@end

@interface ODLOperateCell : BaseTableViewCell

@property (nonatomic, weak) id<ODLOperateCellDelegate> delegate;

@end
