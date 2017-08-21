//
//  CSTotalInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CSTotalInfoCell.h"

@interface CSTotalInfoCell ()

@property (nonatomic, strong) UIView *line1View;
@property (nonatomic, strong) UIView *line2View;
@property (nonatomic, strong) UIView *line3View;
@property (nonatomic, strong) UIView *line4View;
@property (nonatomic, strong) UILabel *shippingWayLabel;
@property (nonatomic, strong) UILabel *shippingWayValueLabel;
@property (nonatomic, strong) UILabel *shippingFeeLabel;
@property (nonatomic, strong) UILabel *shippingFeeValueLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *totalPriceValueLabel;
@property (nonatomic, strong) UITextField *additionTextField;
@end

@implementation CSTotalInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.line1View];
    [self addSubview:self.line2View];
    [self addSubview:self.line3View];
    [self addSubview:self.line4View];
    [self addSubview:self.shippingFeeLabel];
    [self addSubview:self.shippingFeeValueLabel];
    [self addSubview:self.shippingWayLabel];
    [self addSubview:self.shippingWayValueLabel];
    [self addSubview:self.totalPriceLabel];
    [self addSubview:self.totalPriceValueLabel];
    [self addSubview:self.additionTextField];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *data = (NSDictionary *)self.cellData;
        
        self.shippingFeeValueLabel.text = [data objectForKey:@"shippingFee"];
        [self.shippingFeeValueLabel sizeToFit];
        self.shippingFeeValueLabel.centerY = self.shippingFeeLabel.centerY;
        self.shippingFeeValueLabel.right = SCREEN_WIDTH - 14;
        
        self.totalPriceValueLabel.text = [data objectForKey:@"totalPrice"];
        [self.totalPriceValueLabel sizeToFit];
        self.totalPriceValueLabel.centerY = self.totalPriceLabel.centerY;
        self.totalPriceValueLabel.right = SCREEN_WIDTH - 14;
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 84;
    }
    return 0;
}

#pragma mark - Getters And Setters

- (UIView *)line1View {
    
    if ( !_line1View ) {
        _line1View = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _line1View.backgroundColor = Color_Gray230;
        _line1View.bottom = 42;
    }
    
    return _line1View;
}

- (UIView *)line2View {
    
    if ( !_line2View ) {
        _line2View = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _line2View.backgroundColor = Color_Gray230;
        _line2View.bottom = 84;
    }
    
    return _line2View;
}

- (UIView*)line3View
{
    if (!_line3View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        _line3View = view;
    }
    return _line3View;
}

- (UIView*)line4View
{
    if (!_line4View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        _line4View = view;
    }
    return _line4View;
}

- (UILabel *)shippingWayLabel {
    
    if ( !_shippingWayLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray113;
        label.font = FONT(14);
        label.numberOfLines = 1;
        label.text = @"配送方式：";
        [label sizeToFit];
        label.centerY = 21;
        label.left = 14;
        _shippingWayLabel = label;
    }
    
    return _shippingWayLabel;
}

- (UILabel *)shippingWayValueLabel {
    
    if ( !_shippingWayValueLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray113;
        label.font = FONT(14);
        label.numberOfLines = 1;
        _shippingWayValueLabel = label;
    }
    
    return _shippingFeeValueLabel;
}

- (UILabel *)shippingFeeLabel {
    
    if ( !_shippingFeeLabel ) {
        _shippingFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shippingFeeLabel.textColor = Color_Gray113;
        _shippingFeeLabel.font = FONT(14);
        _shippingFeeLabel.numberOfLines = 1;
        _shippingFeeLabel.text = @"快递运费：";
        [_shippingFeeLabel sizeToFit];
        _shippingFeeLabel.centerY = 21;
        _shippingFeeLabel.left = 14;
    }
    
    return _shippingFeeLabel;
}

- (UILabel *)shippingFeeValueLabel {
    
    if ( !_shippingFeeValueLabel ) {
        _shippingFeeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shippingFeeValueLabel.textColor = Color_Gray113;
        _shippingFeeValueLabel.font = FONT(14);
        _shippingFeeValueLabel.numberOfLines = 1;
    }
    
    return _shippingFeeValueLabel;
}

- (UILabel *)totalPriceLabel {
    
    if ( !_totalPriceLabel ) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _totalPriceLabel.textColor = Color_Gray113;
        _totalPriceLabel.font = FONT(14);
        _totalPriceLabel.numberOfLines = 1;
        _totalPriceLabel.text = @"价格合计：";
        [_totalPriceLabel sizeToFit];
        _totalPriceLabel.centerY = 42 + 21;
        _totalPriceLabel.left = 14;
    }
    
    return _totalPriceLabel;
}

- (UILabel *)totalPriceValueLabel {
    
    if ( !_totalPriceValueLabel ) {
        _totalPriceValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _totalPriceValueLabel.textColor = Color_Gray113;
        _totalPriceValueLabel.font = FONT(14);
        _totalPriceValueLabel.numberOfLines = 1;
    }
    
    return _totalPriceValueLabel;
}

- (UITextField*)additionTextField
{
    if (!_additionTextField) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 40)];
        textField.placeholder = @"订单补充说明...";
        textField.font = FONT(14);
        _additionTextField = textField;
    }
    return _additionTextField;
}

@end
