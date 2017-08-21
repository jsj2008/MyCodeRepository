//
//  LRItemCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/30.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LRItemCell.h"
#import "LotteryRefundResultModel.h"

@interface LRItemCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *peopleNumberLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *refundDescLabel;
@property (nonatomic, strong) UILabel *refundLabel;


@end

@implementation LRItemCell

- (void)drawCell{
    self.backgroundColor = Color_White;
    
    [self cellAddSubView:self.iconView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.peopleNumberLabel];
    [self cellAddSubView:self.amountLabel];
    [self cellAddSubView:self.line];
    [self cellAddSubView:self.refundDescLabel];
    [self cellAddSubView:self.refundLabel];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        LotteryRefundResultModel *model = cellData;
        height = 110 + [model.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 16 - 70 - 12].height;
    }
    return height;
}


- (void)reloadData{
    if (self.cellData) {
        LotteryRefundResultModel *model = self.cellData;
        
        [self.iconView setOnlineImage:model.item.cover];
        
        self.titleLabel.text = model.item.name;
        self.titleLabel.width = SCREEN_WIDTH - 16 - self.iconView.width - 12;
        self.titleLabel.height = [model.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 16 - self.iconView.width - 12].height;
        self.titleLabel.top = 8;
        self.titleLabel.left = self.iconView.right + 8;
        
        self.peopleNumberLabel.text = [NSString stringWithFormat:@"总需：%@人次",model.allParticipantTimes];
        [self.peopleNumberLabel sizeToFit];
        self.peopleNumberLabel.top = self.titleLabel.bottom + 4;
        self.peopleNumberLabel.left = self.titleLabel.left;
        
        
        
        NSString *timesStr = [NSString stringWithFormat:@"本期参与：%@人次",model.participantTimes];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:timesStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(5, model.participantTimes.length)];
        self.amountLabel.attributedText = attributedStr;
        [self.amountLabel sizeToFit];
        self.amountLabel.top = self.peopleNumberLabel.bottom + 2;
        self.amountLabel.left = self.peopleNumberLabel.left;
        
        
        self.line.top = self.iconView.bottom > self.amountLabel.bottom ? self.iconView.bottom + 8 : self.amountLabel.bottom + 8;
        
        self.refundDescLabel.top = self.line.bottom + 12;
        self.refundDescLabel.left = 12;
        
        self.refundLabel.text = model.refund;
        [self.refundLabel sizeToFit];
        self.refundLabel.centerY = self.refundDescLabel.centerY;
        self.refundLabel.left = self.refundDescLabel.right;
    }
}

#pragma mark - getters

- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = imageView.height = 70;
        imageView.top = imageView.left = 12;
        _iconView = imageView;
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray42;
        label.numberOfLines = 0;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)peopleNumberLabel{
    if (!_peopleNumberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _peopleNumberLabel = label;
    }
    return _peopleNumberLabel;
}



- (UILabel *)amountLabel{
    if (!_amountLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _amountLabel = label;
    }
    return _amountLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        _line = view;
    }
    return _line;
}

- (UILabel *)refundDescLabel{
    if (!_refundDescLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray42;
        label.font = FONT(14);
        label.text = @"退款金额：";
        [label sizeToFit];
        _refundDescLabel = label;
    }
    return _refundDescLabel;
}

- (UILabel *)refundLabel{
    if (!_refundLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(255, 40, 66);
        label.font = FONT(16);
        _refundLabel = label;
    }
    return _refundLabel;
}

@end
