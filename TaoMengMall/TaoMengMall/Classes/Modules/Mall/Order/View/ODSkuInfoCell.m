//
//  ODSkuInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODSkuInfoCell.h"
#import "ODSkuInfoModel.h"
#import "ODCashBackCell.h"

@interface ODSkuInfoCell ()

@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIImageView *skuImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, strong) UILabel *skuInfoLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oPriceLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic,strong) UILabel *servicePriceLabel;
@property (nonatomic,strong) UILabel *servicePriveValue;
@property (nonatomic,strong) UIView *serviceLineView;

//@property (nonatomic, strong) UILabel *refundLabel;
@property (nonatomic, strong) UILabel *refundShowLabel;
@property (nonatomic, strong) ODCashBackCell *cashBackView;
@end

@implementation ODSkuInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.bottomLineView];
    [self addSubview:self.skuImageView];
    [self addSubview:self.itemTitleLabel];
    [self addSubview:self.skuInfoLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.oPriceLabel];
    [self addSubview:self.amountLabel];
    
    //[self addSubview:self.refundLabel];
    [self addSubview:self.refundShowLabel];
    
    [self addSubview:self.servicePriceLabel];
    [self addSubview:self.servicePriveValue];
    [self addSubview:self.serviceLineView];

    
    weakify(self);
    [self bk_whenTapped:^{
        strongify(self);
        ODSkuInfoModel *skuInfo = (ODSkuInfoModel *)self.cellData;
        [[TTNavigationService sharedService] openUrl:skuInfo.itemLink];
    }];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ODSkuInfoModel *skuInfo = (ODSkuInfoModel *)self.cellData;
        self.bottomLineView.bottom = 137;//[ODSkuInfoCell heightForCell:skuInfo]
        if (skuInfo.cashback) {
            [self addSubview:self.cashBackView];
            self.cashBackView.cellData = skuInfo.cashback;
            [self.cashBackView reloadData];
            self.cashBackView.top = 137;
            self.cashBackView.height = 50;
            self.cashBackView.width = SCREEN_WIDTH;
        }else {
            [self.cashBackView removeFromSuperview];
        }
        
        if (skuInfo.serviceCharge) {
            self.serviceLineView.hidden = NO;
            
            self.serviceLineView.bottom =[ODSkuInfoCell heightForCell:skuInfo]-LINE_WIDTH;
        }else {
            self.serviceLineView.hidden = YES;
        }
        
        [self.skuImageView setOnlineImage:skuInfo.image];

        NSAttributedString *oPriceWithLine =
        [[NSAttributedString alloc]initWithString:skuInfo.oPrice ? skuInfo.oPrice : @""
                                       attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSBaselineOffsetAttributeName: @(0)}];
        
        self.oPriceLabel.attributedText = oPriceWithLine;
        [self.oPriceLabel sizeToFit];
        self.oPriceLabel.top = 9;
        self.oPriceLabel.right = SCREEN_WIDTH - 14;
        
        self.priceLabel.text = skuInfo.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.top = self.oPriceLabel.bottom + 4;
        self.priceLabel.right = SCREEN_WIDTH - 12;
        
        self.itemTitleLabel.text = skuInfo.title;
        self.itemTitleLabel.left = self.skuImageView.right + 10;
        self.itemTitleLabel.top = 10;
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
        self.amountLabel.right = SCREEN_WIDTH - 12;
        
        if (skuInfo.cashback) {
             self.servicePriceLabel.centerY = self.cashBackView.bottom + 21;
        }else {
             self.servicePriceLabel.centerY = self.bottomLineView.bottom + 21;
        }
       
        self.servicePriveValue.text = skuInfo.serviceCharge;
        [self.servicePriveValue sizeToFit];
        self.servicePriveValue.right =SCREEN_WIDTH -14;
        self.servicePriveValue.centerY = self.servicePriceLabel.centerY;
        
        NSString *refund = skuInfo.refundStatusShow;
        

        if (refund.length > 0) {
            
            self.refundShowLabel.hidden = NO;
            self.refundShowLabel.text = refund;
            //[self.refundShowLabel sizeToFit];
            //self.refundShowLabel.width += 8;
            //self.refundShowLabel.height += 4;
            
            self.refundShowLabel.right = SCREEN_WIDTH - 12;
            self.refundShowLabel.bottom = 125;
        }else{
            self.refundShowLabel.hidden = YES;
        }
        
        

    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    CGFloat height = 0;
    if (cellData) {
        height = 137;
        ODSkuInfoModel *skuInfo = (ODSkuInfoModel *)cellData;
        if (!IsEmptyString(skuInfo.serviceCharge)) {
            height = height +42;
        }
        if (skuInfo.cashback) {
            height= height +50;
        }
    }
    return height;
}

#pragma mark - Getters And Setters
- (ODCashBackCell *)cashBackView
{
    if (!_cashBackView) {
        _cashBackView = [[ODCashBackCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _cashBackView;
}

- (UILabel *)servicePriceLabel
{
    if (!_servicePriceLabel) {
        _servicePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _servicePriceLabel.textColor = Color_Gray113;
        _servicePriceLabel.font = FONT(14);
        _servicePriceLabel.numberOfLines = 1;
        _servicePriceLabel.text = @"服务费：";
        [_servicePriceLabel sizeToFit];
        _servicePriceLabel.centerY = self.bottomLineView.bottom + 21;
        _servicePriceLabel.left = 14;
        
    }
    return _servicePriceLabel;
}

- (UILabel *)servicePriveValue
{
    if (!_servicePriveValue) {
        _servicePriveValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _servicePriveValue.textColor = Color_Gray113;
        _servicePriveValue.font = FONT(14);
        _servicePriveValue.numberOfLines = 1;
        _servicePriveValue.centerY = self.bottomLineView.bottom + 21;
        _servicePriveValue.right = SCREEN_WIDTH - 14;
    }
    return _servicePriveValue;
}

- (UIView *)serviceLineView
{
    if ( !_serviceLineView ) {
        _serviceLineView = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _serviceLineView.backgroundColor = Color_Gray230;
    }
    
    return _serviceLineView;
}


- (UIView *)bottomLineView {
    
    if ( !_bottomLineView ) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , LINE_WIDTH)];
        _bottomLineView.backgroundColor = Color_Gray230;
    }
    
    return _bottomLineView;
}

- (UIImageView *)skuImageView {
    
    if ( !_skuImageView ) {
        _skuImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 12, 12, 60, 80)];
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
//
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
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 86, 30)];
        label.font = FONT(14);
        label.textColor = Color_Gray(152);
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = Color_Gray153.CGColor;
        label.layer.borderWidth = LINE_WIDTH;
        label.layer.cornerRadius = 2.f;
        label.layer.masksToBounds = YES;
        label.userInteractionEnabled = YES;
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            ODSkuInfoModel *skuInfo = (ODSkuInfoModel *)self.cellData;
            NSString *refundLink = skuInfo.refundLink;
            if (IsEmptyString(refundLink)) {
                return ;
            }
            [[TTNavigationService sharedService] openUrl:refundLink];

        }];
        _refundShowLabel = label;
    }
    return _refundShowLabel;
}

@end
