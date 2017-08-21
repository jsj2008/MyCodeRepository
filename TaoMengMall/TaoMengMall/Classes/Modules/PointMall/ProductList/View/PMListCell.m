//
//  PMListCell.m
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import "PMListCell.h"
#import "PMItemModel.h"

@interface PMListCell()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *priceLable;

@end

@implementation PMListCell

- (void)reloadData
{
    
    if (self.cellData) {
        
        PMItemModel *wallItem = (PMItemModel *)self.cellData;
        
        [self cellAddSubview:self.itemImageView];
        [self cellAddSubview:self.titleLable];
        [self cellAddSubview:self.priceLable];
        
        
        self.itemImageView.height = CELL_WIDTH /  wallItem.ar ;
        [self.itemImageView setOnlineImage:wallItem.image];
        
        self.titleLable.text = wallItem.title;
        [self.titleLable sizeToFit];
        self.titleLable.width = CELL_WIDTH;
        self.titleLable.top = self.itemImageView.bottom + 5;
        
        self.priceLable.text = wallItem.desc;
        [self.priceLable sizeToFit];
        self.priceLable.width = CELL_WIDTH;
        self.priceLable.top = self.titleLable.bottom + 5;
        self.backgroundColor = Color_White;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        
        PMItemModel *wallItem = (PMItemModel *)cellData;
        
        CGFloat height =  CELL_WIDTH / wallItem.ar;
        
        height += 50;
        
        return height;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)itemImageView {
    
    if ( !_itemImageView ) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, CELL_WIDTH, 0)];
    }
    
    return _itemImageView;
}

- (UILabel *)titleLable {
    
    if ( !_titleLable ) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 0, 0)];
        _titleLable.textColor = Color_Gray(45);
        _titleLable.font = FONT(12);
    }
    
    return _titleLable;
    
}

- (UILabel *)priceLable {
    
    if ( !_priceLable ) {
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 0, 0)];
        _priceLable.textColor = Theme_Color;
        _priceLable.font = BOLD_FONT(14);
    }
    
    return _priceLable;
    
}

@end
