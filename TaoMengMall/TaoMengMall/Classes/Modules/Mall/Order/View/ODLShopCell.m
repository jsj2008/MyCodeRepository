//
//  ODLShopCell.m
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODLShopCell.h"


@interface ODLShopCell ()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UIImageView *shopImageView;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *pipe1View;
@property (nonatomic, strong) UIView *pipe2View;
@end

@implementation ODLShopCell

- (void)drawCell
{
    [self cellAddSubView:self.bkgView];
    [self cellAddSubView:self.shopImageView];
    [self cellAddSubView:self.shopNameLabel];
    [self cellAddSubView:self.lineView];
    [self cellAddSubView:self.pipe1View];
    [self cellAddSubView:self.pipe2View];
    
    weakify(self);
    [self bk_whenTapped:^{
        strongify(self);
        NSDictionary *shopDict = (NSDictionary *)self.cellData;
        [[TTNavigationService sharedService] openUrl:shopDict[@"shopLink"]];
    }];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *shopDict = (NSDictionary *)self.cellData;
        
        self.shopImageView.left = 24;
        self.shopImageView.centerY = 20;
        
        self.shopNameLabel.text = shopDict[@"shopName"];
        [self.shopNameLabel sizeToFit];
        self.shopNameLabel.left = 52;
        self.shopNameLabel.centerY = 20;
        
        if (![shopDict[@"logo"] isEqualToString:@""]) {
            [self.shopImageView setOnlineImage:shopDict[@"logo"]];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 40;
    }
    return 0;
}

#pragma mark - Getters And Setters
- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 40)];
        view.backgroundColor = Color_White;
        _bkgView = view;
    }
    return _bkgView;
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(22, 0, SCREEN_WIDTH - 22 * 2, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
        _lineView.bottom = 40;
    }
    
    return _lineView;
}

- (UIImageView *)shopImageView
{
    if (!_shopImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 16, 20, 20)];
        imageView.centerY = 22;
        imageView.image = [UIImage imageNamed:@"mall_shop_logo"];
        _shopImageView = imageView;
    }
    return _shopImageView;
}

- (UILabel *)shopNameLabel {
    
    if ( !_shopNameLabel ) {
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shopNameLabel.textColor = Color_Gray17;
        _shopNameLabel.font = FONT(14);
        _shopNameLabel.numberOfLines = 1;
    }
    
    return _shopNameLabel;
}

- (UIView*)pipe1View
{
    if (!_pipe1View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LINE_WIDTH, 40)];
        view.backgroundColor = Color_Gray238;
        _pipe1View = view;
    }
    return _pipe1View;
}

- (UIView*)pipe2View
{
    if (!_pipe2View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-LINE_WIDTH, 0, LINE_WIDTH, 40)];
        view.backgroundColor = Color_Gray238;
        _pipe2View = view;
    }
    return _pipe2View;
}

@end
