//
//  DSRCell.m
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CommentDSRCell.h"
#import "CommentMarkView.h"
#import "CommentDSRModel.h"
#import "CommentDSRItemModel.h"

@interface CommentDSRCell ()

@property (nonatomic, strong) UILabel *qbLabel;
@property (nonatomic, strong) UILabel *qbVLabel;
@property (nonatomic, strong) CommentMarkView *qbStarView;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *msLabel;
@property (nonatomic, strong) CommentMarkView *msStarView;

@property (nonatomic, strong) UILabel *zlLabel;
@property (nonatomic, strong) CommentMarkView *zlStarView;

@property (nonatomic, strong) UILabel *jgLabel;
@property (nonatomic, strong) CommentMarkView *jgStarView;

@end

@implementation CommentDSRCell

- (void)drawCell
{
    [self addSubview:self.qbLabel];
    [self addSubview:self.qbVLabel];
    [self addSubview:self.qbStarView];
    
    [self addSubview:self.line];
    
    [self addSubview:self.msLabel];
    [self addSubview:self.msStarView];
    
    [self addSubview:self.zlLabel];
    [self addSubview:self.zlStarView];
    
    [self addSubview:self.jgLabel];
    [self addSubview:self.jgStarView];

}

- (void)reloadData
{
    if (self.cellData) {
        CommentDSRModel *model = (CommentDSRModel*)self.cellData;
        
        CommentDSRItemModel *qb = model.qb;
        self.qbLabel.text = qb.title;
        [self.qbLabel sizeToFit];
        self.qbVLabel.text = qb.v;
        [self.qbVLabel sizeToFit];
        self.qbStarView.mark = [qb.v floatValue];
        
        CommentDSRItemModel *ms = model.ms;
        self.msLabel.text = ms.title;
        [self.msLabel sizeToFit];
        self.msStarView.mark = [ms.v floatValue];
        
        CommentDSRItemModel *jg = model.jg;
        self.jgLabel.text = jg.title;
        [self.jgLabel sizeToFit];
        self.jgStarView.mark = [jg.v floatValue];
        
        CommentDSRItemModel *zl = model.zl;
        self.zlLabel.text = zl.title;
        [self.zlLabel sizeToFit];
        self.zlStarView.mark = [zl.v floatValue];
        
        self.qbStarView.right = self.line.left - 16;
        self.qbStarView.bottom = [[self class] heightForCell:self.cellData] - 12;
        self.qbLabel.top = 20;
        self.qbLabel.centerX = self.qbStarView.centerX;
        self.qbVLabel.top = self.qbLabel.bottom + 4;
        self.qbVLabel.centerX = self.qbLabel.centerX;
        
        self.msLabel.left = self.line.right + 16;
        self.msLabel.top = 15;
        self.jgLabel.left = self.line.right + 16;
        self.jgLabel.top = self.msLabel.bottom + 8;
        self.zlLabel.left = self.line.right + 16;
        self.zlLabel.top = self.jgLabel.bottom + 8;
        
        self.msStarView.left = self.msLabel.right + 12;
        self.msStarView.centerY = self.msLabel.centerY;
        self.jgStarView.left = self.msStarView.left;
        self.jgStarView.centerY = self.jgLabel.centerY;
        self.zlStarView.left = self.msStarView.left;
        self.zlStarView.centerY = self.zlLabel.centerY;


    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 100;
    }
    return height;
}

#pragma mark - subviews

- (UILabel*)qbLabel
{
    if (!_qbLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"综合评分";
        [label sizeToFit];
        _qbLabel = label;
    }
    return _qbLabel;
}

- (UILabel*)qbVLabel
{
    if (!_qbVLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(19);
        label.text = @"0.0";
        [label sizeToFit];
        label.textColor = Color_Gray92;
        _qbVLabel = label;
    }
    return _qbVLabel;
}

- (CommentMarkView*)qbStarView
{
    if (!_qbStarView) {
        CommentMarkView *markView = [[CommentMarkView alloc]initWithFrame:CGRectMake(40, 0, 100, 20)];
        markView.showMark = NO;
        _qbStarView = markView;
    }
    return _qbStarView;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.8, 12,LINE_WIDTH, 76)];
        view.backgroundColor = Color_Gray224;
        _line = view;
    }
    return _line;
}

- (UILabel*)msLabel
{
    if (!_msLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"描述相符";
        [label sizeToFit];
        _msLabel = label;
    }
    return _msLabel;
}

- (CommentMarkView*)msStarView
{
    if (!_msStarView) {
        CommentMarkView *markView = [[CommentMarkView alloc]initWithFrame:CGRectMake(0, 0, 130, 20)];
        _msStarView = markView;
    }
    return _msStarView;
}

- (UILabel*)zlLabel
{
    if (!_zlLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"质量满意";
        [label sizeToFit];
        _zlLabel = label;
    }
    return _zlLabel;
}


- (CommentMarkView*)zlStarView
{
    if (!_zlStarView) {
        CommentMarkView *markView = [[CommentMarkView alloc]initWithFrame:CGRectMake(0, 0, 130, 20)];
        _zlStarView = markView;
    }
    return _zlStarView;
}

- (UILabel*)jgLabel
{
    if (!_jgLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"价格合理";
        _jgLabel = label;
    }
    return _jgLabel;
}


- (CommentMarkView*)jgStarView
{
    if (!_jgStarView) {
        CommentMarkView *markView = [[CommentMarkView alloc]initWithFrame:CGRectMake(0, 0, 130, 20)];
        _jgStarView = markView;
    }
    return _jgStarView;
}
@end
