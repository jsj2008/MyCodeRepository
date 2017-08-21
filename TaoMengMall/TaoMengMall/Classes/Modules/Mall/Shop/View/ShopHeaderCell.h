//
//  ShopHeaderCell.h
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@protocol ShopHeaderDelegate <NSObject>

- (void) addFavButtonDidTapped:(UIButton*)sender;
- (void) cancelFavButtonDidTapped:(UIButton*)sender;

@end

@interface ShopHeaderCell : BaseCollectionViewCell

@property (nonatomic, weak) id<ShopHeaderDelegate> delegate;

@end
