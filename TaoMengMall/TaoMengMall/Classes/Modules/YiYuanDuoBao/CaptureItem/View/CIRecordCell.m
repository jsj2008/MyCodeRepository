//
//  ItemRecordCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIRecordCell.h"
#import "CIRecordItemModel.h"

@interface CIRecordCell ()

@property (nonatomic, strong) UILabel *timeHeaderLabel;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ipLabel;
@property (nonatomic, strong) UILabel *joinLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation CIRecordCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.timeHeaderLabel];
	[self cellAddSubView:self.line1];
	[self cellAddSubView:self.line2];
	[self cellAddSubView:self.line3];
	[self cellAddSubView:self.avatarImageView];
	[self cellAddSubView:self.nameLabel];
	[self cellAddSubView:self.ipLabel];
	[self cellAddSubView:self.joinLabel];
	[self cellAddSubView:self.timeLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        
        CIRecordItemModel *model = self.cellData;
        if (model.head) {
            self.line1.top = 0;
            self.line1.left = 30;
            
            self.timeHeaderLabel.text = model.head;
            self.timeHeaderLabel.left = 8;
            self.timeHeaderLabel.top = self.line1.bottom;
            
            self.line2.top = self.timeHeaderLabel.bottom;
            self.line2.left = self.line1.left;
            
            [self.avatarImageView setOnlineImage:model.content.avatar];
            self.avatarImageView.centerX = 30;
            self.avatarImageView.top = self.line2.bottom;
            
            self.line3.top = self.avatarImageView.bottom;
            self.line3.left = self.line2.left;
            self.timeHeaderLabel.hidden = NO;
            self.line1.hidden = NO;
            self.line2.hidden = NO;
        }else{
            [self.avatarImageView setOnlineImage:model.content.avatar];
            self.avatarImageView.centerX = 30;
            self.avatarImageView.top = 0;
            self.line3.top = self.avatarImageView.bottom;
            self.line3.left = 30;
            self.line1.hidden = YES;
            self.line2.hidden = YES;
            self.timeHeaderLabel.hidden = YES;
        }
        
        self.nameLabel.text = model.content.name;
        [self.nameLabel sizeToFit];
        self.nameLabel.top = self.avatarImageView.top + 2;
        self.nameLabel.left = self.avatarImageView.right + 8;
        
        self.ipLabel.text = model.content.ip;
        [self.ipLabel sizeToFit];
        self.ipLabel.left = self.nameLabel.left;
        self.ipLabel.top = self.nameLabel.bottom + 4;
        
        self.joinLabel.text = [NSString stringWithFormat:@"参与了%@人次",model.content.number];
        [self.joinLabel sizeToFit];
        self.joinLabel.left = self.ipLabel.left;
        self.joinLabel.top = self.ipLabel.bottom + 4;
        
        self.timeLabel.text = model.content.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.left = self.joinLabel.right;
        self.timeLabel.centerY = self.joinLabel.centerY;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
    CIRecordItemModel *model = cellData;
	CGFloat height = 0;
	if (model.head) {
		height = 109;
    }else{
        height = 60;
    }
    return height;
}

- (UILabel *)timeHeaderLabel
{
	if (!_timeHeaderLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, self.line1.bottom, 80, 25)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
        label.backgroundColor = Color_Gray245;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 12.5f;
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = 1;
        label.layer.borderColor = Color_Gray216.CGColor;
		_timeHeaderLabel = label;
	}
	return _timeHeaderLabel;
}

- (UIView *)line1
{
	if (!_line1) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(24, 0, LINE_WIDTH, 8)];
		view.backgroundColor = Color_Gray224;
		_line1 = view;
	}
	return _line1;
}

- (UIView *)line2
{
	if (!_line2) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(24, self.timeLabel.bottom, LINE_WIDTH, 16)];
		view.backgroundColor = Color_Gray224;
		_line2 = view;
	}
	return _line2;
}

- (UIView *)line3
{
	if (!_line3) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(24, 0, LINE_WIDTH, 16)];
		view.backgroundColor = Color_Gray224;
		_line3 = view;
	}
	return _line3;
}

- (UIImageView *)avatarImageView
{
	if (!_avatarImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
		imageView.layer.cornerRadius = 22;
		imageView.layer.masksToBounds = YES;
        imageView.top = self.line2.bottom;
		_avatarImageView = imageView;
	}
	return _avatarImageView;
}

- (UILabel *)nameLabel
{
	if (!_nameLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = RGB(67, 127, 226);
		_nameLabel = label;
	}
	return _nameLabel;
}

- (UILabel *)ipLabel
{
	if (!_ipLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_ipLabel = label;
	}
	return _ipLabel;
}

- (UILabel *)joinLabel
{
	if (!_joinLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray42;
		_joinLabel = label;
	}
	return _joinLabel;
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



@end
