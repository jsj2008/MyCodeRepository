//
//  ShopHeaderCell.m
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ShopHeaderCell.h"
#import "ShopInfoModel.h"
#import "ITMarkView.h"

@interface ShopHeaderCell () <UISearchBarDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *shopNameLable;
@property (nonatomic, strong) ITMarkView *markView;
@property (nonatomic, strong) UILabel *countLable;
@property (nonatomic, strong) UIButton *addFavButton;
@property (nonatomic, strong) UIButton *cancelFavButton;

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ShopHeaderCell

- (void)reloadData
{
//    self.backgroundColor = Color_Red4;
    
    if ( self.cellData ) {
        
        ShopInfoModel *shopInfo = (ShopInfoModel *)self.cellData;
        
        [self cellAddSubview:self.bgImageView];
        [self cellAddSubview:self.logoImageView];
        [self cellAddSubview:self.shopNameLable];
        [self cellAddSubview:self.markView];
        [self cellAddSubview:self.countLable];
        [self cellAddSubview:self.addFavButton];
        [self cellAddSubview:self.cancelFavButton];
        
        [self.bgImageView setOnlineImage:shopInfo.cover];
        self.bgImageView.height = SCREEN_WIDTH/shopInfo.ar;
        
        [self.logoImageView setOnlineImage:shopInfo.logo];
        self.logoImageView.left = 15;
        self.logoImageView.bottom = [[self class] heightForCell:self.cellData] - 15;
        
        self.shopNameLable.text = shopInfo.shopName;
        [self.shopNameLable sizeToFit];
        self.shopNameLable.top = self.logoImageView.top;
        self.shopNameLable.left = self.logoImageView.right + 7;
        
        self.markView.mark = [shopInfo.score floatValue];
        self.markView.left = self.shopNameLable.left;
        self.markView.top = self.shopNameLable.bottom + 2;
        
        self.countLable.text = [NSString stringWithFormat:@"销量%@ | 收藏%@", shopInfo.sales, shopInfo.favCount];
        [self.countLable sizeToFit];
        self.countLable.top = self.markView.bottom + 2;
        self.countLable.left = self.shopNameLable.left;
        
        self.addFavButton.centerY = self.countLable.centerY;
        self.cancelFavButton.centerY = self.countLable.centerY;
        self.addFavButton.hidden = YES;
        self.cancelFavButton.hidden = YES;
        if ( shopInfo.isFav ) {
            self.cancelFavButton.hidden = NO;
        } else {
            self.addFavButton.hidden = NO;
        }
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        ShopInfoModel *shopInfo = (ShopInfoModel*)cellData;
        return SCREEN_WIDTH/shopInfo.ar;
    }
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)bgImageView {
    
    if ( !_bgImageView ) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, SCREEN_WIDTH, 70)];
        _bgImageView.userInteractionEnabled = YES;
    }
    
    return _bgImageView;
    
}

- (UIImageView *)logoImageView {
    
    if ( !_logoImageView ) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 13, 5, 60, 60)];
        _logoImageView.layer.borderWidth = 1.;
        _logoImageView.layer.borderColor = Color_White.CGColor;
    }
    
    return _logoImageView;
}

- (UILabel *)shopNameLable {
    
    if ( !_shopNameLable ) {
        _shopNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shopNameLable.textColor = Color_White;
        _shopNameLable.font = FONT(16);
    }
    
    return _shopNameLable;
    
}

- (ITMarkView*)markView
{
    if (!_markView) {
        ITMarkView *markView = [[ITMarkView alloc]initWithFrame:CGRectMake(72, 46, 0, 0)];
        markView.markWidth = 12;
        markView.showMark = NO;
        [markView sizeToFit];
        _markView = markView;
    }
    return _markView;
}

- (UILabel *)countLable {
    
    if ( !_countLable ) {
        _countLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _countLable.textColor = Color_White;
        _countLable.font = FONT(12);
    }
    
    return _countLable;
    
}

- (UIButton *)addFavButton {
    
    if ( !_addFavButton ) {
        _addFavButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addFavButton.frame = CGRectMake(0, 0, 62, 25);
        [_addFavButton setTitle:@"收藏" forState:UIControlStateNormal];
        [_addFavButton setTitleColor:Color_White forState:UIControlStateNormal];
        _addFavButton.titleLabel.font = FONT(12);
        _addFavButton.layer.masksToBounds = YES;
        _addFavButton.layer.cornerRadius = 12.5f;
        _addFavButton.layer.borderColor = [Color_White CGColor];
        _addFavButton.layer.borderWidth = 1.0f;
        [_addFavButton addTarget:self action:@selector(handleAddFavButton) forControlEvents:UIControlEventTouchUpInside];
        _addFavButton.top = 32;
        _addFavButton.right = SCREEN_WIDTH - 13;
    }
    
    return _addFavButton;
}

- (UIButton *)cancelFavButton {
    
    if ( !_cancelFavButton ) {
        _cancelFavButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelFavButton.frame = CGRectMake(0, 0, 62, 25);
        [_cancelFavButton setTitle:@"已收藏" forState:UIControlStateNormal];
        [_cancelFavButton setTitleColor:Color_White forState:UIControlStateNormal];
        _cancelFavButton.titleLabel.font = FONT(12);
        _cancelFavButton.layer.masksToBounds = YES;
        _cancelFavButton.layer.cornerRadius = 12.5f;
        _cancelFavButton.layer.borderColor = [Theme_Color CGColor];
        _cancelFavButton.layer.borderWidth = 1.0f;
        _cancelFavButton.backgroundColor = Theme_Color;
        [_cancelFavButton addTarget:self action:@selector(handleCancelFavButton) forControlEvents:UIControlEventTouchUpInside];
        _cancelFavButton.top = 32;
        _cancelFavButton.right = SCREEN_WIDTH - 13;

    }
    
    return _cancelFavButton;
}

- (UIView *)topLineView {
    
    if ( !_topLineView ) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, LINE_WIDTH)];
        _topLineView.backgroundColor = Color_Gray230;
    }
    
    return _topLineView;
}

- (UIView *)bottomLineView {
    
    if ( !_bottomLineView ) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, [ShopHeaderCell heightForCell:nil] - LINE_WIDTH, SCREEN_WIDTH, LINE_WIDTH)];
        _bottomLineView.backgroundColor = Color_Gray230;
    }
    
    return _bottomLineView;
}

- (UISearchBar *)searchBar {
    
    if ( !_searchBar ) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 45)];
        _searchBar.placeholder = @"搜索本店铺的商品";
        _searchBar.barTintColor = Color_Gray230;
        _searchBar.delegate = self;
    }
    
    return _searchBar;
}

#pragma mark - Event Response

- (void)handleAddFavButton {
 
    if ( [self.delegate respondsToSelector:@selector(addFavButtonDidTapped:)]) {
        [self.delegate addFavButtonDidTapped:self.addFavButton];
    }
    
}

- (void)handleCancelFavButton {
    
    if ( [self.delegate respondsToSelector:@selector(cancelFavButtonDidTapped:)]) {
        [self.delegate cancelFavButtonDidTapped:self.cancelFavButton];
    }
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    DBG(@"搜索：%@", searchBar.text);
}

@end
