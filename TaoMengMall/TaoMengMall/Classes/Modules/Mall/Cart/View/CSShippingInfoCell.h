//
//  CSCouponInfoCell.h
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseTableViewCell.h"

@class CSShippingInfoCell;

@protocol CSShippingInfoCellDelegate <NSObject>

- (void)didTapCheckButtonInCell:(CSShippingInfoCell*)cell;

@end

@interface CSShippingInfoCell : BaseTableViewCell
@property (nonatomic, weak)id<CSShippingInfoCellDelegate> delegate;
@end
