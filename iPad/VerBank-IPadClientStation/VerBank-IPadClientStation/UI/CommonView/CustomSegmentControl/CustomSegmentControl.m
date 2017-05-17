//
//  CustomSegmentContrl.m
//  ScrollView
//
//  Created by Allone on 16/3/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CustomSegmentControl.h"
#import "UIImage+CustomButton.h"
#import "UIColor+CustomColor.h"

typedef NS_ENUM(NSInteger, ButtonDirect) {
    LEFT    = 0,
    MIDDLE  = 1,
    RIGHT   = 2,
    UNKOWN  = -1
};

const static NSUInteger defaultSelectIndex = 0;
const static CGFloat defaultCornerRadius = 8.0f;
const static CGFloat defaultCornerWidth = 1.0f;
const static CGFloat defaultButtonMiddleAdge = 2.0f;

@interface CustomSegmentControl() {
    id<CustomSegmentProtocol>_delegate;
    
    NSUInteger _currentSelectIndex;
    
    NSArray *_buttonTitleArray;
    NSMutableArray * _contentButtonArray;
    
    UIImage *_middleNormalImage;
    UIImage *_middleSelectImage;
    
    UIImage *_leftSelectImage;
    UIImage *_leftNormalImage;
    
    UIImage *_rightSelectImage;
    UIImage *_rightNormalImage;
    
    CGSize _buttonSize;
    CGFloat _cornerRadius;
    CGFloat _cornerWidth;
    CGFloat _buttonMiddleAdge;
}

@end

@implementation CustomSegmentControl

@synthesize currentSelectIndex = _currentSelectIndex;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setDefault];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDefault];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self setDefault];
    }
    return self;
}

- (void)initContentButton {
    if (_contentButtonArray != nil) {
        for (UIView *view in _contentButtonArray) {
            [view removeFromSuperview];
        }
        [_contentButtonArray removeAllObjects];
    } else {
        _contentButtonArray = [[NSMutableArray alloc] init];
    }
    
    for (int i = 0; i < _buttonTitleArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentButtonArray addObject:button];
        [button setBackgroundColor:[UIColor blackColor]];
        [self setButton:button selected:false index:i];
        [self addSubview:button];
    }
    
    [self setCurrentSelectIndex:defaultSelectIndex];
}

- (void)initContentButtonImage {
    _middleNormalImage = [self getImageWithDirect:MIDDLE selected:false];
    _middleSelectImage = [self getImageWithDirect:MIDDLE selected:true];
    
    _leftNormalImage = [self getImageWithDirect:LEFT selected:false];
    _leftSelectImage = [self getImageWithDirect:LEFT selected:true];
    
    _rightNormalImage = [self getImageWithDirect:RIGHT selected:false];
    _rightSelectImage = [self getImageWithDirect:RIGHT selected:true];
}

- (void)setDefault {
    _currentSelectIndex = defaultSelectIndex;
    _cornerRadius = defaultCornerRadius;
    _cornerWidth = defaultCornerWidth;
    _buttonMiddleAdge = defaultButtonMiddleAdge;
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)setDelegate:(id<CustomSegmentProtocol>)delegate {
    if (delegate != nil) {
        _delegate = nil;
    }
    
    if (_delegate != delegate) {
        _delegate = delegate;
        [self resetComponent];
    }
}

- (void)resetComponent {
    
    if (_delegate == nil) {
        return;
    }
    
    // 如果没有实现 则选择默认的
    if ([self.delegate respondsToSelector:@selector(getCornerRadius)]) {
        _cornerRadius = [self.delegate getCornerRadius];
    }
    
    if ([self.delegate respondsToSelector:@selector(getCornerWidth)]) {
        _cornerWidth = [self.delegate getCornerWidth];
    }
    
    if ([self.delegate respondsToSelector:@selector(getButtobMiddleAdge)]) {
        _buttonMiddleAdge = [self.delegate getButtobMiddleAdge];
    }
    
    // array 必须实现， 不然不初始化 button
    if ([_delegate respondsToSelector:@selector(getSegmentNameArray)]) {
        _buttonTitleArray = [_delegate getSegmentNameArray];
        
        CGFloat width = (self.frame.size.width + _buttonMiddleAdge) / _buttonTitleArray.count - _buttonMiddleAdge;
        _buttonSize = CGSizeMake(width, self.frame.size.height);
        
        [self initContentButtonImage];
        [self initContentButton];
    }
}

- (void)layoutContentButtons {
    NSUInteger count = _buttonTitleArray.count;
    CGFloat width = (self.frame.size.width + _buttonMiddleAdge) / count - _buttonMiddleAdge;
    for (int i = 0; i < count; i++) {
        CGRect frame = CGRectMake((width + _buttonMiddleAdge) * i, 0, width, self.frame.size.height);
        UIButton *button = [_contentButtonArray objectAtIndex:i];
        [button setFrame:frame];
        
        [button setTitle:[_buttonTitleArray objectAtIndex:i] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self resetComponent];
    [self layoutContentButtons];
}

#pragma private func
- (UIImage *)getImageWithDirect:(int)direct selected:(Boolean)select{
    
    NSInteger _direct = UIRectCornerAllCorners;
    
    switch (direct) {
        case LEFT:
            _direct = UIRectCornerBottomLeft | UIRectCornerTopLeft;
            break;
        case MIDDLE:
            _direct = 0;
            break;
        case RIGHT:
            _direct = UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        default:
            break;
    }
    
    return [UIImage SEGButtonSelectedColor:[UIColor blackColor]
                                      size:_buttonSize
                               shadowWidth:_cornerWidth
                               shadowColor:[UIColor blueSegmentColor]
                              cornerRadius:_cornerRadius
                                  selected:select
                                cornerType:_direct];
}

- (void)buttonClick:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *clickButton = (UIButton *)sender;
        NSUInteger index = [_contentButtonArray indexOfObject:clickButton];
        [self setCurrentSelectIndex:index];
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickButtonAtIndex:)]) {
            [self.delegate didClickButtonAtIndex:index];
        }
    }
}

- (void)setCurrentSelectIndex:(NSUInteger)selectIndex {
    UIButton *currentButton = [_contentButtonArray objectAtIndex:_currentSelectIndex];
    [self setButton:currentButton selected:false index:_currentSelectIndex];
    
    UIButton *selectButton = [_contentButtonArray objectAtIndex:selectIndex];
    [self setButton:selectButton selected:true index:selectIndex];
    _currentSelectIndex = selectIndex;
}

- (void)setButton:(UIButton *)button selected:(Boolean)selected index:(NSUInteger)index{
    NSUInteger direct = [self getDirctByIndex:index];
    switch (direct) {
        case RIGHT:
            if (selected) {
                [button setBackgroundImage:_rightSelectImage forState:UIControlStateNormal];
                [button setBackgroundImage:_rightSelectImage forState:UIControlStateHighlighted];
            } else {
                [button setBackgroundImage:_rightNormalImage forState:UIControlStateNormal];
                [button setBackgroundImage:_rightNormalImage forState:UIControlStateHighlighted];
            }
            break;
        case LEFT:
            if (selected) {
                [button setBackgroundImage:_leftSelectImage forState:UIControlStateNormal];
                [button setBackgroundImage:_leftSelectImage forState:UIControlStateHighlighted];
            } else {
                [button setBackgroundImage:_leftNormalImage forState:UIControlStateNormal];
                [button setBackgroundImage:_leftNormalImage forState:UIControlStateHighlighted];
            }
            break;
        case MIDDLE:
            if (selected) {
                [button setBackgroundImage:_middleSelectImage forState:UIControlStateNormal];
                [button setBackgroundImage:_middleSelectImage forState:UIControlStateHighlighted];
            } else {
                [button setBackgroundImage:_middleNormalImage forState:UIControlStateNormal];
                [button setBackgroundImage:_middleNormalImage forState:UIControlStateHighlighted];
            }
            break;
        default:
            break;
    }
}

- (NSUInteger)getDirctByIndex:(NSUInteger)index {
    if (index == 0) {
        return LEFT;
    } else if (index == _buttonTitleArray.count - 1){
        return RIGHT;
    } else {
        return MIDDLE;
    }
    // 这个不会出现
    return UNKOWN;
}

@end
