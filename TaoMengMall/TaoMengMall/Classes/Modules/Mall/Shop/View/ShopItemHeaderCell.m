//
//  ShopItemHeaderCell.m
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopItemHeaderCell.h"

@interface ShopItemHeaderCell ()
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line2;
@end


@implementation ShopItemHeaderCell

- (void)reloadData
{
    if (self.cellData) {
        [self cellAddSubview:self.line1];
        [self cellAddSubview:self.line2];
        [self cellAddSubview:self.titleLabel];
        
        NSString *head = (NSString*)self.cellData;
        
        self.titleLabel.text = head;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = 21;
        self.titleLabel.centerX = SCREEN_WIDTH/2;
        
        self.line1.right = self.titleLabel.left - 6;
        self.line1.centerY =  self.titleLabel.centerY;
        
        self.line2.left = self.titleLabel.right + 6;
        self.line2.centerY = self.titleLabel.centerY;
    }else{
        [self removeAllSubviews];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        return 42;
    }
    return 0;
}

#pragma mark - Subviews

- (UIView*)line1
{
    if (!_line1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 1)];
        view.backgroundColor = Color_Gray194;
        _line1 = view;
    }
    return _line1;
}


- (UIView*)line2
{
    if (!_line2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 1)];
        view.backgroundColor = Color_Gray194;
        _line2 = view;
    }
    return _line2;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}
@end
