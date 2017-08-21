//
//  MIMenuItemCell.m
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "MIMenuItemCell.h"

@interface MIMenuItemCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic,strong) UILabel *valueLabel;
@end

@implementation MIMenuItemCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.moreImageView];
    [self addSubview:self.valueLabel];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *itemData = (NSDictionary *)self.cellData;
        
        NSString *iconName = itemData[@"icon"];
        
        if ( !IsEmptyString(iconName) ) {
            self.iconImageView.image = [UIImage imageNamed:itemData[@"icon"]];
            [self.iconImageView sizeToFit];
            self.iconImageView.centerX = 29;
        } else {
            self.iconImageView.hidden = YES;
        }
        
        
        self.titleLabel.text = itemData[@"title"];
        [self.titleLabel sizeToFit];
        if ( !IsEmptyString(iconName) ) {
            self.titleLabel.left = self.iconImageView.right + 13;
        } else {
            self.titleLabel.left = 20;
        }
        self.titleLabel.centerY = 22.5;
        
        
        if ( [itemData[@"line"] boolValue] ) {
            self.lineView.hidden = NO;
        } else {
            self.lineView.hidden = YES;
        }
        
        if ( [itemData[@"arrow"] boolValue] ) {
            self.moreImageView.hidden = NO;
        } else {
            self.moreImageView.hidden = YES;
        }
        
        self.valueLabel.text = itemData[@"value"];
        [self.valueLabel sizeToFit];
        self.valueLabel.centerY = 22.5;
        self.valueLabel.right = self.moreImageView.left - 5;
        
        if ([self.titleLabel.text isEqualToString:@"居住地"]) {
            self.valueLabel.textColor = Color_Gray(186);
            self.valueLabel.right = self.moreImageView.right;

        }else {
            self.valueLabel.textColor = Theme_Color;
        }
        if (self.valueLabel.left < self.titleLabel.right-10) {
            self.valueLabel.width =self.moreImageView.left-15-self.titleLabel.right;
            self.valueLabel.right = self.moreImageView.left - 5;
            
        }
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if ( cellData ) {
        
        NSDictionary *itemData = (NSDictionary *)cellData;
        
        if ( [@"empty" isEqualToString:itemData[@"type"]] ) {
            return 15;
        } else {
            return 45;
        }
        
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)iconImageView {
    
    if ( !_iconImageView ) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 20, 0, 18, 18)];
        _iconImageView.centerY = 22.5;
    }
    
    return _iconImageView;
}

- (UILabel *)titleLabel {
    
    if ( !_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.textColor = Color_Gray42;
        _titleLabel.font = FONT(16);
    }
    
    return _titleLabel;
    
}

- (UILabel *)valueLabel
{
    if ( !_valueLabel ) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _valueLabel.textColor = Theme_Color;
        _valueLabel.font = FONT(16);
        _valueLabel.numberOfLines=1;
    }
    
    return _valueLabel;
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
        _lineView.bottom = 45;
    }
    
    return _lineView;
    
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = 22.5;
        _moreImageView.right = SCREEN_WIDTH - 15;
    }
    
    return _moreImageView;
}

@end
