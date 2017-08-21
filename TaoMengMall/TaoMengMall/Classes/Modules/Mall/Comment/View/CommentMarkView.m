//
//  CommentRateView.m
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CommentMarkView.h"

@interface CommentMarkView ()
@property (nonatomic, strong) NSMutableArray<UIButton*> *starViews;
@property (nonatomic, strong) UIImageView *markBkg;
@property (nonatomic, strong) UILabel *markLabel;
@end

@implementation CommentMarkView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _mark = 0.f;
        _showMark = YES;
        //self.backgroundColor = Color_Gray66;
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
                [button setImage:[UIImage imageNamed:@"star_all"] forState:UIControlStateNormal];
                //button.selected = YES;
            }else{
                float distance = button.tag - mark;
                if (distance > 0.6) {
                    [button setImage:[UIImage imageNamed:@"star_none"] forState:UIControlStateNormal];
                }else{
                    [button setImage:[UIImage imageNamed:@"star_half"] forState:UIControlStateNormal];
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

- (void)render
{
    for (UIButton *button in self.starViews) {
        [self addSubview:button];
    }
    [self addSubview:self.markLabel];
    self.markLabel.hidden = !self.showMark;
    self.markLabel.centerY = self.height/2;
    self.markLabel.left = (15+5) * 5;
}

- (NSArray *)starViews
{
    if (!_starViews) {
        NSMutableArray *stars = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*(15 + 5), 2, 15, 15)];
            button.tag = i+1;
            //[button setImage:[UIImage imageNamed:@"star_normal"] forState:UIControlStateNormal];
            //[button setImage:[UIImage imageNamed:@"star_selected"] forState:UIControlStateSelected];
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
        label.font = FONT(14);
        label.textColor = Color_Gray92;
        label.text = @"5.00";
        [label sizeToFit];
        _markLabel = label;
    }
    return _markLabel;
}

@end
