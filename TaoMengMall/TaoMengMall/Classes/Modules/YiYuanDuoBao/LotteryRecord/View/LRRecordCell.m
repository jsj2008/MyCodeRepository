//
//  LRRecordCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/14.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LRRecordCell.h"
#import "LotteryRecordsItemModel.h"

@interface LRRecordCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *participantTimesLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation LRRecordCell
- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.iconView];
    [self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.numberLabel];
	[self cellAddSubView:self.participantTimesLabel];
	[self cellAddSubView:self.descLabel];
	[self cellAddSubView:self.line];
}

- (void)reloadData
{
	if (self.cellData) {
        
        LotteryRecordsItemModel *model = self.cellData;
        
        [self.iconView setOnlineImage:model.item.cover];
        self.iconView.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        
        self.titleLabel.text = model.item.name;
        self.titleLabel.width = SCREEN_WIDTH - self.iconView.width - 12 - 8 - 8;
        self.titleLabel.height = [model.item.name sizeWithUIFont:FONT(16) forWidth:self.titleLabel.width].height;
        self.titleLabel.left = self.iconView.right + 8;
        self.titleLabel.top = 12;
        
        self.numberLabel.text = [NSString stringWithFormat:@"期号：%@",model.activityId];
        [self.numberLabel sizeToFit];
        self.numberLabel.left = self.titleLabel.left;
        self.numberLabel.top = self.titleLabel.bottom + 12;
        
        NSString *pTimesStr = [NSString stringWithFormat:@"我已参与：%@人次",model.myAmount];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:pTimesStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(5, model.myAmount.length)];
        self.participantTimesLabel.attributedText = attributedStr;
        [self.participantTimesLabel sizeToFit];
        self.participantTimesLabel.left = self.numberLabel.left;
        self.participantTimesLabel.top = self.numberLabel.bottom;
        
        self.descLabel.right = SCREEN_WIDTH - 12;
        self.descLabel.bottom = self.participantTimesLabel.bottom;
        
        self.line.bottom = [[self class] heightForCell:self.cellData];
        
        
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        LotteryRecordsItemModel *model =  cellData;
		height = 65 + [model.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 44 - 12 - 8 - 8].height;
	}
    return height;
}

- (UIImageView *)iconView
{
	if (!_iconView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
		_iconView = imageView;
	}
	return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = FONT(16);
        label.textColor = Color_Gray42;
        label.numberOfLines = 0;

        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)numberLabel
{
	if (!_numberLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_numberLabel = label;
	}
	return _numberLabel;
}

- (UILabel *)participantTimesLabel
{
	if (!_participantTimesLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_participantTimesLabel = label;
	}
	return _participantTimesLabel;
}

- (UILabel *)descLabel
{
	if (!_descLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,60, 32)];
		label.font = FONT(14);
		label.textColor = Color_Gray153;
		label.text = @"查看详情";
		//[label sizeToFit];
        
        label.userInteractionEnabled = YES;
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            LotteryRecordsItemModel *model = self.cellData;
            [[TTNavigationService sharedService] openUrl:model.detailLink];
        }];
		_descLabel = label;
	}
	return _descLabel;
}

- (UIView *)line
{
	if (!_line) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, LINE_WIDTH)];
		view.backgroundColor = Color_Gray224;
        view.bottom = 80;
		_line = view;
	}
	return _line;
}



@end
