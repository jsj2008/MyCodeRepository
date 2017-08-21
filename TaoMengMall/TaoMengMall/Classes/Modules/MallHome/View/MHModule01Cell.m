//
//  MHAdvertCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule01Cell.h"
#import "TTSliderView.h"
#import "MHModuleModel.h"


@interface MHModule01Cell () <TTSliderViewDataSource, TTSliderViewDelegate>

@property (nonatomic, strong) TTSliderView *sliderView;

@end

@implementation MHModule01Cell


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
        MHModuleModel *ad = (MHModuleModel *)cellData;
        MHItemModel *item = [ad.items safeObjectAtIndex:0];
        if (item) {
           return SCREEN_WIDTH / item.ar;
        }
        
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (TTSliderView *)sliderView {
    
    if ( !_sliderView ) {
        
        CGFloat height = 0;
        if (self.cellData) {
            MHModuleModel *ad = (MHModuleModel *)self.cellData;
            MHItemModel *item = [ad.items safeObjectAtIndex:0];
            if (item) {
                height = SCREEN_WIDTH / item.ar;
            }
        }
        
        _sliderView = [[TTSliderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) style:SliderViewPageControlStyleDot alignment:SliderViewPageControlAlignmentCenter];
        _sliderView.delegate = self;
        _sliderView.dataSource = self;
        _sliderView.autoScroll = NO;
        _sliderView.wrapEnabled = NO;
        _sliderView.currentPageColor = Theme_Color;
        _sliderView.pageControl.pageIndicatorTintColor = Color_White;
    }
    
    return _sliderView;
}

#pragma mark - TTSliderViewDataSource

- (NSInteger)numberOfItemsInSliderView:(TTSliderView *)sliderView
{
    MHModuleModel *ad = (MHModuleModel *)self.cellData;
    return ad.items.count;
}

- (UIView *)sliderView:(TTSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    if (!view) {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        view.userInteractionEnabled = YES;
    }
    
    UIImageView *coverImageView = (UIImageView *) view;
    
    MHModuleModel *ad = (MHModuleModel *)self.cellData;
    MHItemModel *subItem = [ad.items safeObjectAtIndex:index];
    [coverImageView setOnlineImage:subItem.image placeHolderImage:[UIImage imageNamed:@"placeholder_w"]];
    return coverImageView;
}

#pragma mark - TTSliderViewDelegate

- (void)sliderView:(TTSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index
{
     MHModuleModel *ad = (MHModuleModel *)self.cellData;
    
    MHItemModel *adItemModel = [ad.items safeObjectAtIndex:index];
    
    [[TTNavigationService sharedService] openUrl:adItemModel.link];
}

@end
