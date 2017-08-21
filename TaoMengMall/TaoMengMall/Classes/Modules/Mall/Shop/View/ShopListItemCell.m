//
//  ShopListItemCell.m
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopListItemCell.h"
#import "ShopItemContentModel.h"

@interface ShopListItemCell ()
@property (nonatomic, strong) UIView *line;
@end

@implementation ShopListItemCell

- (void)reloadData
{
    
    if (self.cellData) {
        
        ShopItemContentModel *wallItem = (ShopItemContentModel *)self.cellData;
        
        [self.contentView addSubview:self.itemImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.line];
        
        self.itemImageView.left = 5;
        self.itemImageView.top = 5;
        self.itemImageView.width = IMAGE_WIDTH;
        self.itemImageView.height = IMAGE_WIDTH/wallItem.ar;
        [self.itemImageView setOnlineImage:wallItem.image];
        
        self.titleLabel.text = wallItem.name;
        self.titleLabel.numberOfLines = 2;
        CGSize textSize = [wallItem.name boundingRectWithSize:CGSizeMake( DESC_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: FONT(14)} context:nil].size;
        
        self.titleLabel.height = textSize.height;
        self.titleLabel.width = DESC_WIDTH;
        self.titleLabel.top = 10;
        self.titleLabel.left = self.itemImageView.right + CELL_PADDING;
        
        self.priceLabel.text = wallItem.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.width = DESC_WIDTH;
        self.priceLabel.bottom = self.itemImageView.bottom;
        self.priceLabel.left = self.itemImageView.right + CELL_PADDING;
        
        self.favButton.selected = wallItem.isFav;
        
        self.line.bottom = [[self class]heightForCell:self.cellData];
        
        self.backgroundColor = Color_White;
    }else{
        [self removeAllSubviews];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        
        ShopItemContentModel *wallItem = (ShopItemContentModel *)cellData;
        
        CGFloat height = IMAGE_WIDTH/wallItem.ar + 15;
        
        return height;
    }
    
    return 0;
}

- (UIView *)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, IMAGE_WIDTH, SCREEN_WIDTH - 20, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        _line = view;
    }
    return _line;
}
@end
