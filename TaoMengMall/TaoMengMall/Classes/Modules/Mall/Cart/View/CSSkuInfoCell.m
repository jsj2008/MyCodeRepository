//
//  CSSkuInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CSSkuInfoCell.h"
#import "CTSkuInfoModel.h"

@interface CSSkuInfoCell ()

@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIImageView *skuImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, strong) UILabel *skuInfoLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oPriceLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *errorLabel;
@end

@implementation CSSkuInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.bottomLineView];
    [self addSubview:self.skuImageView];
    [self addSubview:self.itemTitleLabel];
    [self addSubview:self.skuInfoLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.oPriceLabel];
    [self addSubview:self.amountLabel];
    [self addSubview:self.errorLabel];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
        //skuInfo.title = @"打交道几点开始可松开打开附件附件肯定肯定酷酷的解放军发件人进入进入쒣얄所所翁多多多多多多多多多多多多";
        //skuInfo.oPrice = @"￥569.00";
        self.bottomLineView.bottom = [CSSkuInfoCell heightForCell:skuInfo];
        
        [self.skuImageView setOnlineImage:skuInfo.image];
        self.skuImageView.centerY = [CSSkuInfoCell heightForCell:skuInfo] / 2;
        
        NSAttributedString *oPriceWithLine =
        [[NSAttributedString alloc]initWithString:skuInfo.oPrice ? skuInfo.oPrice : @""                                       attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSBaselineOffsetAttributeName: @(0)}];
        
        self.oPriceLabel.attributedText = oPriceWithLine;
        [self.oPriceLabel sizeToFit];
        self.oPriceLabel.top = 12;
        self.oPriceLabel.right = SCREEN_WIDTH - 12;
        
        self.priceLabel.text = skuInfo.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.top = self.oPriceLabel.bottom + 4;
        self.priceLabel.right = SCREEN_WIDTH - 12;
        
        self.itemTitleLabel.text = skuInfo.title;
        self.itemTitleLabel.top = 10;
        self.itemTitleLabel.left = self.skuImageView.right + 10;
        self.itemTitleLabel.width = MIN(self.oPriceLabel.left,self.priceLabel.left) - 6 - self.itemTitleLabel.left;
        [self.itemTitleLabel sizeToFit];

        if (IsEmptyString(skuInfo.error)) {
            self.skuInfoLabel.hidden = NO;
            self.errorLabel.hidden = YES;
            self.itemTitleLabel.textColor = Color_Gray66;
            self.priceLabel.textColor = Color_Gray66;
            
            self.skuInfoLabel.text = skuInfo.skuDesc;
            [self.skuInfoLabel sizeToFit];
            self.skuInfoLabel.left = self.skuImageView.right + 10;
            self.skuInfoLabel.top = self.itemTitleLabel.bottom + 6;
            self.skuInfoLabel.width = self.oPriceLabel.left - 12 - self.skuInfoLabel.left;
        }else{
            self.errorLabel.hidden = NO;
            self.skuInfoLabel.hidden = YES;
            self.itemTitleLabel.textColor = Color_Gray(156);
            self.priceLabel.textColor = Color_Gray(156);
            
            self.errorLabel.text = skuInfo.error;
            [self.errorLabel sizeToFit];
            self.errorLabel.left = self.skuImageView.right + 10;
            self.errorLabel.top = self.itemTitleLabel.bottom + 6;
            self.errorLabel.width = self.oPriceLabel.left - 12 - self.errorLabel.left;
        }

        
        self.amountLabel.text = [NSString stringWithFormat:@"x%@",skuInfo.amount];
        [self.amountLabel sizeToFit];
        self.amountLabel.top = self.priceLabel.bottom + 10;
        self.amountLabel.right = SCREEN_WIDTH - 12;
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 102;
    }
    return 0;
}

#pragma mark - Getters And Setters

- (UIView *)bottomLineView {
    
    if ( !_bottomLineView ) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _bottomLineView.backgroundColor = Color_Gray230;
    }
    
    return _bottomLineView;
}

- (UIImageView *)skuImageView {
    
    if ( !_skuImageView ) {
        _skuImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 12, 0, 60, 80)];
    }
    
    return _skuImageView;
}

- (UILabel *)itemTitleLabel {
    
    if ( !_itemTitleLabel ) {
        _itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _itemTitleLabel.textColor = Color_Gray66;
        _itemTitleLabel.numberOfLines = 2;
        _itemTitleLabel.font = FONT(14);
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

- (UILabel *)errorLabel {
    
    if ( !_errorLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray(62);
        label.font = FONT(12);
        label.numberOfLines = 1;
        _errorLabel = label;
    }
    
    return _errorLabel;
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
        _oPriceLabel.textColor = Color_Gray170;
        _oPriceLabel.font = FONT(12);
        _oPriceLabel.numberOfLines = 1;
    }
    
    return _oPriceLabel;
}

- (UILabel *)amountLabel {
    
    if ( !_amountLabel ) {
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _amountLabel.textColor = Color_Gray170;
        _amountLabel.font = FONT(12);
        _amountLabel.numberOfLines = 1;
    }
    
    return _amountLabel;
}

@end

