//
//  ShopSiftCell.m
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopSiftCell.h"
#import "ShopTabModel.h"

@interface ShopSiftCell ()
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *line;
@end

@implementation ShopSiftCell

- (void)reloadData
{
    if (self.cellData) {
        
        for (UIButton *button in self.buttons) {
            [button removeFromSuperview];
        }
        [self.buttons removeAllObjects];
        
        NSArray *tabs = (NSArray*)self.cellData;
        CGFloat buttonWidth = SCREEN_WIDTH/tabs.count;
        self.bottomLine.width = buttonWidth;

        NSInteger selectedIndex = -1;

        for (int i = 0; i < tabs.count; i++) {
            ShopTabModel *tab = [tabs safeObjectAtIndex:i];
            if (tab.isSelected) {
                selectedIndex = i;
            }
            UIButton *button = [self tabButtonWithTab:tab];
            button.tag = i;
            button.width = buttonWidth;
            button.left = i*buttonWidth;
            [self cellAddSubview:button];
            [self.buttons addObject:button];
        }
        
        if (selectedIndex != -1) {
            [self selectTabWithIndex:selectedIndex];
        }
        
        [self cellAddSubview:self.line];
        [self cellAddSubview:self.bottomLine];
    }else{
        [self removeAllSubviews];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        return 44;
    }
    return 0;
}

#pragma mark -SubViews

- (UIView*)bottomLine
{
    if (!_bottomLine) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        view.backgroundColor = Theme_Color;
        view.bottom = 44;
        _bottomLine = view;
        
        _buttons = [NSMutableArray array];
    }
    return _bottomLine;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 44;
        _line = view;
    }
    return _line;
}

- (UIButton*)tabButtonWithTab:(ShopTabModel*)tab
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 42)];
    [button setTitle:tab.name forState:UIControlStateNormal];
    [button setTitleColor:Theme_Color forState:UIControlStateSelected];
    [button setTitleColor:Color_Gray(153) forState:UIControlStateNormal];
    [button setBackgroundColor:Color_White];
    button.titleLabel.font = FONT(14);
    [button addTarget:self action:@selector(handleTabButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)selectTabWithIndex:(NSInteger)index
{
    for (UIButton *button in self.buttons) {
        button.selected = NO;
    }
    UIButton *button = [self.buttons safeObjectAtIndex:index];
    button.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLine.left = button.tag*self.bottomLine.width;
    }];
}

- (void)handleTabButton:(UIButton*)button
{
    if(button.selected) return;
    
    [self selectTabWithIndex:button.tag];
    if ([self.delegate respondsToSelector:@selector(cellTapSift:)]) {
        NSArray *tabs = (NSArray*)self.cellData;
        [self.delegate cellTapSift:[tabs safeObjectAtIndex:button.tag]];
    }
}

@end
