//
//  DSDLDistributorCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSDLDistributorCell.h"

@interface DSDLDistributorCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *revenueLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation DSDLDistributorCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.avatarImageView];
    [self cellAddSubView:self.phoneLabel];
    [self cellAddSubView:self.nameLabel];
    [self cellAddSubView:self.revenueLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
    if (self.cellData) {
        
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 65;
    }
    return height;
}

#pragma mark - Subviews

- (UIImageView*)avatarImageView
{
    if (!_avatarImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 45, 45)];
        _avatarImageView = imageView;
    }
    return _avatarImageView;
}

- (UILabel*)phoneLabel
{
    if (!_phoneLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(65, 10, 0, 0)];
        label.font = FONT(16);
        _phoneLabel = label;
    }
    return _phoneLabel;
}

- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(65, 36, 0, 0)];
        label.font = FONT(12);
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel*)revenueLabel
{
    if (!_revenueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 14, 0, 0)];
        label.font = FONT(12);
        _revenueLabel = label;
    }
    return _revenueLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        _line = view;
    }
    return _line;
}
@end
