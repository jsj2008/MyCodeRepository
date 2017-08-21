//
//  ODExpressCell.m
//  FlyLantern
//
//  Created by marco on 18/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ODExpressCell.h"
#import "ODExpressModel.h"

@interface ODExpressCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *IDLabel;
@end

@implementation ODExpressCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.iconImageView];
    [self addSubview:self.topLineView];
    //[self addSubview:self.bottomLineView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.companyLabel];
    [self addSubview:self.IDLabel];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ODExpressModel *express = (ODExpressModel *)self.cellData;
        
        //self.bottomLineView.bottom = [ODExpressCell heightForCell:self.cellData];
        
        self.titleLabel.text = @"物流信息";
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 40;
        self.titleLabel.top = 15;
        self.titleLabel.width = SCREEN_WIDTH -10- self.titleLabel.left;
        
        self.companyLabel.text = express.company;
        [self.companyLabel sizeToFit];
        self.companyLabel.left = 40;
        self.companyLabel.top = self.titleLabel.bottom + 7;
        self.companyLabel.width = SCREEN_WIDTH - 10 -self.companyLabel.left;
        
        self.IDLabel.text = express.identity;
        [self.IDLabel sizeToFit];
        self.IDLabel.left = 40;
        self.IDLabel.top = self.companyLabel.bottom;
        self.IDLabel.width = SCREEN_WIDTH - 10 -self.IDLabel.left;
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    if (cellData) {
        return 96;
    }
    return 0;
}

#pragma mark - Getters And Setters
- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 28, 19, 15)];
        imageView.image = [UIImage imageNamed:@"order_detail_express"];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UIView *)topLineView {
    
    if ( !_topLineView ) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _topLineView.backgroundColor = Color_Gray233;
    }
    
    return _topLineView;
}

- (UIView *)bottomLineView {
    
    if ( !_bottomLineView ) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _bottomLineView.backgroundColor = Color_Gray233;
    }
    
    return _bottomLineView;
}

- (UILabel *)titleLabel {
    
    if ( !_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.textColor = Color_Gray66;
        _titleLabel.font = FONT(16);
        _titleLabel.numberOfLines = 1;
    }
    
    return _titleLabel;
}

- (UILabel *)companyLabel {
    
    if ( !_companyLabel ) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _companyLabel.textColor = Color_Gray140;
        _companyLabel.font = FONT(14);
        _companyLabel.numberOfLines = 1;
    }
    
    return _companyLabel;
}

- (UILabel *)IDLabel {
    
    if ( !_IDLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray140;
        label.font = FONT(14);
        label.numberOfLines = 1;
        _IDLabel = label;
    }
    return _IDLabel;
}
@end
