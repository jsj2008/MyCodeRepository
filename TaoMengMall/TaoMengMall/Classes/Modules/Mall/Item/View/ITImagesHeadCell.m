//
//  ITImagesHeadCell.m
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITImagesHeadCell.h"

@interface ITImagesHeadCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ITImagesHeadCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.titleLabel];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    return 40;

}

#pragma mark - Getters And Setters

- (UILabel *)titleLabel {
    
    if ( !_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.textColor = Color_Gray17;
        _titleLabel.font = FONT(14);
        _titleLabel.text = @"图文详情";
        [_titleLabel sizeToFit];
        
        _titleLabel.left = 33;
        _titleLabel.top = 13;
    }
    
    return _titleLabel;
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
        _lineView.bottom = [ITImagesHeadCell heightForCell:nil];
    }
    
    return _lineView;
}

@end
