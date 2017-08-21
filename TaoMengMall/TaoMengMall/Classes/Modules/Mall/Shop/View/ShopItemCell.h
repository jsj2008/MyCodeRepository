//
//  ShopItemCell.h
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseCollectionViewCell.h"


@class ShopItemCell;

@protocol ShopItemCellDelegate <NSObject>

- (void)cell:(ShopItemCell*)cell tapFavButton:(id)item;
- (void)cell:(ShopItemCell*)cell tapMoreButton:(id)item;

@end

@interface ShopItemCell : BaseCollectionViewCell
@property (nonatomic, weak)id<ShopItemCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIButton *favButton;
@property (nonatomic, strong) CAShapeLayer *roundLayer;
@property (nonatomic, assign) BOOL showMask;

- (void)hideMaskAnimated;
@end
