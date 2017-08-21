//
//  SearchTermLabel.m
//  YouCai
//
//  Created by marco on 5/28/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "SearchTermLabel.h"

@interface SearchTermLabel ()
@property (nonatomic, strong) UILabel *termLabel;
@property (nonatomic, strong) UIButton *clearButton;
@end

@implementation SearchTermLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = Color_Gray170;
        self.layer.cornerRadius = 8.f;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.termLabel];
        [self addSubview:self.clearButton];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.termLabel.centerY = self.height/2;
    self.termLabel.left = 8;
    
    self.clearButton.centerY = self.height/2;
    self.clearButton.right = self.width - 2;
    
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.termLabel.text = _text;
    [self.termLabel sizeToFit];
    [self resizeToFit];
}

- (void)resizeToFit
{
    CGSize fitSize = CGSizeZero;
    fitSize.width = 8 + self.termLabel.width + 2 + 12 + 2;
    fitSize.height = self.termLabel.height + 6;
    CGRect frame = self.frame;
    frame.size = fitSize;
    self.frame = frame;
}

//- (CGSize)sizeThatFits:(CGSize)size
//{
//    CGSize fitSize = CGSizeZero;
//    fitSize.width = 8 + self.termLabel.width + 2 + 12 + 2;
//    fitSize.height = self.termLabel.height + 6;
////    CGRect frame = self.frame;
////    frame.size = fitSize;
////    self.frame = frame;
//    return size;
//}

#pragma mark - Subviews
- (UILabel*)termLabel
{
    if (!_termLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(14);
        _termLabel = label;
    }
    return _termLabel;
}

- (UIButton*)clearButton
{
    if (!_clearButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        [button setBackgroundImage:[UIImage imageNamed:@"tag_delete"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        _clearButton = button;
    }
    return _clearButton;
}

@end
