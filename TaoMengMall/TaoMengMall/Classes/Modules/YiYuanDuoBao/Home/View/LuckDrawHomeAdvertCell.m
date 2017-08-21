//
//  DSAdvertCell.m
//  BabyDaily
//
//  Created by wzningjie on 16/9/21.
//  Copyright © 2016年 marco. All rights reserved.
//

#import "LuckDrawHomeAdvertCell.h"
#import "TTSliderView.h"
#import "LuckDrawHomeAdvertModel.h"


@interface LuckDrawHomeAdvertCell () <TTSliderViewDataSource, TTSliderViewDelegate>

@property (nonatomic, strong) TTSliderView *sliderView;

@end

@implementation LuckDrawHomeAdvertCell


- (void)reloadData {
    
    if ( self.cellData ) {
        
        [self.sliderView removeFromSuperview];
        
        self.sliderView = nil;
        
        [self cellAddSubview:self.sliderView];
        
        [self.sliderView reloadData];
        
    }else{
        [_sliderView removeFromSuperview];
        
        _sliderView = nil;
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if ( cellData ) {
        LuckDrawHomeAdvertModel *ad = (LuckDrawHomeAdvertModel *)cellData;
        return SCREEN_WIDTH / ad.ar;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (TTSliderView *)sliderView {
    
    if ( !_sliderView ) {
        
        CGFloat height = 0;
        if (self.cellData) {
            LuckDrawHomeAdvertModel *ad = (LuckDrawHomeAdvertModel *)self.cellData;
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
    LuckDrawHomeAdvertModel *ad = (LuckDrawHomeAdvertModel *)self.cellData;
    
    return ad.list.count;
    return 0;
}

- (UIView *)sliderView:(TTSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    if (!view) {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        view.userInteractionEnabled = YES;
    }
    
    UIImageView *coverImageView = (UIImageView *) view;
    
    LuckDrawHomeAdvertModel *ad = (LuckDrawHomeAdvertModel *)self.cellData;
    LuckDrawHomeAdvertItemModel *subItem = [ad.list safeObjectAtIndex:index];
    [coverImageView setOnlineImage:subItem.image];
    
    return coverImageView;
}

#pragma mark - TTSliderViewDelegate

- (void)sliderView:(TTSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index
{
    LuckDrawHomeAdvertModel *ad = (LuckDrawHomeAdvertModel *)self.cellData;
    
    LuckDrawHomeAdvertItemModel *adItemModel = [ad.list safeObjectAtIndex:index];
    
    [[TTNavigationService sharedService] openUrl:adItemModel.link];
}

@end
