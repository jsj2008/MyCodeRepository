//
//  MHModule24Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/24.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule24Cell.h"
#import "MHModuleModel.h"
#import "MHomeModule2View.h"

#define PADDING 12
#define ICON_WIDTH 64

@interface MHModule24Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSMutableArray *moduleViews;
@property (nonatomic, strong) NSMutableArray *modules;
@end

@implementation MHModule24Cell


- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        [self cellAddSubview:self.scrollView];
        [self cellAddSubview:self.titleLabel];
        [self cellAddSubview:self.descLabel];
        
        [self.scrollView removeAllSubviews];
        
        MHModuleModel *model = self.cellData;
        //model.header = nil;
        if (model.header) {
            self.titleLabel.text = model.header.title.text;
            [self.titleLabel sizeToFit];
            self.titleLabel.top = 12;
            self.titleLabel.left = 12;
            
            self.descLabel.text = model.header.title.desc;
            [self.descLabel sizeToFit];
            self.descLabel.centerY = self.titleLabel.centerY;
            self.descLabel.left = self.titleLabel.right + 4;
            
            self.scrollView.top = 30 +12;
        }else{
            self.titleLabel.text = @"";
            self.descLabel.text = @"";
            self.scrollView.top = 12;
        }
        
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            CGFloat height = ICON_WIDTH / item.ar;
            self.scrollView.height = height + 30;
            
            _modules = [NSMutableArray array];
            for (int i = 0; i<model.items.count; i++) {
                MHItemModel *item = [model.items safeObjectAtIndex:i];
                NSString *link = @"";
                if (item.link) {
                    link = item.link;
                }
                [self.modules addObject:@{@"title":item.title,@"icon":item.image,@"link":link,@"iconWidth":@(ICON_WIDTH),@"iconHeight":@(height),@"placeholder":@"placeholder_s"}];
                
                MHomeModule2View *module = [[MHomeModule2View alloc]initWithFrame:CGRectMake((ICON_WIDTH + PADDING) * i + PADDING, 0, ICON_WIDTH, height)];
                [module reloadData:[self.modules safeObjectAtIndex:i]];
                [self.scrollView addSubview:module];
            }
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
        if (model.header) {
            height += 30;
        }
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            height += 12 + ICON_WIDTH / item.ar + 30 + PADDING;
        }
        
    }
    return height;
}

#pragma mark -Subviews
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray100;
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(14);
        label.textColor = Color_Gray204;
        label.userInteractionEnabled = YES;
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            MHModuleModel *model = self.cellData;
            MHHeaderModel *header = model.header;
            [[TTNavigationService sharedService] openUrl:header.more.link];
        }];
        _descLabel = label;
    }
    return _descLabel;
}

- (UIScrollView*)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,30 + 12, SCREEN_WIDTH, 196)];
        scrollView.height = ICON_WIDTH / 0.77647 + 30;
        scrollView.backgroundColor = Color_White;
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}


//- (NSMutableArray*)moduleViews
//{
//    if (!_moduleViews) {
//        
//        MHModuleModel *model = self.cellData;
//        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:model.items.count];
//        //CGFloat width = (SCREEN_WIDTH - PADDING) / 2 -PADDING;
//        
//        
//        for (int i = 0; i<model.items.count; i++) {
//            MHItemModel *item = [model.items safeObjectAtIndex:i];
//            CGFloat height = ICON_WIDTH / 0.77647 + 30;
//            
//            MHomeModule2View *moduleView = [[MHomeModule2View alloc]initWithFrame:CGRectMake((ICON_WIDTH + PADDING) * i + PADDING, 0, ICON_WIDTH, height)];
//            
//            [modules addObject:moduleView];
//            [self.scrollView addSubview:moduleView];
//        }
//        
//        _moduleViews = modules;
//    }
//    return _moduleViews;
//}
@end

