//
//  CustomPageView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/25.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CustomPageView.h"
#import "TradeTabButton.h"
#import "IOSLayoutDefine.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"
#import "SinglePageView.h"

#import "TextFieldController.h"

//const CGFloat topTabHeight   = 40.0f;
const CGFloat leftEdge       = 10.0f;
const CGFloat middleEdge     = 5.0f;
//const static CGFloat topTabWidth  = 80.0f;

#define ScrollViewWidth     self.frame.size.width
#define ScrollViewHeight    self.frame.size.height - _topTapHeight

@interface CustomPageView()<UIScrollViewDelegate> {
    UIScrollView    *_scrollView;
    //    UIPageControl   *_pageControl;
    CGFloat _topTapHeight;
    
    NSMutableArray      *_topTabButtonArray;
    UIView              *currentPageView;
    
    NSUInteger          _currentPage;
}

@end

@implementation CustomPageView

@synthesize pageViewArray = _pageViewArray;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initComponent];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    [self setBackgroundColor:[UIColor mainBackgroundColor]];
    //    isInited = false;
    _currentPage = UINT8_MAX;
    [self initScrollView];
}

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setDelegate:self];
    [_scrollView setBounces:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_scrollView];
}

// 在设置代理以后才能知道获得有多少个Button
//- (void)initTopTabButtons {
//    if (_topTabButtonArray != nil) {
//        for (UIView *view in _topTabButtonArray) {
//            [view removeFromSuperview];
//        }
//        [_topTabButtonArray removeAllObjects];
//    } else {
//        _topTabButtonArray = [[NSMutableArray alloc] init];
//    }
//
//
//}

// 在设置代理以后才能知道有多少个Page
//- (void)initPageViews {
//    for (UIView *pageView in self.pageViewArray) {
//
//    }
//
//}

#pragma layout subviews
- (void)layoutTopTabButtons {
    CGFloat tabWidth = (ScrollViewWidth - leftEdge * 2) / self.pageViewArray.count - middleEdge * 2;
    for (int i = 0; i < self.pageViewArray.count; i++) {
        //        UIButton *button = [_topTabButtonArray objectAtIndex:i];
        UIButton *button = [(SinglePageView *)[self.pageViewArray objectAtIndex:i] titleButton];
        CGRect buttonFrame = CGRectMake(leftEdge + middleEdge + i * (tabWidth + middleEdge * 2), 5, tabWidth, _topTapHeight - 5);
        [button setFrame:buttonFrame];
        //        NSString *title = [(SinglePageView *)[self.pageViewArray objectAtIndex:i] title];
        //        [button setTitle:title forState:UIControlStateNormal];
        
        if (self.pageViewArray.count == 1) {
            [button setFrame:CGRectMake(0, 5, ScrollViewWidth, _topTapHeight - 5)];
        }
        
        [UIFormat setCorner:UIRectCornerTopLeft | UIRectCornerTopRight WithUIView:button withCorner:12.0f];
    }
    
}

- (void)layoutPageViews {
    for (int i = 0; i < self.pageViewArray.count; i++) {
        UIView *tempView = [self.pageViewArray objectAtIndex:i];
        [tempView setFrame:CGRectMake(i * ScrollViewWidth, 0, ScrollViewWidth, ScrollViewHeight)];
//        NSLog(@"%f...%@", ScrollViewHeight, [tempView class]);
    }
}

//- (UIButton *)getTopTabButton {
//    UIButton *topTabButton = [[UIButton alloc] init];
//    [topTabButton setBackgroundColor:[UIColor tabBackgroundColor]];
//    [topTabButton addTarget:self action:@selector(topTabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    return topTabButton;
//}

- (void)buildTopTapButton:(UIButton *)button {
    [button setBackgroundColor:[UIColor tabBackgroundColor]];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:18.0f]];
    [button addTarget:self
               action:@selector(topTabButtonClick:)
     forControlEvents:UIControlEventTouchUpInside];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / ScrollViewWidth;
    [self setCurrentPage:index];
}

- (void)topTabButtonClick:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        [self setCurrentPage:[_topTabButtonArray indexOfObject:sender]];
    }
}

- (void)reclickCurrentPage {
    [[self.pageViewArray objectAtIndex:_currentPage] reloadPageData];
}

- (void)setCurrentPage:(NSUInteger)currentPage {
    // 按理说， 不应该 加在 这里，耦合性太高， 但是 目前来看， 加在这里方便
    // 还是不加了
    //    [[TextFieldController getInstance] keyboardReturen];
    
    if (currentPage >= self.pageViewArray.count) {
        NSLog(@"cross array");
        return;
    }
    
    if (_currentPage == currentPage) {
        [[self.pageViewArray objectAtIndex:currentPage] reloadPageData];
        return;
    }
    
    if (_currentPage == UINT8_MAX) {
        _currentPage = 0;
    }
    
    [[_topTabButtonArray objectAtIndex:_currentPage] setBackgroundColor:[UIColor tabBackgroundColor]];
    [[_topTabButtonArray objectAtIndex:currentPage] setBackgroundColor:[UIColor blackColor]];
    [[[_topTabButtonArray objectAtIndex:_currentPage] titleLabel] setFont:[UIFont systemFontOfSize:18.0f]];
    [[[_topTabButtonArray objectAtIndex:currentPage] titleLabel] setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_scrollView setContentOffset:CGPointMake(currentPage * ScrollViewWidth, 0) animated:NO];
    
    [[self.pageViewArray objectAtIndex:_currentPage] pageUnSelect];
    [[self.pageViewArray objectAtIndex:currentPage] reloadPageData];
    [[self.pageViewArray objectAtIndex:currentPage] pageSelect];
    
    _currentPage = currentPage;
    
    if (_actionDelegate != nil && [_actionDelegate respondsToSelector:@selector(pageView:didChangePageAtIndex:)]) {
        [_actionDelegate pageView:self didChangePageAtIndex:currentPage];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutPageViews];
    [self layoutTopTabButtons];
}

#pragma setDelegate
- (void)setSourceDelegate:(id<CustomPageViewDataSourceProtocol>)sourceDelegate {
    if (sourceDelegate == nil) {
        _sourceDelegate = nil;
    }
    
    if (_sourceDelegate != sourceDelegate) {
        _sourceDelegate = sourceDelegate;
        
        [self resetComponent];
        [self setScrollEnable];
    }
}

- (void)setActionDelegate:(id<CustomPageViewActionProtocol>)actionDelegate {
    if (actionDelegate == nil) {
        _actionDelegate = nil;
    }
    
    if (_actionDelegate != actionDelegate) {
        _actionDelegate = actionDelegate;
    }
}

- (void)resetComponent {
    if (_sourceDelegate != nil && [_sourceDelegate respondsToSelector:@selector(topTapTitleHeightAtPageView:)]) {
        _topTapHeight = [_sourceDelegate topTapTitleHeightAtPageView:self];
    }
    
    if (_sourceDelegate != nil && [_sourceDelegate respondsToSelector:@selector(arrayOfCustomPageViewAtPageView:)]) {
        self.pageViewArray = [_sourceDelegate arrayOfCustomPageViewAtPageView:self];
    }
}

- (void)setScrollEnable {
    if (_sourceDelegate != nil && [_sourceDelegate respondsToSelector:@selector(scrollEnable)]) {
        [_scrollView setScrollEnabled:[_sourceDelegate scrollEnable]];
    }
}

#pragma publicFunc
- (void)setPageViewArray:(NSArray *)pageViewArray {
    _pageViewArray = pageViewArray;
    _topTabButtonArray = [[NSMutableArray alloc] init];
    for (int index = 0; index < pageViewArray.count; index ++) {
        UIView *view = [pageViewArray objectAtIndex:index];
        if ([view isKindOfClass:[SinglePageView class]]) {
            SinglePageView *singleView = (SinglePageView *)view;
            [singleView setPageIndex:index];
            [self buildTopTapButton:[singleView titleButton]];
            [_topTabButtonArray addObject:[singleView titleButton]];
            [self addSubview:[singleView titleButton]];
            [_scrollView addSubview:singleView];
        }
    }
    [_scrollView setFrame:CGRectMake(0, _topTapHeight, self.frame.size.width, self.frame.size.height - _topTapHeight)];
    [_scrollView setContentSize:CGSizeMake(ScrollViewWidth * self.pageViewArray.count, ScrollViewHeight)];
}

- (void)removeAllListener {
    for (SinglePageView *view in self.pageViewArray) {
        [view pageUnSelect];
    }
    [[_topTabButtonArray objectAtIndex:_currentPage] setBackgroundColor:[UIColor tabBackgroundColor]];
    [[[_topTabButtonArray objectAtIndex:_currentPage] titleLabel] setFont:[UIFont systemFontOfSize:18.0f]];
    _currentPage = UINT8_MAX;
}

- (void)dealloc {
    
}

@end
