//
//  DSHomeSpreadCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSHomePromoteCell.h"

@interface DSHomePromoteCell ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation DSHomePromoteCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.leftImageView];
    [self cellAddSubView:self.rightImageView];
}


+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = (SCREEN_WIDTH-42)/4 + 48;
    }
    return height;
}

#pragma mark - Subviews

- (UIImageView*)leftImageView
{
    if (!_leftImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(14, 24, (SCREEN_WIDTH-42)/2, (SCREEN_WIDTH-42)/4)];
        imageView.image = [UIImage imageNamed:@"icon_distributor_promote"];
        imageView.userInteractionEnabled = YES;
        [imageView bk_whenTapped:^{
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"distributorPromote")];
        }];
        _leftImageView = imageView;
    }
    return _leftImageView;
}

- (UIImageView*)rightImageView
{
    if (!_rightImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 7, 24, (SCREEN_WIDTH-42)/2, (SCREEN_WIDTH-42)/4)];
        imageView.image = [UIImage imageNamed:@"icon_customer_promote"];
        imageView.userInteractionEnabled = YES;
        [imageView bk_whenTapped:^{
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"customerPromote")];
        }];
        _rightImageView = imageView;
    }
    return _rightImageView;
}
@end
