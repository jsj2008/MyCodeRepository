//
//  CSShippingFeeCell.m
//  LianWei
//
//  Created by marco on 7/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CSShippingFeeCell.h"

@interface CSShippingFeeCell ()
@property (nonatomic, strong) UIView *line1View;
@property (nonatomic, strong) UILabel *shippingFeeLabel;
@property (nonatomic, strong) UILabel *shippingFeeValueLabel;
@end

@implementation CSShippingFeeCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.line1View];
    [self addSubview:self.shippingFeeLabel];
    [self addSubview:self.shippingFeeValueLabel];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *data = (NSDictionary *)self.cellData;
        
        self.shippingFeeValueLabel.text = [data objectForKey:@"shippingFee"];
        [self.shippingFeeValueLabel sizeToFit];
        self.shippingFeeValueLabel.centerY = self.shippingFeeLabel.centerY;
        self.shippingFeeValueLabel.right = SCREEN_WIDTH - 14;

    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 42;
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
@end
