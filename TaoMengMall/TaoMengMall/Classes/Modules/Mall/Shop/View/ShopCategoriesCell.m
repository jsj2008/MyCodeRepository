//
//  ShopCategoriesCell.m
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopCategoriesCell.h"
#import "ShopTabCateModel.h"

@interface ShopCategoriesCell ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation ShopCategoriesCell

- (void)reloadData
{
    if (self.cellData) {
        
        [self cellAddSubview:self.scrollView];
        
        NSArray *cates = (NSArray*)self.cellData;
        
        [self.scrollView removeAllSubviews];
        [self.buttons removeAllObjects];
        
        CGFloat left = 10;
        NSInteger selectedIndex = -1;
        for (int i = 0; i < cates.count; i++) {
            ShopTabCateModel *cate = [cates safeObjectAtIndex:i];
            if (cate.isSelected) {
                selectedIndex = i;
            }
            UIButton *button = [self cateButtonWithCate:cate];
            button.tag = i;
            button.left = left;
            left += button.width+10;
            [self.scrollView addSubview:button];
            [self.buttons addObject:button];
        }
        
        if (selectedIndex != -1) {
            [self selectButtonWithIndex:selectedIndex];
        }
        
        if (left > self.scrollView.width) {
            self.scrollView.contentSize = CGSizeMake(left, 42);
        }
        self.backgroundColor = Color_Gray245;

    }else{
        [self removeAllSubviews];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    NSArray *list = (NSArray*)cellData;
    if (list.count > 0) {
        return 43;
    }
    return 0;
}

#pragma mark - Subviews
- (UIScrollView*)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 42)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollView.height);
        _scrollView = scrollView;
        
        _buttons = [NSMutableArray array];
    }
    return _scrollView;
}

- (UIButton*)cateButtonWithCate:(ShopTabCateModel*)cate
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 0, 32)];
    [button setTitle:cate.name forState:UIControlStateNormal];
    [button setBackgroundColor:Color_White];
    button.titleLabel.font = FONT(14);
    [button setTitleColor:Color_White forState:UIControlStateSelected];
    [button setTitleColor:Color_Gray(45) forState:UIControlStateNormal];
    button.layer.cornerRadius = 2.;
    button.layer.masksToBounds = YES;
    [button sizeToFit];
    if (button.width < 66) {
        button.width = 66;
    }else{
        button.width += 20;
    }
    [button addTarget:self action:@selector(handleCateButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setCateButton:(UIButton*)button selected:(BOOL)selected
{
    button.selected = selected;
    if (selected) {
        [button setBackgroundColor:Theme_Color];
    }else{
        [button setBackgroundColor:Color_White];
    }
}

- (void)selectButtonWithIndex:(NSInteger)index
{
    for (UIButton *button in self.buttons) {
        [self setCateButton:button selected:NO];
    }
    UIButton *button = [self.buttons safeObjectAtIndex:index];
    [self setCateButton:button selected:YES];
    
    if (self.scrollView.contentSize.width > SCREEN_WIDTH) {
        CGFloat x = button.left - (SCREEN_WIDTH-button.width)/2;
        if (x<0) {
            x = 0;
        }else if (x > self.scrollView.contentSize.width - SCREEN_WIDTH) {
            x = self.scrollView.contentSize.width - SCREEN_WIDTH;
        }
        [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    }
}

- (void)handleCateButton:(UIButton*)button
{
    if(button.selected) return;
    [self selectButtonWithIndex:button.tag];
    if ([self.delegate respondsToSelector:@selector(cellTapCate:)]) {
        NSArray *cates = (NSArray*)self.cellData;
        [self.delegate cellTapCate:[cates safeObjectAtIndex:button.tag]];
    }
}
@end
