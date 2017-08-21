//
//  ItemAdvertCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIAdvertCell.h"
#import "TTSliderView.h"
#import "CIItemInfoModel.h"

@interface CIAdvertCell () <TTSliderViewDataSource, TTSliderViewDelegate>

@property (nonatomic, strong) TTSliderView *sliderView;

@end

@implementation CIAdvertCell


- (void)reloadData {
    
    if ( self.cellData ) {
        
        [self.sliderView removeFromSuperview];
        
        self.sliderView = nil;
        
        [self cellAddSubView:self.sliderView];
        
        [self.sliderView reloadData];
        
    }else{
        [_sliderView removeFromSuperview];
        
        _sliderView = nil;
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if ( cellData ) {
        CIItemInfoModel *ad = (CIItemInfoModel *)cellData;
        return SCREEN_WIDTH / ad.ar;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (TTSliderView *)sliderView {
    
    if ( !_sliderView ) {
        
        CGFloat height = 0;
        if (self.cellData) {
            CIItemInfoModel *ad = (CIItemInfoModel *)self.cellData;
            height = SCREEN_WIDTH / ad.ar;
        }
        
        _sliderView = [[TTSliderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) style:SliderViewPageControlStyleDot alignment:SliderViewPageControlAlignmentCenter];
        _sliderView.delegate = self;
        _sliderView.dataSource = self;
        _sliderView.autoScroll = NO;
        _sliderView.wrapEnabled = NO;
        _sliderView.currentPageColor = Main_Color;
        _sliderView.pageControl.pageIndicatorTintColor = Color_Black;
        
        
    }
    
    return _sliderView;
}

#pragma mark - TTSliderViewDataSource

- (NSInteger)numberOfItemsInSliderView:(TTSliderView *)sliderView
{
    CIItemInfoModel *ad = (CIItemInfoModel *)self.cellData;
    
    return ad.images.count;
}

- (UIView *)sliderView:(TTSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    if (!view) {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        view.userInteractionEnabled = YES;
    }
    
    UIImageView *coverImageView = (UIImageView *) view;
    
    CIItemInfoModel *ad = (CIItemInfoModel *)self.cellData;
    [coverImageView setOnlineImage:[ad.images safeObjectAtIndex:index]];
    
    return coverImageView;
}
@end
