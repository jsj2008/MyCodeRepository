//
//  DSDistributorCell.m
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSDistributorCell.h"
#import "DSDistributorModel.h"

@interface DSDistributorCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *revenueLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation DSDistributorCell

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
        DSDistributorModel *model = (DSDistributorModel*)self.cellData;
        
        [self.avatarImageView setOnlineImage:model.avatar];
        
        self.phoneLabel.text = model.phone;
        [self.phoneLabel sizeToFit];
        
        self.nameLabel.text = model.name?model.name:@"";
        [self.nameLabel sizeToFit];
        
        self.revenueLabel.text = model.desc;
        [self.revenueLabel sizeToFit];
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

#pragma mark -
- (UIImageView*)avatarImageView
{
    if (!_avatarImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 45, 45)];
        _avatarImageView = imageView;
    }
    return _avatarImageView;
}

- (UILabel*)phoneLabel
{
    if (!_phoneLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(65, 12, 0, 0)];
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
        label.textColor = Color_Gray153;
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel*)revenueLabel
{
    if (!_revenueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray153;
        _revenueLabel = label;
    }
    return _revenueLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-65, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 65;
        _line = view;
    }
    return _line;
}
@end
