//
//  ODLSkuCell.m
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODLSkuCell.h"
#import "ODLSkuInfoModel.h"

@interface ODLSkuCell ()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIImageView *skuImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, strong) UILabel *skuInfoLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oPriceLabel;
@property (nonatomic, strong) UILabel *amountLabel;

//@property (nonatomic, strong) UILabel *refundLabel;
@property (nonatomic, strong) UILabel *refundShowLabel;
@property (nonatomic, strong) UIView *pipe1View;
@property (nonatomic, strong) UIView *pipe2View;
@end

@implementation ODLSkuCell

- (void)drawCell
{
    [self cellAddSubView:self.bkgView];
    [self cellAddSubView:self.bottomLineView];
    [self cellAddSubView:self.skuImageView];
    [self cellAddSubView:self.itemTitleLabel];
    [self cellAddSubView:self.skuInfoLabel];
    [self cellAddSubView:self.priceLabel];
    [self cellAddSubView:self.oPriceLabel];
    [self cellAddSubView:self.amountLabel];
//    [self addSubview:self.refundLabel];
    [self cellAddSubView:self.refundShowLabel];
    [self cellAddSubView:self.pipe1View];
    [self cellAddSubView:self.pipe2View];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ODLSkuInfoModel *skuInfo = (ODLSkuInfoModel *)self.cellData;
        
        self.bottomLineView.bottom = [ODLSkuCell heightForCell:skuInfo];
        
        [self.skuImageView setOnlineImage:skuInfo.image];
        self.skuImageView.centerY = [ODLSkuCell heightForCell:skuInfo] / 2;

        NSAttributedString *oPriceWithLine =
        [[NSAttributedString alloc]initWithString:skuInfo.oPrice ? skuInfo.oPrice : @""                                       attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSBaselineOffsetAttributeName: @(0)}];
                
        self.oPriceLabel.attributedText = oPriceWithLine;
        [self.oPriceLabel sizeToFit];
        self.oPriceLabel.top = 12;
        self.oPriceLabel.right = SCREEN_WIDTH - 24;
        
        self.priceLabel.text = skuInfo.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.top = self.oPriceLabel.bottom + 4;
        self.priceLabel.right = SCREEN_WIDTH - 24;
        
        self.itemTitleLabel.text = skuInfo.title;
        self.itemTitleLabel.top = 10;
        self.itemTitleLabel.left = self.skuImageView.right + 10;
        self.itemTitleLabel.width = MIN(self.oPriceLabel.left,self.priceLabel.left) - 6 - self.itemTitleLabel.left;
        [self.itemTitleLabel sizeToFit];
        
        self.skuInfoLabel.text = skuInfo.skuDesc;
        [self.skuInfoLabel sizeToFit];
        self.skuInfoLabel.left = self.skuImageView.right + 10;
        self.skuInfoLabel.top = self.itemTitleLabel.bottom + 6;
        self.skuInfoLabel.width = self.oPriceLabel.left - 12 - self.skuInfoLabel.left;
        
        self.amountLabel.text = [NSString stringWithFormat:@"×%@", skuInfo.amount];
        [self.amountLabel sizeToFit];
        self.amountLabel.top = self.priceLabel.bottom + 10;
        self.amountLabel.right = SCREEN_WIDTH - 24;
        
        NSString *refund = skuInfo.refundStatusShow;
        if (refund.length > 0) {
            self.refundShowLabel.hidden = NO;
            
            self.refundShowLabel.text = refund;
            [self.refundShowLabel sizeToFit];
            
            self.refundShowLabel.left = self.itemTitleLabel.left;
            self.refundShowLabel.top = self.skuInfoLabel.bottom + 2;

        }else{
            self.refundShowLabel.hidden = YES;
        }
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 95;
    }
    return 0;
}

#pragma mark - Getters And Setters
- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 95)];
        view.backgroundColor = Color_Gray(255);
        _bkgView = view;
    }
    return _bkgView;
}

- (UIView *)bottomLineView {
    
    if ( !_bottomLineView ) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(22, 0, SCREEN_WIDTH - 22 * 2, LINE_WIDTH)];
        _bottomLineView.backgroundColor = Color_Gray230;
    }
    
    return _bottomLineView;
}

- (UIImageView *)skuImageView {
    
    if ( !_skuImageView ) {
        _skuImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 24, 0, 63, 63)];
    }
    
    return _skuImageView;
}

- (UILabel *)itemTitleLabel {
    
    if ( !_itemTitleLabel ) {
        _itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _itemTitleLabel.textColor = Color_Gray66;
        _itemTitleLabel.font = FONT(14);
        _itemTitleLabel.numberOfLines = 2;
    }
    
    return _itemTitleLabel;
}

- (UILabel *)skuInfoLabel {
    
    if ( !_skuInfoLabel ) {
        _skuInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _skuInfoLabel.textColor = Color_Gray153;
        _skuInfoLabel.font = FONT(12);
        _skuInfoLabel.numberOfLines = 1;
    }
    
    return _skuInfoLabel;
}

- (UILabel *)priceLabel {
    
    if ( !_priceLabel ) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _priceLabel.textColor = Color_Gray66;
        _priceLabel.font = FONT(12);
        _priceLabel.numberOfLines = 1;
    }
    
    return _priceLabel;
}

- (UILabel *)oPriceLabel {
    
    if ( !_oPriceLabel ) {
        _oPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _oPriceLabel.textColor = Color_Gray153;
        _oPriceLabel.font = FONT(12);
        _oPriceLabel.numberOfLines = 1;
    }
    
    return _oPriceLabel;
}

- (UILabel *)amountLabel {
    
    if ( !_amountLabel ) {
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _amountLabel.textColor = Color_Gray66;
        _amountLabel.font = FONT(10);
        _amountLabel.numberOfLines = 1;
    }
    
    return _amountLabel;
}

//- (UILabel *)refundLabel
//{
//    if (!_refundLabel) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
//        label.backgroundColor = Color_Red6;
//        label.text = @"退";
//        label.textColor = Color_White;
//        label.font = FONT(12);
//        label.textAlignment = NSTextAlignmentCenter;
//        _refundLabel = label;
//    }
//    return _refundLabel;
//}

- (UILabel *)refundShowLabel
{
    if (!_refundShowLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Theme_Color;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 2.f;
        label.layer.masksToBounds = YES;
        _refundShowLabel = label;
    }
    return _refundShowLabel;
}

- (UIView*)pipe1View
{
    if (!_pipe1View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LINE_WIDTH, 95)];
        view.backgroundColor = Color_Gray238;
        _pipe1View = view;
    }
    return _pipe1View;
}

- (UIView*)pipe2View
{
    if (!_pipe2View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-LINE_WIDTH, 0, LINE_WIDTH, 95)];
        view.backgroundColor = Color_Gray238;
        _pipe2View = view;
    }
    return _pipe2View;
}
@end
