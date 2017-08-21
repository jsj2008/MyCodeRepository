//
//  CSCouponInfoCell.h
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseTableViewCell.h"

@class CSCouponInfoCell;

@protocol CSCouponInfoCellDelegate <NSObject>

- (void)didTapCheckButtonInCell:(CSCouponInfoCell*)cell;

@end

@interface CSCouponInfoCell : BaseTableViewCell
@property (nonatomic, weak)id<CSCouponInfoCellDelegate> delegate;
@end
