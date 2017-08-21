//
//  DSStatisticsRevenueLegendCell.m
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSStatisticsRevenueLegendCell.h"
#import "DSStatisticsRevenueLegendModel.h"
#import "DistributorHeader.h"


@interface DSStatisticsRevenueLegendCell ()
@property (nonatomic, strong) UILabel *salesValueLabel;
@property (nonatomic, strong) UILabel *salesLabel;
@property (nonatomic, strong) UIView *salesSpot;

@property (nonatomic, strong) UILabel *distributorValueLabel;
@property (nonatomic, strong) UILabel *distributorLabel;
@property (nonatomic, strong) UIView *distributorSpot;
@end

@implementation DSStatisticsRevenueLegendCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.salesValueLabel];
    [self cellAddSubView:self.salesLabel];
    [self cellAddSubView:self.salesSpot];
    
    [self cellAddSubView:self.distributorValueLabel];
    [self cellAddSubView:self.distributorLabel];
    [self cellAddSubView:self.distributorSpot];
}

- (void)reloadData
{
    if (self.cellData) {
        DSStatisticsRevenueLegendModel *model = (DSStatisticsRevenueLegendModel*)self.cellData;
        
        self.salesValueLabel.text = model.total;
        [self.salesValueLabel sizeToFit];
        self.salesValueLabel.left = SCREEN_WIDTH/4;
        
        self.distributorValueLabel.text = model.distribute;
        [self.distributorValueLabel sizeToFit];
        self.distributorValueLabel.left = SCREEN_WIDTH*3/4.;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 78;
    }
    return height;
}

#pragma mark - Subviews
- (UILabel*)salesValueLabel
{
    if (!_salesValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 16, 0, 0)];
        label.font = BOLD_FONT(20);
        _salesValueLabel = label;
    }
    return _salesValueLabel;
}

- (UILabel*)salesLabel
{
    if (!_salesLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 48, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray100;
        label.text = @"总销售";
        [label sizeToFit];
        label.left = SCREEN_WIDTH/4;
        _salesLabel = label;
    }
    return _salesLabel;
}

- (UIView*)salesSpot
{
    if (!_salesSpot) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];
        view.backgroundColor = Chart_Red;
        view.layer.cornerRadius = 3.;
        view.layer.masksToBounds = YES;
        view.right = self.salesLabel.left - 12;
        view.centerY = self.salesLabel.centerY;
        _salesSpot = view;
    }
    return _salesSpot;
}

- (UILabel*)distributorValueLabel
{
    if (!_distributorValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 16, 0, 0)];
        label.font = BOLD_FONT(20);
        _distributorValueLabel = label;
    }
    return _distributorValueLabel;
}

- (UILabel*)distributorLabel
{
    if (!_distributorLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 48, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray100;
        label.text = @"分销商品";
        [label sizeToFit];
        label.left = SCREEN_WIDTH*3/4;
        _distributorLabel = label;
    }
    return _distributorLabel;
}

- (UIView*)distributorSpot
{
    if (!_distributorSpot) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];
        view.backgroundColor = Chart_Blue;
        view.layer.cornerRadius = 3.;
        view.layer.masksToBounds = YES;
        view.right = self.distributorLabel.left - 12;
        view.centerY = self.distributorLabel.centerY;
        _distributorSpot = view;
    }
    return _distributorSpot;
}
@end
