//
//  MHModule19Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule19Cell.h"
#import "MHModuleModel.h"
#import "MHomeModule2View.h"

#define PADDING 12
#define ICON_WIDTH 115

@interface MHModule19Cell ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *modules;
@end

@implementation MHModule19Cell


- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        
        [self.scrollView removeAllSubviews];
        [self cellAddSubview:self.scrollView];
        
        MHModuleModel *model = self.cellData;
        
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            self.scrollView.height = ICON_WIDTH / item.ar + 30 + 20;
        }
        
        _modules = [NSMutableArray array];
        for (int i = 0; i<model.items.count; i++) {
            MHItemModel *item = [model.items safeObjectAtIndex:i];
            NSString *link = @"";
            if (item.link) {
                link = item.link;
            }
            [self.modules addObject:@{@"title":item.title,@"icon":item.image,@"link":link,@"iconWidth":@(ICON_WIDTH),@"iconHeight":@(ICON_WIDTH / item.ar),@"desc":item.desc,@"placeholder":@"placeholder_h"}];
            
            CGFloat width = (SCREEN_WIDTH - PADDING) / 2 -PADDING;
            
            CGFloat height = width / item.ar + 30 + 20;
            
            MHomeModule2View *moduleView = [[MHomeModule2View alloc]initWithFrame:CGRectMake((ICON_WIDTH + PADDING) * i + PADDING, 0, ICON_WIDTH, height)];
            moduleView.textAlignment = NSTextAlignmentLeft;
            moduleView.font = FONT(16);
            [self.scrollView addSubview:moduleView];
            [moduleView reloadData:[self.modules safeObjectAtIndex:i]];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            height = ICON_WIDTH / item.ar +  2 * PADDING + 30 + 20;
        }
    }
    return height;
}

#pragma mark -Subviews
- (UIScrollView*)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,12, SCREEN_WIDTH, 196)];
        scrollView.backgroundColor = Color_White;
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}
@end
