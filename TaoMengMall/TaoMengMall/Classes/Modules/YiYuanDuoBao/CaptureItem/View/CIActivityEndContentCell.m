//
//  ItemActivityEndContentCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIActivityEndContentCell.h"
#import "CIItemResultModel.h"

@interface CIActivityEndContentCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *bg2View;
@property (nonatomic, strong) UILabel *luckyNumberLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *IDLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *joinNumberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *joinNumber2Label;
@property (nonatomic, strong) UILabel *captureLabel;
@property (nonatomic, strong) UIImageView *logoImageView;
@end

@implementation CIActivityEndContentCell
- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.bgView];
	[self cellAddSubView:self.bg2View];
	[self cellAddSubView:self.luckyNumberLabel];
	[self.bgView addSubview :self.iconView];
	[self.bgView addSubview :self.nameLabel];
    [self.bgView addSubview:self.numberLabel];
    [self.bgView addSubview:self.logoImageView];
    [self.bgView addSubview :self.placeLabel];
	[self.bgView addSubview :self.IDLabel];
	[self.bgView addSubview :self.joinNumberLabel];
	[self.bgView addSubview :self.timeLabel];
	[self.bg2View addSubview:self.joinNumber2Label];
	[self.bg2View addSubview:self.captureLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        
        CIItemResultModel * model = self.cellData;
        CIWinnerModel *winnerModel = [model.activity.winners safeObjectAtIndex:0];
        
        self.titleLabel.text = model.item.name;
        self.titleLabel.width = SCREEN_WIDTH - 24;
        self.titleLabel.height = [model.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 24].height;
        self.titleLabel.top = 12;
        self.titleLabel.left = 8;
        
        self.bgView.top = self.titleLabel.bottom + 12;
        
        [self.iconView setOnlineImage:winnerModel.avatar];
        
        self.nameLabel.text = [NSString stringWithFormat:@"获奖者：%@",winnerModel.userName];
        [self.nameLabel sizeToFit];
        self.nameLabel.left = self.iconView.right + 8;
        self.nameLabel.top = self.iconView.top + 2;
        
        self.placeLabel.text = [NSString stringWithFormat:@"(%@)",winnerModel.city];
        [self.placeLabel sizeToFit];
        self.placeLabel.left = self.nameLabel.left;
        self.placeLabel.top = self.nameLabel.bottom;
        
        self.IDLabel.text = [NSString stringWithFormat:@"用户ID:%@",winnerModel.userId];
        [self.IDLabel sizeToFit];
        self.IDLabel.top = self.placeLabel.bottom;
        self.IDLabel.left = self.nameLabel.left;
        
        self.numberLabel.text = [NSString stringWithFormat:@"期号：%@",model.activity.number];
        [self.numberLabel sizeToFit];
        self.numberLabel.top = self.IDLabel.bottom;
        self.numberLabel.left = self.nameLabel.left;
        
        NSString *pTimesStr = [NSString stringWithFormat:@"本期参与：%@人次",winnerModel.participantTimes];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:pTimesStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(5, winnerModel.participantTimes.length)];
        self.joinNumberLabel.attributedText = attributedStr;
        [self.joinNumberLabel sizeToFit];
        self.joinNumberLabel.top = self.numberLabel.bottom;
        self.joinNumberLabel.left = self.nameLabel.left;
        
        
        self.timeLabel.text = [NSString stringWithFormat:@"揭晓时间：%@", winnerModel.announceTime];
        [self.timeLabel sizeToFit];
        self.timeLabel.top = self.joinNumberLabel.bottom;
        self.timeLabel.left = self.nameLabel.left;
        
        NSString *numberStr = [NSString stringWithFormat:@"    幸运号码：%@",winnerModel.luckNumber];
        NSMutableAttributedString *numberAttributedStr = [[NSMutableAttributedString alloc] initWithString:numberStr];
        [numberAttributedStr addAttribute:NSFontAttributeName value:FONT(18) range:NSMakeRange(9, winnerModel.luckNumber.length)];
        self.luckyNumberLabel.attributedText = numberAttributedStr;
        self.luckyNumberLabel.top = self.bgView.bottom;
        
        self.bg2View.top = self.luckyNumberLabel.bottom + 8;
        
        NSString *npTimesStr = [NSString stringWithFormat:@"您参与了：%@人次",model.participant.participantTimes];
        NSMutableAttributedString *nattributedStr = [[NSMutableAttributedString alloc] initWithString:npTimesStr];
        [nattributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(5, model.participant.participantTimes.length)];
        self.joinNumber2Label.attributedText = nattributedStr;
        [self.joinNumber2Label sizeToFit];
        self.joinNumber2Label.left = 8;
        self.joinNumber2Label.top = 10;
        
        self.captureLabel.text = [NSString stringWithFormat:@"夺宝号码：%@",model.participant.captureNumber];
        self.captureLabel.width = SCREEN_WIDTH - 32;
        self.captureLabel.height = [self.captureLabel.text sizeWithUIFont:FONT(12) forWidth:SCREEN_WIDTH - 32].height;
        self.captureLabel.left = 8;
        self.captureLabel.top = 32 + 8;
        
        self.bg2View.height = self.captureLabel.bottom + 10;
        //[self.captureLabel sizeToFit];
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        CIItemResultModel * model = cellData;
		height = 238 + [model.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 24].height;
        NSString *capture = [NSString stringWithFormat:@"夺宝号码：%@",model.participant.captureNumber];
        height = height + [capture sizeWithUIFont:FONT(12) forWidth:SCREEN_WIDTH - 32].height;

	}
    return height;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray42;
        label.numberOfLines = 0;
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UIView *)bgView
{
	if (!_bgView) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 110)];
		view.backgroundColor = RGB(250, 242, 241);
		_bgView = view;
	}
	return _bgView;
}

- (UIView *)bg2View
{
	if (!_bg2View) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 64)];
        view.backgroundColor = Color_Gray238;
        _bg2View = view;
    }
	return _bg2View;
}

- (UILabel *)luckyNumberLabel
{
	if (!_luckyNumberLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 36)];
		label.font = FONT(12);
		label.textColor = Color_White;
        label.backgroundColor = RGB(236, 66, 74);
		_luckyNumberLabel = label;
	}
	return _luckyNumberLabel;
}

- (UIImageView *)iconView
{
	if (!_iconView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
		imageView.layer.cornerRadius = 22;
		imageView.layer.masksToBounds = YES;
        imageView.left = 12;
        imageView.top = 12;
		_iconView = imageView;
	}
	return _iconView;
}

- (UILabel *)nameLabel
{
	if (!_nameLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_nameLabel = label;
	}
	return _nameLabel;
}

- (UILabel *)placeLabel
{
	if (!_placeLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = RGB(235, 84, 96);
		_placeLabel = label;
	}
	return _placeLabel;
}

- (UILabel *)IDLabel
{
	if (!_IDLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_IDLabel = label;
	}
	return _IDLabel;
}
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray153;
        _numberLabel = label;
    }
    return _numberLabel;
}

- (UILabel *)joinNumberLabel
{
	if (!_joinNumberLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_joinNumberLabel = label;
	}
	return _joinNumberLabel;
}

- (UILabel *)timeLabel
{
	if (!_timeLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_timeLabel = label;
	}
	return _timeLabel;
}

- (UILabel *)joinNumber2Label
{
	if (!_joinNumber2Label) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_joinNumber2Label = label;
	}
	return _joinNumber2Label;
}

- (UILabel *)captureLabel
{
	if (!_captureLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
        label.numberOfLines = 0;
		_captureLabel = label;
	}
	return _captureLabel;
}

- (UIImageView*)logoImageView
{
    if (!_logoImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 23, 28)];
        imageView.image = [UIImage imageNamed:@"capture_winner_badge"];
        imageView.right = self.bgView.width - 12;
        imageView.top = 8;
        _logoImageView = imageView;
    }
    return _logoImageView;
}
@end
