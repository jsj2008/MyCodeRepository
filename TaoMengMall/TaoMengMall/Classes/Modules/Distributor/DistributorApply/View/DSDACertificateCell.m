//
//  DSDACertificateCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSDACertificateCell.h"
#import "DSDistributorApplyModel.h"

@interface DSDACertificateCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UILabel *frontLabel;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *backLabel;
@end

@implementation DSDACertificateCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.frontImageView];
    [self cellAddSubView:self.frontLabel];
    [self cellAddSubView:self.backImageView];
    [self cellAddSubView:self.backLabel];
}

- (void)reloadData
{
    if (self.cellData) {
        DSDistributorApplyModel *model = (DSDistributorApplyModel*)self.cellData;
        
        if (model.frontImageObj) {
            self.frontImageView.image = [model.frontImageObj objectForKey:@"imageData"];
        }
        
        if (model.backImageObj) {
            self.backImageView.image = [model.backImageObj objectForKey:@"imageData"];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = SCREEN_WIDTH/2 + 23 + 20 + 22;
    }
    return height;
}

#pragma mark - subviews
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(18, 22, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray51;
        label.text = @"请按指定要求上传证件照";
        [label sizeToFit];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView*)frontImageView
{
    if (!_frontImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 50, (SCREEN_WIDTH-54)/2, (SCREEN_WIDTH-54)/2)];
        imageView.image = [UIImage imageNamed:@"icon_add_certificate"];
        imageView.userInteractionEnabled = YES;
        weakify(self);
        [imageView bk_whenTapped:^{
            strongify(self);
            if ([self.delegate respondsToSelector:@selector(addButtonTappedAtIndex:)]) {
                [self.delegate addButtonTappedAtIndex:0];
            }
        }];
        _frontImageView = imageView;
    }
    return _frontImageView;
}

- (UILabel*)frontLabel
{
    if (!_frontLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, SCREEN_WIDTH/2 + 23 + 6, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray51;
        label.text = @"身份证正面";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/4;
        _frontLabel = label;
    }
    return _frontLabel;
}

- (UIImageView*)backImageView
{
    if (!_backImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+9, 50, (SCREEN_WIDTH-54)/2, (SCREEN_WIDTH-54)/2)];
        imageView.image = [UIImage imageNamed:@"icon_add_certificate"];
        imageView.userInteractionEnabled = YES;
        weakify(self);
        [imageView bk_whenTapped:^{
            strongify(self);
            if ([self.delegate respondsToSelector:@selector(addButtonTappedAtIndex:)]) {
                [self.delegate addButtonTappedAtIndex:1];
            }
        }];
        _backImageView = imageView;
    }
    return _backImageView;
}

- (UILabel*)backLabel
{
    if (!_backLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, SCREEN_WIDTH/2 + 23 + 6, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray51;
        label.text = @"身份证反面";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH*3/4;
        _backLabel = label;
    }
    return _backLabel;
}

@end
