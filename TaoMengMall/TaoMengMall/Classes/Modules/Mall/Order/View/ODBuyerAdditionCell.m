//
//  ODBuyerAdditionCell.m
//  FlyLantern
//
//  Created by marco on 18/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ODBuyerAdditionCell.h"

@interface ODBuyerAdditionCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *leaveWordLabel;

@end

@implementation ODBuyerAdditionCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.iconImageView];
    [self addSubview:self.topLineView];
    //[self addSubview:self.bottomLineView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.leaveWordLabel];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSString *leaveWord = (NSString *)self.cellData;
        
        //self.bottomLineView.bottom = [ODBuyerAdditionCell heightForCell:self.cellData];
        
        self.titleLabel.text = @"买家留言";
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 40;
        self.titleLabel.top = 15;
        self.titleLabel.width = SCREEN_WIDTH -10- self.titleLabel.left;
        
        self.leaveWordLabel.text = leaveWord;
        self.leaveWordLabel.left = 40;
        self.leaveWordLabel.top = self.titleLabel.bottom + 7;
        self.leaveWordLabel.width = SCREEN_WIDTH - 10 -self.leaveWordLabel.left;
        [self.leaveWordLabel sizeToFit];
        
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    if (cellData) {
        NSString *leaveWord = (NSString *)cellData;
        CGSize textSize = [leaveWord sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 50];
        return textSize.height + 54;
    }
    return 0;
}

#pragma mark - Getters And Setters
- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 28, 17, 17)];
        imageView.image = [UIImage imageNamed:@"order_detail_remark"];
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

- (UILabel *)leaveWordLabel {
    
    if ( !_leaveWordLabel ) {
        _leaveWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _leaveWordLabel.textColor = Color_Gray140;
        _leaveWordLabel.font = FONT(14);
        _leaveWordLabel.numberOfLines = 0;
    }
    
    return _leaveWordLabel;
}
@end
