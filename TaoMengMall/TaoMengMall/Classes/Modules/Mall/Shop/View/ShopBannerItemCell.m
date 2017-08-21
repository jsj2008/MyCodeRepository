//
//  ShopBannerItemCell.m
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopBannerItemCell.h"
#import "ShopItemContentModel.h"

@implementation ShopBannerItemCell

- (void)reloadData
{
    
    if (self.cellData) {
        
        ShopItemContentModel *wallItem = (ShopItemContentModel *)self.cellData;
        
        [self.contentView addSubview:self.itemImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        
        self.itemImageView.height = BANNER_WIDTH / wallItem.ar;
        self.itemImageView.width = BANNER_WIDTH;
        self.itemImageView.left = 5;
        self.itemImageView.top = 5;
        [self.itemImageView setOnlineImage:wallItem.image];
        
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.text = wallItem.name;
        self.titleLabel.width = BANNER_WIDTH;
        self.titleLabel.top = self.itemImageView.bottom + 10;
        self.titleLabel.left = 5;
        [self.titleLabel sizeToFit];
        
        self.priceLabel.text = wallItem.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.width = BANNER_WIDTH;
        self.priceLabel.bottom = [[self class]heightForCell:self.cellData] - 10;
        self.priceLabel.left = 5;
        
        self.favButton.selected = wallItem.isFav;

        self.layer.cornerRadius = 3.;
        self.layer.masksToBounds = YES;
        self.backgroundColor = Color_White;
    }else{
        [self removeAllSubviews];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        
        ShopItemContentModel *wallItem = (ShopItemContentModel *)cellData;
        
        CGFloat height =  BANNER_WIDTH/wallItem.ar;
        
        height += 78;
        
        return height;
    }
    
    return 0;
}
@end
