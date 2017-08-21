//
//  ITItemInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITItemInfoCell.h"
#import "ItemInfoModel.h"

@interface ITItemInfoCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oPriceLabel;
@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *discountInfoLabel;
@property (nonatomic, strong) UIView  *dividerView;
@property (nonatomic, strong) UILabel *salesLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic,strong) UILabel *servivePrice;

@end

@implementation ITItemInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.oPriceLabel];
    [self addSubview:self.discountLabel];
    [self addSubview:self.shareLabel];
    [self addSubview:self.shareButton];
    [self addSubview:self.line];
    [self addSubview:self.discountInfoLabel];
    //[self addSubview:self.dividerView];
    [self addSubview:self.salesLabel];
    [self addSubview:self.addressLabel];
    
    [self addSubview:self.servivePrice];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ItemInfoModel *itemInfo = (ItemInfoModel *)self.cellData;
        //itemInfo.title = @"世纪街时间冻结附近附近方法开发开放开发开放开发开放开发开放开发急急急扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩";
        //itemInfo.title = @"世纪";
        //itemInfo.oPrice = @"$1800.00";
        //itemInfo.discount = @"手机专享";

        self.titleLabel.text = itemInfo.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.width = SCREEN_WIDTH - 20 ;
        self.titleLabel.top = 14;
        self.titleLabel.left = 10;
        
//        self.descLabel.text = itemInfo.desc;
//        [self.descLabel sizeToFit];
//        self.descLabel.width = SCREEN_WIDTH -20;
//        self.descLabel.top = self.titleLabel.bottom + 2;
//        self.descLabel.left = 10;
        
        self.priceLabel.text = itemInfo.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.top = self.titleLabel.bottom + 15;
        
        NSAttributedString *oPriceWithLine =
        [[NSAttributedString alloc]initWithString:itemInfo.oPrice ? itemInfo.oPrice : @""                                       attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSBaselineOffsetAttributeName: @(0)}];
        
        self.oPriceLabel.attributedText = oPriceWithLine;
        [self.oPriceLabel sizeToFit];
        self.oPriceLabel.top = self.priceLabel.top;
        
        if (!IsEmptyString(itemInfo.servicePrice)) {
            self.servivePrice.text = [NSString stringWithFormat:@"服务费：%@",itemInfo.servicePrice];
            [self.servivePrice sizeToFit];
            self.servivePrice.right = SCREEN_WIDTH -10;
            self.servivePrice.centerY = self.priceLabel.centerY;
        }
        
        
        if ( IsEmptyString(itemInfo.discountAmount)) {
            self.discountLabel.hidden = YES;
            self.discountLabel.width = 0;
        } else {
            self.discountLabel.hidden = NO;
            self.discountLabel.text = itemInfo.discountAmount;
            [self.discountLabel sizeToFit];
            self.discountLabel.width = self.discountLabel.width + 10;
            self.discountLabel.height = self.discountLabel.height + 2;
            self.discountLabel.top = self.oPriceLabel.bottom;
        }

        self.oPriceLabel.left = self.priceLabel.right + 4;
        self.discountLabel.left = self.priceLabel.right + 4;
        
        self.shareButton.top = self.titleLabel.top - 15;
        self.shareButton.right = SCREEN_WIDTH - 4;
        self.shareButton.hidden = !self.showShare;
        
        self.shareLabel.centerX = self.shareButton.centerX;
        self.shareLabel.top = self.shareButton.bottom - 10;
        self.shareLabel.hidden = self.shareButton.hidden;
        
        self.line.top = self.priceLabel.bottom + 16;
        
        self.salesLabel.text = [NSString stringWithFormat:@"%@", itemInfo.sales];
        [self.salesLabel sizeToFit];
        self.salesLabel.top = self.line.bottom + 14;

        
        self.discountInfoLabel.text = itemInfo.discountInfo;
        [self.discountInfoLabel sizeToFit];
        self.discountInfoLabel.top = self.line.bottom + 14;
        self.discountInfoLabel.left = self.salesLabel.right + 6;

        self.addressLabel.text = itemInfo.city;
        [self.addressLabel sizeToFit];
        self.addressLabel.top = self.line.bottom + 14;
        self.addressLabel.right = SCREEN_WIDTH - 12;
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    CGFloat height = 0;
    
    if ( cellData ) {
        
        height = 126;
        
        ItemInfoModel *itemInfo = (ItemInfoModel *)cellData;
        //itemInfo.title = @"世纪街时间冻结附近附近方法开发开放开发开放开发开放开发开放开发急急急扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩扩";
        //UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];

        CGSize titleTextSize = [itemInfo.title sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 12-54];
        if (titleTextSize.height > FONT(14).lineHeight*2) {
            height += ceil(FONT(14).lineHeight)*2;
        }else{
            height += ceil(titleTextSize.height);
        }
        
        //CGSize descTextSize = [itemInfo.desc sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 20];
        
        //height += ceil(descTextSize.height);
        
        return height;
    }
    
    return height;
}

#pragma mark - Getters And Setters

- (UILabel *)titleLabel {
    
    if ( !_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 0)];
        _titleLabel.textColor = Color_Gray(62);
        _titleLabel.font = FONT(16);
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

- (UILabel *)descLabel {
    
    if ( !_descLabel ) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 0)];
        _descLabel.textColor = Color_Gray153;
        _descLabel.font = FONT(14);
        _descLabel.numberOfLines = 0;
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _descLabel;
}

- (UILabel *)priceLabel {
    
    if ( !_priceLabel ) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
        _priceLabel.textColor = Theme_Color;
        _priceLabel.font = BOLD_FONT(22);
    }
    
    return _priceLabel;
}

- (UILabel *)oPriceLabel {
    
    if ( !_oPriceLabel ) {
        _oPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _oPriceLabel.textColor = Color_Gray182;
        _oPriceLabel.font = FONT(12);
    }
    
    return _oPriceLabel;
}

- (UILabel *)servivePrice
{
    if ( !_servivePrice ) {
        _servivePrice = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
        _servivePrice.textColor = Color_Gray140;
        _servivePrice.font =FONT(14);
    }
    
    return _servivePrice;
}

- (UILabel *)discountLabel {
    
    if ( !_discountLabel ) {
        _discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 27, 14)];
        _discountLabel.textColor = Color_White;
        _discountLabel.font = FONT(10);
        _discountLabel.numberOfLines = 1;
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        _discountLabel.backgroundColor = Theme_Color;
        _discountLabel.layer.masksToBounds = YES;
        _discountLabel.layer.cornerRadius = 2;
    }
    
    return _discountLabel;
}

- (UILabel*)shareLabel
{
    if (!_shareLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray170;
        label.text = @"分享";
        [label sizeToFit];
        label.userInteractionEnabled = NO;
        _shareLabel = label;
    }
    return _shareLabel;
}

- (UIButton*)shareButton
{
    if (!_shareButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [button setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
        _shareButton = button;
    }
    return _shareButton;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-12, LINE_WIDTH)];
        view.backgroundColor = Color_Gray233;
        _line = view;
    }
    return _line;
}

- (UILabel *)discountInfoLabel {
    
    if ( !_discountInfoLabel ) {
        _discountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _discountInfoLabel.textColor = Color_Gray140;
        _discountInfoLabel.font = FONT(14);
    }
    
    return _discountInfoLabel;
}

- (UILabel *)salesLabel {
    
    if ( !_salesLabel ) {
        _salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
        _salesLabel.textColor = Color_Gray140;
        _salesLabel.font = FONT(14);
    }
    
    return _salesLabel;
}

- (UILabel*)addressLabel
{
    if (!_addressLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray140;
        label.font = FONT(14);
        _addressLabel = label;
    }
    return _addressLabel;
}

- (UIView *)dividerView {
    
    if ( !_dividerView ) {
        _dividerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 10)];
        _dividerView.backgroundColor = Color_Gray153;
    }
    
    return _dividerView;
}

#pragma mark - Button actions 
-(void)handleShareButton
{
    if ([self.delegate respondsToSelector:@selector(cell:shareButtonTapped:)]) {
        [self.delegate cell:self shareButtonTapped:self.cellData];
    }
}
@end
