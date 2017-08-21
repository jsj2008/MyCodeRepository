//
//  WaterItemSmallCell.m
//  HongBao
//
//  Created by marco on 5/10/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "WallItemSmallCell.h"
#import "WallItemModel.h"

@interface WallItemSmallCell ()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *priceLable;

@end

@implementation WallItemSmallCell

- (void)reloadData
{
    
    if (self.cellData) {
        
        WallItemModel *wallItem = (WallItemModel *)self.cellData;
        
        [self cellAddSubview:self.itemImageView];
        [self cellAddSubview:self.titleLable];
        [self cellAddSubview:self.priceLable];
        
        
        self.itemImageView.height = wallItem.image.h / wallItem.image.w * IMAGE_WIDTH;
        [self.itemImageView setOnlineImage:wallItem.image.src];
        
        self.titleLable.text = wallItem.title;
        CGSize textSize = [wallItem.title boundingRectWithSize:CGSizeMake( DESC_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: FONT(14)} context:nil].size;
        self.titleLable.height = textSize.height;
        self.titleLable.width = DESC_WIDTH;
        self.titleLable.top = 10;
        self.titleLable.left = self.itemImageView.right + CELL_PADDING;
        
        self.priceLable.text = wallItem.price;
        [self.priceLable sizeToFit];
        self.priceLable.width = DESC_WIDTH;
        self.priceLable.bottom = self.itemImageView.height - 10;
        self.priceLable.left = self.itemImageView.right + CELL_PADDING;
        
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        
        WallItemModel *wallItem = (WallItemModel *)cellData;
        
        CGFloat height = wallItem.image.h / wallItem.image.w * IMAGE_WIDTH;
        
        return height;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)itemImageView {
    
    if ( !_itemImageView ) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, IMAGE_WIDTH, 0)];
    }
    
    return _itemImageView;
}

- (UILabel *)titleLable {
    
    if ( !_titleLable ) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLable.numberOfLines = 2;
        _titleLable.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLable.textColor = Color_Gray100;
        _titleLable.font = FONT(12);
    }
    
    return _titleLable;
    
}

- (UILabel *)priceLable {
    
    if ( !_priceLable ) {
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _priceLable.textColor = Color_Gray66;
        _priceLable.font = FONT(14);
    }
    
    return _priceLable;
    
}

@end

