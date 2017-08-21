//
//  ITMarkView.m
//  FlyLantern
//
//  Created by marco on 12/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ITMarkView.h"

@interface ITMarkView ()

@property (nonatomic, strong) NSMutableArray<UIButton*> *starViews;
@property (nonatomic, strong) UIImageView *markBkg;
@property (nonatomic, strong) UILabel *markLabel;

@end

@implementation ITMarkView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _mark = 0.f;
        _showMark = YES;
        _markWidth = 15;
        _labelFont = 12;
        [self render];
    }
    return self;
}

- (void)setMark:(CGFloat)mark
{
    if (_mark != mark) {
        _mark = mark;
        for (UIButton *button in self.starViews) {
            if (button.tag <= mark) {
                [button setBackgroundImage:[UIImage imageNamed:@"star_all"] forState:UIControlStateNormal];
                //button.selected = YES;
            }else{
                float distance = button.tag - mark;
                if (distance > 0.6) {
                    [button setBackgroundImage:[UIImage imageNamed:@"star_none"] forState:UIControlStateNormal];
                }else{
                    [button setBackgroundImage:[UIImage imageNamed:@"star_half"] forState:UIControlStateNormal];
                }
                //button.selected = NO;
            }
        }
        self.markLabel.text = [NSString stringWithFormat:@"%.1f",mark];
        [self.markLabel sizeToFit];
    }
}

- (void)setShowMark:(BOOL)showMark
{
    _showMark = showMark;
    self.markLabel.hidden = !showMark;
}

- (void)setMarkWidth:(CGFloat)markWidth
{
    _markWidth = markWidth;
    for (int i = 0; i < 5; i++) {
        UIButton *button = [self.starViews safeObjectAtIndex:i];
        button.frame = CGRectMake(i*(self.markWidth + 5), 2, self.markWidth, self.markWidth);
    }
    self.markLabel.centerY = (2+_markWidth+2)/2;
    self.markLabel.left = (_markWidth+5) * 5;
}

- (void)setLabelFont:(CGFloat)labelFont
{
    _labelFont = labelFont;
    self.markLabel.font = FONT(labelFont);
    [self.markLabel sizeToFit];
    self.markLabel.centerY = (2+_markWidth+2)/2;
}

- (void)render
{
    for (UIButton *button in self.starViews) {
        [self addSubview:button];
    }
    [self addSubview:self.markLabel];
    self.markLabel.hidden = !self.showMark;
    self.markLabel.centerY = self.height/2;
    self.markLabel.left = (self.markWidth+5) * 5;
}

- (NSArray *)starViews
{
    if (!_starViews) {
        NSMutableArray *stars = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*(self.markWidth + 5), 2, self.markWidth, self.markWidth)];
            button.tag = i+1;
            [button setBackgroundImage:[UIImage imageNamed:@"star_none"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(starButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [stars addObject:button];
        }
        _starViews = stars;
    }
    return _starViews;
}

- (UILabel*)markLabel
{
    if (!_markLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 20, 14)];
        label.font = FONT(self.labelFont);
        label.textColor = RGB(254, 187, 20);
        label.text = @"0.0";
        [label sizeToFit];
        _markLabel = label;
    }
    return _markLabel;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize trueSize = size;
    trueSize.height = 4 + self.markWidth;
    trueSize.width = (self.markWidth+5) * 5 + (self.showMark?[self.markLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)].width:0);
    return trueSize;
}

#pragma mark - 
- (void)starButtonTapped:(UIButton*)button
{
    NSInteger tag = button.tag;
    self.mark = tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(rateViewValueChanged:)]) {
        [self.delegate rateViewValueChanged:self];
    }
}
@end
