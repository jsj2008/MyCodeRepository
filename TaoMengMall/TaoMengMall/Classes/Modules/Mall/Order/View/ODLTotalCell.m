//
//  ODLTotalCell.m
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODLTotalCell.h"

@interface ODLTotalCell ()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UILabel *shippingFeeLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *totalPriceValueLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *pipe1View;
@property (nonatomic, strong) UIView *pipe2View;
@end

@implementation ODLTotalCell

- (void)drawCell
{
    [self cellAddSubView:self.bkgView];
    [self cellAddSubView:self.totalPriceValueLabel];
    [self cellAddSubView:self.totalPriceLabel];
    [self cellAddSubView:self.shippingFeeLabel];
    [self cellAddSubView:self.line];
    [self cellAddSubView:self.pipe1View];
    [self cellAddSubView:self.pipe2View];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *data = (NSDictionary *)self.cellData;
        
        self.totalPriceValueLabel.text = [data objectForKey:@"totalPrice"];
        [self.totalPriceValueLabel sizeToFit];
        self.totalPriceValueLabel.right = SCREEN_WIDTH - 30;
        self.totalPriceValueLabel.centerY = 20;
        
        self.totalPriceLabel.right = self.totalPriceValueLabel.left - 10;
        self.totalPriceLabel.centerY = 20;
        
        self.shippingFeeLabel.text = [data objectForKey:@"shippingFee"];
        [self.shippingFeeLabel sizeToFit];
        self.shippingFeeLabel.right = self.totalPriceLabel.left - 15;
        self.shippingFeeLabel.centerY = 20;
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
        view.backgroundColor = Color_Gray(255);
        _bkgView = view;
    }
    return _bkgView;
}

- (UILabel *)totalPriceValueLabel {
    
    if ( !_totalPriceValueLabel ) {
        _totalPriceValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _totalPriceValueLabel.textColor = Color_Black;
        _totalPriceValueLabel.font = BOLD_FONT(16);
        _totalPriceValueLabel.numberOfLines = 1;
        _totalPriceValueLabel.centerY = 20;
    }
    
    return _totalPriceValueLabel;
}

- (UILabel *)totalPriceLabel {
    
    if ( !_totalPriceLabel ) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _totalPriceLabel.textColor = Color_Gray148;
        _totalPriceLabel.font = FONT(14);
        _totalPriceLabel.text = @"合计：";
        [_totalPriceLabel sizeToFit];
        _totalPriceLabel.numberOfLines = 1;
    }
    
    return _totalPriceLabel;
}

- (UILabel *)shippingFeeLabel {
    
    if ( !_shippingFeeLabel ) {
        _shippingFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shippingFeeLabel.textColor = Color_Gray148;
        _shippingFeeLabel.font = FONT(14);
        _shippingFeeLabel.numberOfLines = 1;
    }
    
    return _shippingFeeLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(22, 40-LINE_WIDTH, SCREEN_WIDTH-22*2, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        _line = view;
    }
    return _line;
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
