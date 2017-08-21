//
//  LotteryRecordCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckyRecordCell.h"
#import "LuckyHistoryItemModel.h"

@interface LuckyRecordCell ()

@property (nonatomic, strong) UIView *bagView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bag2View;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nameValueLabel;
@property (nonatomic, strong) UILabel *IDLabel;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *luckNumberLabel;
@property (nonatomic, strong) UILabel *luckNumberValueLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@end

@implementation LuckyRecordCell


- (void)drawCell{
    [self cellAddSubView:self.bagView];
    [self.bagView addSubview:self.titleLabel];
    [self.bagView addSubview:self.bag2View];
    [self.bag2View addSubview:self.iconView];
    [self.bag2View addSubview:self.nameLabel];
    [self.bag2View addSubview:self.nameValueLabel];
    [self.bag2View addSubview:self.IDLabel];
    [self.bag2View addSubview:self.placeLabel];
    [self.bag2View addSubview:self.luckNumberValueLabel];
    [self.bag2View addSubview:self.luckNumberLabel];
    [self.bag2View addSubview:self.amountLabel];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 140;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        LuckyHistoryItemModel *model = self.cellData;
        self.titleLabel.text = [NSString stringWithFormat:@"期号：%@（揭晓时间：%@）",model.head.activityId,model.head.announceTime];
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 8;
        self.titleLabel.centerY = 25 / 2.0f;
        
        [self.iconView setOnlineImage:model.content.avatar];
        self.iconView.left = self.iconView.top = 8;
        
        self.nameLabel.text = @"获奖者：";
        [self.nameLabel sizeToFit];
        self.nameLabel.left = self.iconView.right + 8;
        self.nameLabel.top = 8;
        
        self.nameValueLabel.text = model.content.uname;
        [self.nameValueLabel sizeToFit];
        self.nameValueLabel.centerY = self.nameLabel.centerY;
        self.nameValueLabel.left = self.nameLabel.right;
        
        self.placeLabel.text = [NSString stringWithFormat:@"（%@）",model.content.city];
        [self.placeLabel sizeToFit];
        self.placeLabel.left = self.nameValueLabel.left;
        self.placeLabel.top = self.titleLabel.bottom + 2;
        
        self.IDLabel.text = [NSString stringWithFormat:@"用户ID：%@",model.content.userId];
        [self.IDLabel sizeToFit];
        self.IDLabel.left = self.nameLabel.left;
        self.IDLabel.top = self.placeLabel.bottom + 2;
        
        self.luckNumberLabel.text = @"幸运号码：";
        [self.luckNumberLabel sizeToFit];
        self.luckNumberLabel.left = self.IDLabel.left;
        self.luckNumberLabel.top = self.IDLabel.bottom + 2;
        
        
        self.luckNumberValueLabel.text = model.content.luckyNumber;
        [self.luckNumberValueLabel sizeToFit];
        self.luckNumberValueLabel.centerY = self.luckNumberLabel.centerY;
        self.luckNumberValueLabel.left = self.luckNumberLabel.right;
        
        NSString *npTimesStr = [NSString stringWithFormat:@"本期参与：%@人次",model.content.currentThreshold];
        NSMutableAttributedString *nattributedStr = [[NSMutableAttributedString alloc] initWithString:npTimesStr];
        [nattributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(5, model.content.currentThreshold.length)];
        self.amountLabel.attributedText = nattributedStr;
        [self.amountLabel sizeToFit];
        self.amountLabel.left = self.luckNumberLabel.left;
        self.amountLabel.top = self.luckNumberLabel.bottom + 2;
    }
}

#pragma mark - getters
- (UIView *)bagView{
    if (!_bagView) {
        UIView *view = [[UIView alloc] init];
        view.width = SCREEN_WIDTH - 24;
        view.height = 140 - 8;
        view.left = 12;
        view.top = 8;
        view.backgroundColor = Color_Gray224;
        _bagView = view;
    }
    return _bagView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray42;
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)bag2View{
    if (!_bag2View) {
        UIView *view = [[UIView alloc] init];
        view.width = self.bagView.width - 2;
        view.height = self.bagView.height - 27;
        view.top = 25;
        view.left = 1;
        view.backgroundColor = Color_White;
        _bag2View = view;
    }
    return _bag2View;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = imageView.height = 45;
        imageView.layer.cornerRadius = 45 / 2.0f;
        imageView.layer.masksToBounds = YES;
        _iconView = imageView;
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)nameValueLabel{
    if (!_nameValueLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(81, 143, 229);
        label.font = FONT(14);
        _nameValueLabel = label;
    }
    return _nameValueLabel;
}

- (UILabel *)placeLabel{
    if (!_placeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(235, 84, 96);
        label.font = FONT(14);
        _placeLabel = label;
    }
    return _placeLabel;
}

- (UILabel *)IDLabel{
    if (!_IDLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _IDLabel = label;
    }
    return _IDLabel;
}
- (UILabel *)luckNumberLabel{
    if (!_luckNumberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _luckNumberLabel = label;
    }
    return _luckNumberLabel;
}

- (UILabel *)luckNumberValueLabel{
    if (!_luckNumberValueLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(235, 84, 94);
        label.font = FONT(14);
        _luckNumberValueLabel = label;
    }
    return _luckNumberValueLabel;
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


@end
