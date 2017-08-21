//
//  MHModule14Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule14Cell.h"
#import "XMAppThemeHelper.h"
#import "MHModuleModel.h"
#import "MHomeModule2View.h"
#import "MHSingleImageView.h"

#define PADDING 12
#define ICON_WIDTH 85

@interface MHModule14Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) MHSingleImageView *coverView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *moduleViews;
@property (nonatomic, strong) NSMutableArray *modules;
@end

@implementation MHModule14Cell


- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        
        [self cellAddSubview:self.scrollView];
        [self cellAddSubview:self.lineView];
        [self cellAddSubview:self.titleLabel];
        [self cellAddSubview:self.coverView];
        [self.scrollView removeAllSubviews];
        
        MHModuleModel *model = self.cellData;
        //model.header = nil;
        //model.banner = nil;
        if (model.header) {
            self.titleLabel.text = model.header.title.text;
            [self.titleLabel sizeToFit];
            self.titleLabel.centerY = self.lineView.centerY;
            self.titleLabel.left = self.lineView.right + 12;
            
            self.lineView.backgroundColor = [UIColor colorWithHexString:model.header.bar.color];
            self.lineView.hidden = NO;
            
            self.coverView.top = 45 + PADDING;
        }else{
            self.lineView.hidden = YES;
            self.titleLabel.text = @"";
            
            self.coverView.top = PADDING;
        }
        
        if (model.banner) {
            self.coverView.hidden = NO;
            self.coverView.width = SCREEN_WIDTH - 24;
            self.coverView.height = (SCREEN_WIDTH - 24) / model.banner.ar;
            [self.coverView reloadData:@{@"link":model.banner.link?model.banner.link:@"",@"icon":model.banner.cover?model.banner.cover:@"",@"placeholder":@"placeholder_w"}];
            
            self.scrollView.top = self.coverView.bottom + 12;
            
        }else{
            self.coverView.hidden = YES;
            self.scrollView.top = self.coverView.top;
        }
        
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            self.scrollView.height = ICON_WIDTH / item.ar + 30;
            
            _modules = [NSMutableArray array];
            for (int i = 0; i<model.items.count; i++) {
                MHItemModel *item = [model.items safeObjectAtIndex:i];
                NSString *link = @"";
                if (item.link) {
                    link = item.link;
                }
                [self.modules addObject:@{@"desc":item.title,@"icon":item.image,@"link":link,@"iconWidth":@(ICON_WIDTH),@"iconHeight":@(ICON_WIDTH / item.ar),@"placeholder":@"placeholder_s"}];
                
                CGFloat width = (SCREEN_WIDTH - PADDING) / 2 -PADDING;
                
                CGFloat height = width / item.ar + 30;
                
                MHomeModule2View *moduleView = [[MHomeModule2View alloc]initWithFrame:CGRectMake((ICON_WIDTH + PADDING) * i + PADDING, 0, ICON_WIDTH, height)];
                
                [moduleView reloadData:[self.modules safeObjectAtIndex:i]];
                [self.scrollView addSubview:moduleView];
            }
            self.scrollView.contentSize = CGSizeMake((ICON_WIDTH + PADDING) * model.items.count + 12, self.scrollView.height);
            self.scrollView.hidden = NO;
        }else{
            self.scrollView.hidden = YES;
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        //model.header = nil;
        //model.banner = nil;
        if (model.header) {
            height += 45;
        }
        if (model.banner) {
            height +=  PADDING+(SCREEN_WIDTH - 2 *PADDING) / model.banner.ar;
        }
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            height += ICON_WIDTH / item.ar + 30 + PADDING;
        }
        height += PADDING;
    }
    return height;
}

#pragma mark - Subviews
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

- (MHSingleImageView *)coverView{
    if (!_coverView) {
        MHSingleImageView *imageView = [[MHSingleImageView alloc] initWithFrame:CGRectMake(12, 32+12, 0, 0)];
        
        _coverView = imageView;
    }
    return _coverView;
}

- (UIScrollView*)scrollView{
    if (!_scrollView) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.coverView.bottom + 12, SCREEN_WIDTH, 196)];
        scrollView.backgroundColor = Color_White;
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}
@end
