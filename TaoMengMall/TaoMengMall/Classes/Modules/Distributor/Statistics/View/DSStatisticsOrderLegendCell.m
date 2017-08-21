//
//  DSStatisticsOrderLegendCell.m
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSStatisticsOrderLegendCell.h"
#import "DSStatisticsOrderLegendModel.h"
#import "DistributorHeader.h"

@interface DSStatisticsOrderLegendCell ()
@property (nonatomic, strong) UILabel *paidValueLabel;
@property (nonatomic, strong) UILabel *paidLabel;
@property (nonatomic, strong) UIView *paidSpot;

@property (nonatomic, strong) UILabel *deliveredValueLabel;
@property (nonatomic, strong) UILabel *deliveredLabel;
@property (nonatomic, strong) UIView *deliveredSpot;

@end

@implementation DSStatisticsOrderLegendCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.paidValueLabel];
    [self cellAddSubView:self.paidLabel];
    [self cellAddSubView:self.paidSpot];
    
    [self cellAddSubView:self.deliveredValueLabel];
    [self cellAddSubView:self.deliveredLabel];
    [self cellAddSubView:self.deliveredSpot];
}

- (void)reloadData
{
    if (self.cellData) {
        DSStatisticsOrderLegendModel *model = (DSStatisticsOrderLegendModel*)self.cellData;
        
        self.paidValueLabel.text = model.paid;
        [self.paidValueLabel sizeToFit];
        self.paidValueLabel.left = SCREEN_WIDTH/4;
        
        self.deliveredValueLabel.text = model.delivered;
        [self.deliveredValueLabel sizeToFit];
        self.deliveredValueLabel.left = SCREEN_WIDTH*3/4.;
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
- (UILabel*)paidValueLabel
{
    if (!_paidValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 16, 0, 0)];
        label.font = BOLD_FONT(20);
        _paidValueLabel = label;
    }
    return _paidValueLabel;
}

- (UILabel*)paidLabel
{
    if (!_paidLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 48, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray100;
        label.text = @"付款订单";
        [label sizeToFit];
        label.left = SCREEN_WIDTH/4;
        _paidLabel = label;
    }
    return _paidLabel;
}

- (UIView*)paidSpot
{
    if (!_paidSpot) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];
        view.backgroundColor = Chart_Red;
        view.layer.cornerRadius = 3.;
        view.layer.masksToBounds = YES;
        view.right = self.paidLabel.left - 12;
        view.centerY = self.paidLabel.centerY;
        _paidSpot = view;
    }
    return _paidSpot;
}

- (UILabel*)deliveredValueLabel
{
    if (!_deliveredValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 16, 0, 0)];
        label.font = BOLD_FONT(20);
        _deliveredValueLabel = label;
    }
    return _deliveredValueLabel;
}

- (UILabel*)deliveredLabel
{
    if (!_deliveredLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 48, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray100;
        label.text = @"发货订单";
        [label sizeToFit];
        label.left = SCREEN_WIDTH*3/4;
        _deliveredLabel = label;
    }
    return _deliveredLabel;
}

- (UIView*)deliveredSpot
{
    if (!_deliveredSpot) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];
        view.backgroundColor = Chart_Blue;
        view.layer.cornerRadius = 3.;
        view.layer.masksToBounds = YES;
        view.right = self.deliveredLabel.left - 12;
        view.centerY = self.deliveredLabel.centerY;
        _deliveredSpot = view;
    }
    return _deliveredSpot;
}
@end
