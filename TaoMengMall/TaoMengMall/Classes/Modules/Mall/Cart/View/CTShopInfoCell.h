//
//  CTShopInfoCell.h
//  HongBao
//
//  Created by Ivan on 16/2/17.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CTShopInfoCellDelegate <NSObject>

- (void)editTappedWithModel:(id)model;

@end


@interface CTShopInfoCell : BaseTableViewCell
@property (nonatomic, weak) id<CTShopInfoCellDelegate> delegate;
@property (nonatomic, assign) BOOL xxEditing;
@property (nonatomic, assign) BOOL isShopEditing;

@end
