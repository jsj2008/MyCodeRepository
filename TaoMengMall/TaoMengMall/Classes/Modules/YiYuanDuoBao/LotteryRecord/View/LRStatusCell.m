//
//  LRStatusCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/14.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LRStatusCell.h"
#import "LotteryRecordsItemModel.h"

@interface LRStatusCell ()

@property (nonatomic, strong) UILabel *nameDescLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *participantTimesLabel;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIView *line;

@end

@implementation LRStatusCell
- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.nameDescLabel];
	[self cellAddSubView:self.nameLabel];
	[self cellAddSubView:self.participantTimesLabel];
	[self cellAddSubView:self.buyButton];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
	if (self.cellData) {
        LotteryRecordsItemModel *model = self.cellData;
        
        if (model.winner && model.winner.length > 0) {
            self.nameDescLabel.text = @"获奖者：";
            [self.nameDescLabel sizeToFit];
            self.nameDescLabel.left = 8;
            self.nameDescLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
            
            self.nameLabel.text = model.winner;
            [self.nameLabel sizeToFit];
            self.nameLabel.centerY = self.nameDescLabel.centerY;
            self.nameLabel.left = self.nameDescLabel.right;
            self.nameLabel.textColor = RGB(53, 117, 224);
            
            
            NSString *pTimesStr = [NSString stringWithFormat:@"%@人次",model.winnerAmount];
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:pTimesStr];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(0, model.winnerAmount.length)];
            self.participantTimesLabel.attributedText = attributedStr;
            [self.participantTimesLabel sizeToFit];
            self.participantTimesLabel.right = SCREEN_WIDTH - 8;
            self.participantTimesLabel.centerY = self.nameLabel.centerY;
            
            self.participantTimesLabel.hidden = NO;
            self.nameDescLabel.hidden = NO;
        }else if(model.refund){
            self.nameDescLabel.text = @"退款金额：";
            [self.nameDescLabel sizeToFit];
            self.nameDescLabel.left = 8;
            self.nameDescLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
            
            self.nameLabel.text = model.refund;
            [self.nameLabel sizeToFit];
            self.nameLabel.centerY = self.nameDescLabel.centerY;
            self.nameLabel.left = self.nameDescLabel.right;
            self.nameLabel.textColor = RGB(250, 40, 66);
        }else{
            self.participantTimesLabel.hidden = YES;
            self.nameDescLabel.hidden = YES;
        }
        
        self.buyButton.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        self.buyButton.right = SCREEN_WIDTH - 8;
        
        if(model.buttons && [model.buttons containsObject:@"buy"]){
            self.buyButton.hidden = NO;
        }else{
            self.buyButton.hidden = YES;
        }
        self.line.bottom = [[self class] heightForCell:self.cellData];
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 52;
	}
    return height;
}

- (UILabel *)nameDescLabel
{
	if (!_nameDescLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray153;
		label.text = @"获奖者：";
		[label sizeToFit];
		_nameDescLabel = label;
	}
	return _nameDescLabel;
}

- (UILabel *)nameLabel
{
	if (!_nameLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = RGB(53, 117, 224);
		_nameLabel = label;
	}
	return _nameLabel;
}

- (UILabel *)participantTimesLabel
{
	if (!_participantTimesLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray153;
		_participantTimesLabel = label;
	}
	return _participantTimesLabel;
}

- (UIButton *)buyButton
{
	if (!_buyButton) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 86, 33)];
		button.layer.cornerRadius = 3;
		button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        button.layer.borderColor = Color_Gray216.CGColor;
        button.layer.masksToBounds = YES;
		button.backgroundColor = Color_White;
		[button setTitleColor:Color_Gray153 forState:UIControlStateNormal];
		button.titleLabel.font = FONT(14);
		[button setTitle:@"再次购买" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(handleBuyButton:) forControlEvents:UIControlEventTouchUpInside];
		_buyButton = button;
	}
	return _buyButton;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        view.bottom = 35;
        _line = view;
    }
    return _line;
}

- (void)handleBuyButton:(UIButton*)button
{
    if([self.delegate respondsToSelector:@selector(handleBuyButttonWithModel:)]){
        [self.delegate handleBuyButttonWithModel:self.cellData];
    }
    
}
@end
