//
//  DSHomeManageCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSHomeManageCell.h"

@interface DSHomeManageCell ()
@property (nonatomic, strong) UIImageView *distributorImageView;
@property (nonatomic, strong) UILabel  *distributorLabel;

@property (nonatomic, strong) UIImageView *statisticsImageView;
@property (nonatomic, strong) UILabel  *statisticsLabel;

@property (nonatomic, strong) UIImageView *customerImageView;
@property (nonatomic, strong) UILabel  *customerLabel;
@end

@implementation DSHomeManageCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.distributorLabel];
    [self cellAddSubView:self.distributorImageView];
    [self cellAddSubView:self.statisticsLabel];
    [self cellAddSubView:self.statisticsImageView];
    [self cellAddSubView:self.customerLabel];
    [self cellAddSubView:self.customerImageView];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 142;
    }
    return height;
}

#pragma mark - Subviews

- (UIImageView*)distributorImageView
{
    if (!_distributorImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 32, 44, 44)];
        imageView.image = [UIImage imageNamed:@"icon_distributor_manage"];
        imageView.layer.cornerRadius = 6.;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.centerX = SCREEN_WIDTH/6;
        [imageView bk_whenTapped:^{
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"distributorManage")];
        }];
        _distributorImageView = imageView;
    }
    return _distributorImageView;
}

- (UILabel*)distributorLabel
{
    if (!_distributorLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 87, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray100;
        label.text = @"分销管理";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/6;
        _distributorLabel = label;
    }
    return _distributorLabel;
}

- (UIImageView*)statisticsImageView
{
    if (!_statisticsImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 32, 44, 44)];
        imageView.image = [UIImage imageNamed:@"icon_distributor_statistics"];
        imageView.layer.cornerRadius = 6.;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.centerX = SCREEN_WIDTH/2;
        [imageView bk_whenTapped:^{
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"distributorStatistics")];
        }];
        _statisticsImageView = imageView;
    }
    return _statisticsImageView;
}

- (UILabel*)statisticsLabel
{
    if (!_statisticsLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 87, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray100;
        label.text = @"数据统计";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/2;
        _statisticsLabel = label;
    }
    return _statisticsLabel;
}

- (UIImageView*)customerImageView
{
    if (!_customerImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 32, 44, 44)];
        imageView.image = [UIImage imageNamed:@"icon_customer_manage"];
        imageView.layer.cornerRadius = 6.;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.centerX = SCREEN_WIDTH*5/6;
        [imageView bk_whenTapped:^{
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"customerManage")];
        }];
        _customerImageView = imageView;
    }
    return _customerImageView;
}

- (UILabel*)customerLabel
{
    if (!_customerLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 87, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray100;
        label.text = @"客户管理";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH*5/6;
        _customerLabel = label;
    }
    return _customerLabel;
}
@end 
