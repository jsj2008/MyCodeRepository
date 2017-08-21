//
//  ITCoverImageCell.m
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITCoverImageCell.h"
#import "ITCoverImageModel.h"
#import "TTSliderView.h"

@interface ITCoverImageCell ()<TTSliderViewDataSource, TTSliderViewDelegate,UIScrollViewDelegate>

//@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) TTSliderView *sliderView;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSUInteger pageIndex;
@end

@implementation ITCoverImageCell

#define CARD_WIDTH  (SCREEN_WIDTH-80)
#define PADDING     10

- (void)drawCell{
    
    //[self addSubview:self.sliderView];
    [self addSubview:self.scrollView];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ITCoverImageModel *coverImage = (ITCoverImageModel *)self.cellData;
        
//        [self.itemImageView setOnlineImage:coverImage.src[0]];
//        
//        self.itemImageView.height = SCREEN_WIDTH / coverImage.ar;
        
        //self.sliderView.height = SCREEN_WIDTH / coverImage.ar;
        //[self.sliderView reloadData];
        
        self.scrollView.height = 8+(SCREEN_WIDTH-80)/coverImage.ar;
        
        [self.scrollView removeAllSubviews];
        [self.imageViews removeAllObjects];
        
        CGFloat width = (PADDING+CARD_WIDTH)*coverImage.src.count + 70;
        if (width < SCREEN_WIDTH) {
            width = SCREEN_WIDTH;
        }
        self.scrollView.contentSize = CGSizeMake(width, self.scrollView.height);
        
        for (int i = 0; i < coverImage.src.count; i++) {
            UIImageView *module = [[UIImageView alloc]initWithFrame:CGRectMake(40 + (PADDING+CARD_WIDTH)*i, 4, SCREEN_WIDTH-80, self.scrollView.height-8)];
            //UIImageView *module = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-80, self.scrollView.height-8)];
            module.tag = i;
            module.userInteractionEnabled = YES;
            [module setOnlineImage:[coverImage.src safeObjectAtIndex:i] placeHolderImage:[UIImage imageNamed:@"placeholder_s"]];
            
            module.layer.cornerRadius = 4.;
            module.layer.masksToBounds = YES;
            
//            module.layer.shadowOffset = CGSizeMake(0,-3);
//            module.layer.shadowOpacity = 0.9;
//            module.layer.shadowColor = [UIColor blackColor].CGColor;
//            module.layer.shadowRadius = 5;
//            module.clipsToBounds = NO;


            //给bgView边框设置阴影
//            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40 + (PADDING+CARD_WIDTH)*i, 4, SCREEN_WIDTH-80, self.scrollView.height-8)];
//            view.layer.shadowOffset = CGSizeMake(1,1);
//            view.layer.shadowOpacity = 0.5;
//            view.layer.shadowColor = [UIColor blackColor].CGColor;
//            view.layer.shadowRadius = 2;
//            view.clipsToBounds = NO;
//            [view addSubview:module];
            
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapCover:)];
            [module addGestureRecognizer:gesture];
            
            [self.imageViews addObject:module];
            [self.scrollView addSubview:module];
        }
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if ( cellData ) {
        
        ITCoverImageModel *coverImage = (ITCoverImageModel *)cellData;
        
        return (SCREEN_WIDTH-80) / coverImage.ar+8;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

//- (UIImageView *)itemImageView {
//    
//    if ( !_itemImageView ) {
//        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
//    }
//    
//    return _itemImageView;
//}

- (TTSliderView *)sliderView {
    
    if (!_sliderView) {
        _sliderView = [[TTSliderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:SliderViewPageControlStyleDot alignment:SliderViewPageControlAlignmentCenter];
        _sliderView.delegate = self;
        _sliderView.dataSource = self;
        _sliderView.autoScroll = NO;
        _sliderView.wrapEnabled = NO;
        _sliderView.currentPageColor = Color_Red12;
        _sliderView.userInteractionEnabled = YES;
        [self addSubview:_sliderView];
        
    }
    
    return _sliderView;
}

- (UIScrollView*)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollView.height);
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (NSMutableArray*)imageViews
{
    if (!_imageViews) {
        _imageViews = [NSMutableArray arrayWithCapacity:4];
    }
    return _imageViews;
}


- (void)animationDidStop
{
//    ITCoverImageModel *coverImage = (ITCoverImageModel *)self.cellData;
//    if (coverImage.src.count>0&&[self.delegate respondsToSelector:@selector(didScrollToTask:)]) {
//        [self.delegate didScrollToTask:[tasks safeObjectAtIndex:_pageIndex]];
//    }
}

- (void)handleTapCover:(UITapGestureRecognizer*)tap
{
    if ([self.delegate respondsToSelector:@selector(didTapCoverAtIndex:)]) {
        UIView *cover = tap.view;
        [self.delegate didTapCoverAtIndex:cover.tag];
    }
}

- (void)scrollToCoverAtIndex:(NSInteger)index
{
    ITCoverImageModel *coverImage = (ITCoverImageModel *)self.cellData;

    if (index >= 0 && index < coverImage.src.count) {
        _pageIndex = index;
        int pageWidth = CARD_WIDTH+PADDING;
        CGPoint offset = CGPointMake(_pageIndex*pageWidth, 0);
        [self.scrollView setContentOffset:offset animated:NO];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset
{
    int pageWidth = CARD_WIDTH+PADDING;
    ITCoverImageModel *coverImage = (ITCoverImageModel *)self.cellData;
    NSUInteger pageCount = coverImage.src.count;
    
    //int pageX = _pageIndex*pageWidth-scrollView.contentInset.left;
    int pageX = 40 + (PADDING+CARD_WIDTH)*_pageIndex;
    if (targetContentOffset->x<(pageX-CARD_WIDTH/2-PADDING)) {
        if (_pageIndex>0) {
            _pageIndex--;
        }
    }else if(targetContentOffset->x>=(pageX+CARD_WIDTH/2)){
        if (_pageIndex<pageCount-1) {
            _pageIndex++;
        }
    }
    NSLog(@"pageX+CARD_WIDTH/2=%f",pageX+CARD_WIDTH/2);
    
    targetContentOffset->x = _pageIndex*pageWidth-scrollView.contentInset.left;
    NSLog(@"%lu %d", _pageIndex, (int)targetContentOffset->x);
    
    [UIView beginAnimations:@"TransitionAnimation" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    scrollView.contentOffset = *targetContentOffset;
    //[UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    [UIView commitAnimations];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


#pragma mark - TTSliderViewDataSource

- (NSInteger)numberOfItemsInSliderView:(TTSliderView *)sliderView {
    
    if (self.cellData) {
        
        ITCoverImageModel *coverImage = (ITCoverImageModel *)self.cellData;
        
        return coverImage.src.count;
        
    } else {
        return 0;
    }
}

- (UIView *)sliderView:(TTSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    if (self.cellData) {
        
        ITCoverImageModel *coverImage = (ITCoverImageModel *)self.cellData;
        
//        if (!view) {
//            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
//            view.userInteractionEnabled = YES;
//        }
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        
        [imageView setOnlineImage:[coverImage.src safeObjectAtIndex:index]];
        
//        [((UIImageView *)view) setOnlineImage:[coverImage.src safeObjectAtIndex:index]];
        
        return imageView;
      
    }
    
    return view;
    
}

@end
