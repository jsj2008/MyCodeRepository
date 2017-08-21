//
//  CSShopInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CSShopInfoCell.h"
#import "CTShopInfoModel.h"

@interface CSShopInfoCell ()

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *shopNameLabel;

@end

@implementation CSShopInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.topLineView];
    [self addSubview:self.bottomLineView];
    //[self addSubview:self.logoImageView];
    [self addSubview:self.shopNameLabel];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        CTShopInfoModel *shopInfo = (CTShopInfoModel *)self.cellData;
        
        self.bottomLineView.bottom = [CSShopInfoCell heightForCell:shopInfo];
        
        //[self.logoImageView setOnlineImage:shopInfo.logo];
        //self.logoImageView.centerY = [CSShopInfoCell heightForCell:shopInfo] / 2;
        
        self.shopNameLabel.text = shopInfo.shopName;
        [self.shopNameLabel sizeToFit];
        self.shopNameLabel.left = 12;//self.logoImageView.right + 7;
        self.shopNameLabel.centerY = [CSShopInfoCell heightForCell:shopInfo] / 2;
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 48;
    }
    return 0;
}

#pragma mark - Getters And Setters

- (UIView *)topLineView {
    
    if ( !_topLineView ) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _topLineView.backgroundColor = Color_Gray209;
    }
    
    return _topLineView;
}

- (UIView *)bottomLineView {
    
    if ( !_bottomLineView ) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _bottomLineView.backgroundColor = Color_Gray230;
    }
    
    return _bottomLineView;
}

- (UIImageView *)logoImageView {
    
    if ( !_logoImageView ) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 12, 0, 28, 28)];
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.layer.cornerRadius = 14;
    }
    
    return _logoImageView;
}

- (UILabel *)shopNameLabel {
    
    if ( !_shopNameLabel ) {
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shopNameLabel.textColor = Color_Gray66;
        _shopNameLabel.font = FONT(14);
        _shopNameLabel.numberOfLines = 1;
    }
    
    return _shopNameLabel;
}

@end