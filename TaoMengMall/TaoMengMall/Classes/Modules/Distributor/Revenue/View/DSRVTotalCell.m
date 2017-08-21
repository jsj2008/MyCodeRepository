//
//  DSRVTotalCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSRVTotalCell.h"

@interface DSRVTotalCell ()
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UILabel *totalValueLabel;
@property (nonatomic, strong) UILabel *withdrawLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UIView *line;
@end

@implementation DSRVTotalCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.totalLabel];
    [self cellAddSubView:self.currencyLabel];
    [self cellAddSubView:self.totalValueLabel];
    [self cellAddSubView:self.withdrawLabel];
    [self cellAddSubView:self.moreImageView];
    [self cellAddSubView:self.line];
    [self bk_whenTapped:^{
        [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"dsWithdraw")];
    }];
}

- (void)reloadData
{
    if (self.cellData) {
        NSString *value = (NSString *)self.cellData;
        self.totalValueLabel.text = value;
        [self.totalValueLabel sizeToFit];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 134;
    }
    return height;
}

#pragma mark -Subviews
- (UILabel*)totalLabel
{
    if (!_totalLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 17, 0, 0)];
        label.font = FONT(14);
        label.text = @"可提现金额";
        [label sizeToFit];
        _totalLabel = label;
    }
    return _totalLabel;
}

- (UILabel*)currencyLabel
{
    if (!_currencyLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 17, 0, 0)];
        label.font = FONT(14);
        label.text = @"￥";
        [label sizeToFit];
        label.bottom = self.totalValueLabel.bottom - 8;
        _currencyLabel = label;
    }
    return _currencyLabel;
}

- (UILabel*)totalValueLabel
{
    if (!_totalValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32, 56, 0, 0)];
        label.font = BOLD_FONT(40);
        label.textColor = Color_Gray51;
        label.text = @"0.00";
        [label sizeToFit];
        _totalValueLabel = label;
    }
    return _totalValueLabel;
}

- (UILabel*)withdrawLabel
{
    if (!_withdrawLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 17, 0, 0)];
        label.font = FONT(14);
        label.text = @"提现";
        [label sizeToFit];
        label.centerY = self.moreImageView.centerY;
        label.right = self.moreImageView.left - 2;
        _withdrawLabel = label;
    }
    return _withdrawLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.right = SCREEN_WIDTH -12;
        _moreImageView.centerY = 134/2.;
    }
    
    return _moreImageView;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-12, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 134;
        _line = view;
    }
    return _line;
}

@end
