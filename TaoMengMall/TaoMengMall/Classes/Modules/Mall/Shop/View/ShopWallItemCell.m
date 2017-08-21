//
//  ShopWallItemCell.m
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopWallItemCell.h"
#import "ShopItemContentModel.h"

@implementation ShopWallItemCell

- (void)reloadData
{
    
    if (self.cellData) {
        
        ShopItemContentModel *wallItem = (ShopItemContentModel *)self.cellData;
        
        [self.contentView addSubview:self.itemImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        
        self.itemImageView.height = CELL_WIDTH / wallItem.ar;
        [self.itemImageView setOnlineImage:wallItem.image];
        
        self.titleLabel.text = wallItem.name;
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 5;
        self.titleLabel.width = CELL_WIDTH-10;
        self.titleLabel.top = self.itemImageView.bottom + 5;
        
        self.priceLabel.text = wallItem.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.left = 5;
        self.priceLabel.width = CELL_WIDTH-10-40;
        self.priceLabel.top = self.titleLabel.bottom + 5;
        
        self.favButton.selected = wallItem.isFav;

        self.backgroundColor = Color_White;
        self.layer.cornerRadius = 3.;
        self.layer.masksToBounds = YES;
    }else{
        [self removeAllSubviews];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        
        ShopItemContentModel *wallItem = (ShopItemContentModel *)cellData;
        
        CGFloat height =  CELL_WIDTH/wallItem.ar;
        
        height += 50;
        
        return height;
    }
    
    return 0;
}

@end
