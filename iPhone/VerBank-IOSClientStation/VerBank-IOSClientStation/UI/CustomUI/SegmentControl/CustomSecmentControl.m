//
//  CustomSecmentControl.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/16.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "CustomSecmentControl.h"

@interface CustomSecmentControl()
@end

@implementation CustomSecmentControl

@synthesize selectIndex;
@synthesize titleArray;
@synthesize cornerRadio = _cornerRadio;
@synthesize titleFont;
@synthesize segmentDelegate;

-(void)initBtnOnView{
    for (int i = 0;i < _viewCount;i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        int direct = 0;
        Boolean selected = false;
        if (i == 0) {
            direct = LEFT;
        } else if(i == (_viewCount - 1)){
            direct = RIGHT;
        } else {
            direct = MIDDLE;
        }
        
        if (selectIndex == i) {
            selected = true;
        }
        
        [self setButton:button selected:selected direct:direct];
        [button setBackgroundColor:[UIColor clearColor]];
        button.tag = i + OFFSET;
        [button addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    [self changeBtnTitle];
}


- (void)initLayout{
    _buttonSize = CGSizeMake((self.frame.size.width + BUTTON_EDGE)/ _viewCount - BUTTON_EDGE, self.frame.size.height);
    
    _normalImage = [self getImageWithDirect:MIDDLE selected:false];
    _selectImage = [self getImageWithDirect:MIDDLE selected:true];
    
    _leftNormalImage = [self getImageWithDirect:LEFT selected:false];
    _leftSelectImage = [self getImageWithDirect:LEFT selected:true];
    
    _rightNormalImage = [self getImageWithDirect:RIGHT selected:false];
    _rightSelectImage = [self getImageWithDirect:RIGHT selected:true];
    
   
}

- (void)updateLayout {
    for (int i = 0;i < _viewCount;i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i + OFFSET];
        button.frame = CGRectMake((self.frame.size.width + BUTTON_EDGE) / _viewCount * i,
                                  0,
                                  (self.frame.size.width + BUTTON_EDGE)/ _viewCount - BUTTON_EDGE,
                                  self.frame.size.height);
    }
}

- (void)setSelectIndex:(NSInteger)_selectIndex {
//    -(void)clickBtnAction:(UIButton *)sender
    UIButton *btn=(UIButton *)[self viewWithTag:(int)_selectIndex + OFFSET];
    if (btn != nil) {
        [self clickBtnAction:btn];
    }
}

#pragma privateFunc

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
    
//    CGFloat tempRadio = self.cornerRadio <= 0.001 ? CORNER_RADIUS : self.cornerRadio;
    
    return [UIImage SEGButtonSelectedColor:_backgroundColor
                                      size:_buttonSize
                               shadowWidth:CORNER_WIDTH
                               shadowColor:[UIColor blueSegmentColor]
                              cornerRadius:self.cornerRadio
                                  selected:select
                                cornerType:_direct];
}

- (void)setButton:(UIButton *)button selected:(Boolean)selected direct:(int)direct{
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
                [button setBackgroundImage:_selectImage forState:UIControlStateNormal];
                [button setBackgroundImage:_selectImage forState:UIControlStateHighlighted];
            } else {
                [button setBackgroundImage:_normalImage forState:UIControlStateNormal];
                [button setBackgroundImage:_normalImage forState:UIControlStateHighlighted];
            }
            break;
        default:
            break;
    }
}



- (void)updateButton:(NSInteger)oldTage newTag:(NSInteger)newTag{
    UIButton *oldBtn = (UIButton *)[self viewWithTag:oldTage];
    UIButton *newBtn = (UIButton *)[self viewWithTag:newTag];
    [self setButton:oldBtn selected:false direct:[self directByTag:oldTage]];
    [self setButton:newBtn selected:true direct:[self directByTag:newTag]];
}

- (int)directByTag:(NSInteger)tag{
    if ((tag - OFFSET) == 0) {
        return LEFT;
    } else if((tag - OFFSET) == (_viewCount - 1)){
        return RIGHT;
    } else {
        return MIDDLE;
    }
}

-(void)setTitleArray:(NSArray *)title_Array{
    if (titleArray != title_Array) {
        titleArray=nil;
        titleArray = [title_Array copy];
    }
    _viewCount = [titleArray count];
}

-(void)changeBtnTitle{
    for (int i=0; i<_viewCount; i++) {
        // set text
        UIButton *btn=(UIButton *)[self viewWithTag:i + OFFSET];
        [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        // set font
        [btn.titleLabel setFont:titleFont];
    }
}

#pragma  click
-(void)clickBtnAction:(UIButton *)sender{
    
    NSInteger oldTag = selectIndex + OFFSET;
    selectIndex = sender.tag - OFFSET;
    [self updateButton:oldTag newTag:sender.tag];
    
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(customSecmentControlClick:)]) {
        [self.segmentDelegate customSecmentControlClick:sender.tag - OFFSET];
    }
}

-(void)dealloc{
    _normalImage=nil;
    _selectImage=nil;
    _normalTitleColor=nil;
    _selectTitleColor=nil;
    
    titleArray=nil;
    titleFont=nil;
    self.segmentDelegate=nil;
}

@end
