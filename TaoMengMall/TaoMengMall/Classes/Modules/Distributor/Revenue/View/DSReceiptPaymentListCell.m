//
//  DSReceiptPaymentListCell.m
//  CarKeeper
//
//  Created by marco on 3/3/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSReceiptPaymentListCell.h"
#import "DSReceiptPaymentModel.h"

@interface DSReceiptPaymentListCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation DSReceiptPaymentListCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.amountLabel];
    [self cellAddSubView:self.sourceLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
    if (self.cellData) {
        DSReceiptPaymentModel *model = (DSReceiptPaymentModel*)self.cellData;
        
        self.titleLabel.text = model.title;
        [self.titleLabel sizeToFit];
        
        self.timeLabel.text = model.time;
        [self.timeLabel sizeToFit];
        
        self.amountLabel.text = model.amount;
        [self.amountLabel sizeToFit];
        self.amountLabel.right = SCREEN_WIDTH - 12;
        if ([model.type isEqualToString:@"1"]) {
            self.amountLabel.textColor = RGB(8, 195, 2);
        }else if ([model.type isEqualToString:@"2"]) {
            self.amountLabel.textColor = RGB(195, 8, 2);
        }
        
        self.sourceLabel.text = model.source;
        [self.sourceLabel sizeToFit];
        self.sourceLabel.right = SCREEN_WIDTH - 12;
        if (self.sourceLabel.left < self.timeLabel.right + 8) {
            self.sourceLabel.width = SCREEN_WIDTH - 12 - self.timeLabel.right - 8;
        }
        if (self.titleLabel.width > SCREEN_WIDTH*2/3) {
            self.titleLabel.width = SCREEN_WIDTH*2/3;
        }
        if (self.amountLabel.width > SCREEN_WIDTH/3) {
            self.amountLabel.width = SCREEN_WIDTH/3;
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 60;
    }
    return height;
}

#pragma mark - Subviews
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 0, 0)];
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 32, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray153;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel*)amountLabel
{
    if (!_amountLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 0, 0)];
        label.font = FONT(14);
        _amountLabel = label;
    }
    return _amountLabel;
}

- (UILabel*)sourceLabel
{
    if (!_sourceLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 32, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray153;
        _sourceLabel = label;
    }
    return _sourceLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 60;
        _line = view;
    }
    return _line;
}
@end
