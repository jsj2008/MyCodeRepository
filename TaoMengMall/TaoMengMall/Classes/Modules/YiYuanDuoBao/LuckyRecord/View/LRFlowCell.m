//
//  LLRFlowCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LRFlowCell.h"
#import "LRDetailExpressModel.h"

@interface LRFlowCell ()

@property (nonatomic, strong) UIImageView *flowImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *receiveButton;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *circleView;

@end

@implementation LRFlowCell

- (void)drawCell{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.flowImageView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.receiveButton];
    [self cellAddSubView:self.line];
    [self cellAddSubView:self.line1];
    [self cellAddSubView:self.circleView];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 50;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        LRDetailExpressModel *model = self.cellData;
        self.titleLabel.text = model.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.left = self.flowImageView.right;
        self.titleLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        
        
        self.timeLabel.text = model.desc;
        [self.timeLabel sizeToFit];
        self.timeLabel.right = SCREEN_WIDTH - 12;
        self.timeLabel.centerY = self.titleLabel.centerY;
        
        if ([model.buttons containsObject:@"receive"]) {
            self.receiveButton.hidden = NO;
        }else{
            self.receiveButton.hidden = YES;
        }
        self.circleView.centerX = 20;
        self.circleView.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        if (self.isBegin) {
            self.line1.height = [[self class] heightForCell:self.cellData] / 2.0f;
            self.line1.top = [[self class] heightForCell:self.cellData] / 2.0f;
            self.circleView.backgroundColor  = Color_Gray204;
            self.titleLabel.textColor = Color_Gray42;
            self.timeLabel.textColor = Color_Gray153;
            self.line.left = 30;
        }else if (self.isEnd){
            self.line1.height = [[self class] heightForCell:self.cellData] / 2.0f;
            self.line1.bottom = [[self class] heightForCell:self.cellData] / 2.0f;
            self.circleView.backgroundColor = RGB(255, 40, 66);
            self.titleLabel.textColor = RGB(255, 40, 66);
            self.timeLabel.textColor = RGB(255, 40, 66);
            self.line.left = 0;
        }else{
            self.line1.height = [[self class] heightForCell:self.cellData];
            self.circleView.backgroundColor  = Color_Gray204;
            self.titleLabel.textColor = Color_Gray42;
            self.timeLabel.textColor = Color_Gray153;
            self.line.left = 30;
        }
    }
}

#pragma mark - getters

- (UIImageView *)flowImageView{
    if (!_flowImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = imageView.height = 50;
        imageView.top = imageView.height = 0;
        _flowImageView = imageView;
    }
    return _flowImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray42;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray153;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        view.bottom = 50;
        _line = view;
    }
    return _line;
}

- (UIButton *)receiveButton{
    if (!_receiveButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = 73;
        button.height = 28;
        button.centerY = 25;
        button.right = SCREEN_WIDTH - 12;
        [button setTitle:@"确认收货" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        button.backgroundColor = RGB(255, 40, 66);
        [button setTitleColor:Color_White forState:UIControlStateNormal];
        [button bk_whenTapped:^{
            weakify(self);
            if ([self.delegate respondsToSelector:@selector(handleRecieveButton)]) {
                strongify(self);
                [self.delegate handleRecieveButton];
            }
        }];
        _receiveButton = button;
    }
    return _receiveButton;
}

- (UIView *)circleView{
    if (!_circleView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        view.backgroundColor = Color_Gray204;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        _circleView = view;
    }
    return _circleView;
}

- (UIView*)line1
{
    if (!_line1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LINE_WIDTH, 50)];
        view.backgroundColor = Color_Gray224;
        view.left = 20;
        _line1 = view;
    }
    return _line1;
}


@end
