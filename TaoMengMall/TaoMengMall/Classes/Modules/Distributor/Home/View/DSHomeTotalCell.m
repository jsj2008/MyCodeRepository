//
//  DSHomeTotalCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSHomeTotalCell.h"
#import "DSHomeResultModel.h"

@interface DSHomeTotalCell ()

@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *totalValueLabel;
@property (nonatomic, strong) UILabel *dayOrderLabel;
@property (nonatomic, strong) UILabel *dayOrderValueLabel;
@property (nonatomic, strong) UILabel *dayRevenueLabel;
@property (nonatomic, strong) UILabel *dayRevenueValueLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *pipe;
@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation DSHomeTotalCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.totalLabel];
    [self cellAddSubView:self.totalValueLabel];
    [self cellAddSubView:self.dayOrderLabel];
    [self cellAddSubView:self.dayOrderValueLabel];
    [self cellAddSubView:self.dayRevenueLabel];
    [self cellAddSubView:self.dayRevenueValueLabel];
    [self cellAddSubView:self.line];
    [self cellAddSubView:self.pipe];
    [self cellAddSubView:self.moreImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tap];
}

- (void)reloadData
{
    if (self.cellData) {
        DSHomeResultModel *model = (DSHomeResultModel*)self.cellData;
        
        self.totalValueLabel.text = model.accumulatedIncome;
        [self.totalValueLabel sizeToFit];
        self.totalValueLabel.centerX = SCREEN_WIDTH/2;
        
        self.dayOrderValueLabel.text = model.recentOrder;
        [self.dayOrderValueLabel sizeToFit];
        self.dayOrderValueLabel.centerX = SCREEN_WIDTH/4;
        
        self.dayRevenueValueLabel.text = model.recentIncome;
        [self.dayRevenueValueLabel sizeToFit];
        self.dayRevenueValueLabel.centerX = SCREEN_WIDTH*3/4;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 172;
    }
    return height;
}

#pragma mark - Subviews
- (UILabel*)totalLabel
{
    if (!_totalLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 32, 0, 0)];
        label.font = FONT(12);
        label.text = @"累计收入";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH /2;
        _totalLabel = label;
    }
    return _totalLabel;
}

- (UILabel*)totalValueLabel
{
    if (!_totalValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 50, 0, 0)];
        label.font = BOLD_FONT(32);
        label.text = @"0.00";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH /2;
        _totalValueLabel = label;
    }
    return _totalValueLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-12, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 102;
        _line = view;
    }
    return _line;
}

- (UIView*)pipe
{
    if (!_pipe) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 115, LINE_WIDTH, 38)];
        view.backgroundColor = Color_Gray238;
        _pipe = view;
    }
    return _pipe;
}

- (UILabel*)dayOrderValueLabel
{
    if (!_dayOrderValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 112, 0, 0)];
        label.font = BOLD_FONT(18);
        label.text = @"0";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/4;
        _dayOrderValueLabel = label;
    }
    return _dayOrderValueLabel;
}

- (UILabel*)dayOrderLabel
{
    if (!_dayOrderLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 140, 0, 0)];
        label.font = FONT(12);
        label.text = @"七日订单";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/4;
        _dayOrderLabel = label;
    }
    return _dayOrderLabel;
}

- (UILabel*)dayRevenueValueLabel
{
    if (!_dayRevenueValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 112, 0, 0)];
        label.font = BOLD_FONT(18);
        label.text = @"0";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH*3/4;
        _dayRevenueValueLabel = label;
    }
    return _dayRevenueValueLabel;
}

- (UILabel*)dayRevenueLabel
{
    if (!_dayRevenueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 140, 0, 0)];
        label.font = FONT(12);
        label.text = @"七日营收";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH*3/4;
        _dayRevenueLabel = label;
    }
    return _dayRevenueLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 18)];
        _moreImageView.image = [UIImage imageNamed:@"icon_More"];
        _moreImageView.right = SCREEN_WIDTH -12;
        _moreImageView.centerY = 50;
    }
    
    return _moreImageView;
}

#pragma mark -Gesture
- (void)handleTapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:self];
    if (location.y < 102) {
        [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"distributorRevenue")];
    }else{
        if (location.x < SCREEN_WIDTH/2) {
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"distributorStatistics?xxType=1")];
        }else{
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"distributorStatistics?xxType=2")];
        }
    }
}
@end
