//
//  MHModulle16Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule16Cell.h"
#import "XMAppThemeHelper.h"
#import "MHModuleModel.h"
#import "MHomeModule2View.h"

#define PADDING 20
#define MARGIN  35

#define ICON_WIDTH (SCREEN_WIDTH- PADDING -3*MARGIN)/3.5

@interface MHModule16Cell ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation MHModule16Cell

- (void)reloadData {
    
    if ( self.cellData ) {
        
        self.backgroundColor = Color_White;
        
        MHModuleModel *model = self.cellData;
        //model.header = nil;
        [self.scrollView removeFromSuperview];
        
        [self cellAddSubview:self.scrollView];
        
        [self cellAddSubview:self.lineView];
        [self cellAddSubview:self.titleLabel];
        [self cellAddSubview:self.pageControl];
        
        
        if (model.header) {
            self.titleLabel.text = model.header.title.text;
            [self.titleLabel sizeToFit];
            self.titleLabel.centerY = self.lineView.centerY;
            self.titleLabel.left = self.lineView.right + 12;
            
            self.lineView.backgroundColor = [UIColor colorWithHexString:model.header.bar.color];
            self.lineView.hidden = NO;
            
            self.scrollView.top = 45 + 12;
        }else{
            self.titleLabel.text = @"";
            self.lineView.hidden = YES;
            self.scrollView.top = 12;
        }
        
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        self.scrollView.height = ICON_WIDTH/item.ar * 2 + 48 + 10;
        
        int row = 0 ,column = 0;
        for (int i = 0; i<model.items.count; i++) {
            row = i % 2;
            column = i / 2;
            
            MHItemModel *item = [model.items safeObjectAtIndex:i];
            MHomeModule2View *module  = [[MHomeModule2View alloc] initWithFrame:CGRectMake(PADDING +(ICON_WIDTH+MARGIN)*column,(ICON_WIDTH+24+10)*row , ICON_WIDTH, ICON_WIDTH+24)];
            
            NSString *link = item.link?item.link:@"";
            NSString *title = item.title?item.title:@"";
            NSString *image = item.image?item.image:@"";
            
            [module reloadData:@{@"title":title,@"icon":image,@"link":link,@"iconWidth":@(ICON_WIDTH),@"iconHeight":@(ICON_WIDTH),@"placeholder":@"placeholder_s"}];
            //module.backgroundColor = Color_Green;
            [self.scrollView addSubview:module];
        }
        
        CGFloat width = 0;
        if (model.items.count > 0) {
            width = ceil(model.items.count/2. -1 )  * (ICON_WIDTH + MARGIN)+ICON_WIDTH + PADDING*2;
        }else{
            width = 0;
        }
        self.scrollView.contentSize = CGSizeMake(width, self.scrollView.height);
        //self.scrollView.backgroundColor = Color_Red;
        
        int page = ceil(self.scrollView.contentSize.width/SCREEN_WIDTH) ;
        self.pageControl.numberOfPages = page;
        [self.pageControl sizeToFit];
        self.pageControl.centerX = SCREEN_WIDTH / 2.0f;
        self.pageControl.bottom = [[self class] heightForCell:self.cellData];
        //self.pageControl.backgroundColor = Color_Blue;
    }else{
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
}


+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if ( cellData ) {
        MHModuleModel *ad = (MHModuleModel *)cellData;
        //ad.header = nil;
        if (ad.header) {
            height += 45;
        }
        MHItemModel *item = [ad.items safeObjectAtIndex:0];
        if (item) {
            height += 12 + ICON_WIDTH/item.ar * 2 + 48 +10 + 30;
        }
    }
    
    return height;
}

#pragma mark - Getters And Setters

- (UIScrollView*)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, 80 * 2 + 3 *12 + 40)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(20);
        label.textColor = Color_Gray100;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 18, 2, 15)];
        view.backgroundColor = RGB(255, 216, 86);
        _lineView = view;
    }
    return _lineView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = Color_Gray224;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSInteger current = self.pageControl.numberOfPages- ceil((scrollView.contentSize.width-offset.x)/SCREEN_WIDTH);
    self.pageControl.currentPage = current;
}

@end
