//
//  CTSkuInfoCell.h
//  HongBao
//
//  Created by Ivan on 16/2/17.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "MGSwipeTableCell.h"

extern NSString *const kNOTIFY_CART_SELECT_CHANGE;

@protocol CTSkuInfoCellDelegate <NSObject>

- (void)dropdownButtonTappedWithModel:(id)model;

@end

@interface CTSkuInfoCell : MGSwipeTableCell
@property (nonatomic, weak) id<CTSkuInfoCellDelegate> actionDelegate;
@property (nonatomic, assign) BOOL xxEditing;
@property (nonatomic, assign) BOOL isShopEditing;

@property (nonatomic, assign) BOOL isLast;

@end
