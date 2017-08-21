//
//  MIMenuItemCell.m
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CIMenuItemCell.h"

@interface CIMenuItemCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *unReadLabel;
@property (nonatomic, strong) UILabel *unReadLabel2;

@end

@implementation CIMenuItemCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.moreImageView];
    [self addSubview:self.unReadLabel];
    [self addSubview:self.unReadLabel2];
    [self addSubview:self.valueLabel];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *itemData = (NSDictionary *)self.cellData;
        
        NSString *iconName = itemData[@"icon"];
        
        self.iconImageView.centerY = [[self class]heightForCell:self.cellData]/2;

        if ( !IsEmptyString(iconName) ) {
            self.iconImageView.image = [UIImage imageNamed:itemData[@"icon"]];
        } else {
            self.iconImageView.hidden = YES;
        }
        
        
        self.titleLabel.text = itemData[@"title"];
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 8;
        self.iconImageView.right = self.titleLabel.left - 30;
        self.titleLabel.centerY = self.iconImageView.centerY;
        
        
        
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
        
        if (itemData[@"unread"] && [itemData[@"unread"] boolValue]) {
            self.unReadLabel.hidden = NO;
        }else{
            self.unReadLabel.hidden = YES;
        }
        
        if (itemData[@"unread2"] && ![itemData[@"unread2"] boolValue]) {
            self.unReadLabel2.hidden = NO;
        }else{
            self.unReadLabel2.hidden = YES;
        }
        
        self.moreImageView.centerY = self.titleLabel.centerY;
        self.lineView.bottom = [[self class]heightForCell:self.cellData];
        self.unReadLabel.width = 20;
        self.unReadLabel.height = self.titleLabel.height;
        self.unReadLabel.centerY = self.titleLabel.centerY;
        self.unReadLabel.left = self.titleLabel.right + 4;
        self.unReadLabel2.width = 20;
        self.unReadLabel2.height = self.titleLabel.height;
        self.unReadLabel2.centerY = self.titleLabel.centerY;
        self.unReadLabel2.left = self.titleLabel.right + 4;
        
        if(itemData[@"value"]){
            self.valueLabel.text = itemData[@"value"];
            [self.valueLabel sizeToFit];
            self.valueLabel.centerY = self.titleLabel.centerY;
            if (itemData[@"arrow"] && [itemData[@"arrow"] boolValue] == YES) {
                self.valueLabel.right = self.moreImageView.left - 8;
            }else{
                self.valueLabel.right = SCREEN_WIDTH - 15;
            }
        }
        

    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if ( cellData ) {
        return 60;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)iconImageView {
    
    if ( !_iconImageView ) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 15, 0, 22, 22)];
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
- (UILabel *)valueLabel {
    
    if ( !_valueLabel ) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _valueLabel.textColor = Color_Gray153;
        _valueLabel.font = FONT(14);
    }
    
    return _valueLabel;
    
}

- (UILabel *)unReadLabel{
    if (!_unReadLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        label.backgroundColor = Color_Red6;
        label.text = @"新";
        label.textColor = Color_White;
        label.font = FONT(14);
        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        _unReadLabel = label;
    }
    return _unReadLabel;
    
}

- (UILabel *)unReadLabel2{
    if (!_unReadLabel2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        label.backgroundColor = Color_Red6;
        label.text = @"赠";
        label.textColor = Color_White;
        label.font = FONT(14);
        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        _unReadLabel2 = label;
    }
    return _unReadLabel2;
    
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
    }
    
    return _lineView;
    
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.right = SCREEN_WIDTH - 15;
    }
    
    return _moreImageView;
}

@end
