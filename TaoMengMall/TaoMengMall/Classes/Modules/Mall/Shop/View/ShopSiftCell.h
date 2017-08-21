//
//  ShopSiftCell.h
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@protocol ShopSiftCellDelegate <NSObject>

- (void)cellTapSift:(id)model;

@end

@interface ShopSiftCell : BaseCollectionViewCell
@property (nonatomic, weak)id<ShopSiftCellDelegate> delegate;
@end
