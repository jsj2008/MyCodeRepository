//
//  LotteryItemCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckyItemCell.h"
#import "LuckyRecordItemModel.h"

@interface LuckyItemCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *peopleNumberLabel;
@property (nonatomic, strong) UILabel *luckyNumberLable;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *line;


@end

@implementation LuckyItemCell

- (void)drawCell{
    self.backgroundColor = Color_White;
    
    [self cellAddSubView:self.iconView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.peopleNumberLabel];
    [self cellAddSubView:self.luckyNumberLable];
    [self cellAddSubView:self.amountLabel];
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.line];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        LuckyRecordItemModel *model = cellData;
        height = 100 + [model.title sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 16 - 70 - 12].height;
    }
    return height;
}


- (void)reloadData{
    if (self.cellData) {
        LuckyRecordItemModel *model = self.cellData;
        
        [self.iconView setOnlineImage:model.img];
        
        self.titleLabel.text = model.title;
        self.titleLabel.width = SCREEN_WIDTH - 16 - 70 - 12;
        self.titleLabel.height = [model.title sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 16 - 70 - 12].height;
        self.titleLabel.top = 8;
        self.titleLabel.left = self.iconView.right + 8;
        
        self.peopleNumberLabel.text = [NSString stringWithFormat:@"总需：%@人次",model.required];
        [self.peopleNumberLabel sizeToFit];
        self.peopleNumberLabel.top = self.titleLabel.bottom + 4;
        self.peopleNumberLabel.left = self.titleLabel.left;

        
        NSString *npTimesStr = [NSString stringWithFormat:@"幸运号码：%@",model.number];;
        NSMutableAttributedString *nattributedStr = [[NSMutableAttributedString alloc] initWithString:npTimesStr];
        [nattributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(5, model.number.length)];
        self.luckyNumberLable.attributedText = nattributedStr;
        [self.luckyNumberLable sizeToFit];
        self.luckyNumberLable.top = self.peopleNumberLabel.bottom + 8;
        self.luckyNumberLable.left = self.titleLabel.left;
        
        
        NSString *timesStr = [NSString stringWithFormat:@"本期参与：%@人次",model.times];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:timesStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(5, model.times.length)];
        self.amountLabel.attributedText = attributedStr;
        [self.amountLabel sizeToFit];
        self.amountLabel.top = self.luckyNumberLable.bottom + 2;
        self.amountLabel.left = self.luckyNumberLable.left;
        
        self.timeLabel.text = [NSString stringWithFormat:@"揭晓时间：%@",model.date];
        [self.timeLabel sizeToFit];
        self.timeLabel.top = self.amountLabel.bottom + 2;
        self.timeLabel.left = self.amountLabel.left;
        
        self.line.bottom = [[self class] heightForCell:self.cellData];
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

- (UILabel *)luckyNumberLable{
    if (!_luckyNumberLable) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _luckyNumberLable = label;
    }
    return _luckyNumberLable;
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

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _timeLabel = label;
    }
    return _timeLabel;
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

@end
