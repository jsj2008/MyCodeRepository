//
//  ShopCategoriesCell.h
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@protocol ShopCategoriesCellDelegate <NSObject>

- (void)cellTapCate:(id)model;

@end

@interface ShopCategoriesCell : BaseCollectionViewCell
@property (nonatomic, weak)id<ShopCategoriesCellDelegate> delegate;
@end
