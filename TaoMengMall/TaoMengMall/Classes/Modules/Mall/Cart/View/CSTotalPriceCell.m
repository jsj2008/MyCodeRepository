//
//  CSTotalPriceCell.m
//  LianWei
//
//  Created by marco on 7/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CSTotalPriceCell.h"

@interface CSTotalPriceCell ()
@property (nonatomic, strong) UIView *line1View;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *totalPriceValueLabel;
@end

@implementation CSTotalPriceCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.line1View];
    [self addSubview:self.totalPriceLabel];
    [self addSubview:self.totalPriceValueLabel];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *data = (NSDictionary *)self.cellData;
        
        self.totalPriceValueLabel.text = [data objectForKey:@"totalPrice"];
        [self.totalPriceValueLabel sizeToFit];
        self.totalPriceValueLabel.centerY = self.totalPriceLabel.centerY;
        self.totalPriceValueLabel.right = SCREEN_WIDTH - 14;
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



- (UILabel *)totalPriceLabel {
    
    if ( !_totalPriceLabel ) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _totalPriceLabel.textColor = Color_Gray113;
        _totalPriceLabel.font = FONT(14);
        _totalPriceLabel.numberOfLines = 1;
        _totalPriceLabel.text = @"价格合计：";
        [_totalPriceLabel sizeToFit];
        _totalPriceLabel.centerY = 21;
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

@end
