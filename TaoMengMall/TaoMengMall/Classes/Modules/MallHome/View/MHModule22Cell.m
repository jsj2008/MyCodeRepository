//
//  MHModule22Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/24.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule22Cell.h"
#import "MHomeModuleView.h"
#import "MHModuleModel.h"

#define PADDING (SCREEN_WIDTH-70*4)/5

@interface MHModule22Cell ()
@property (nonatomic, strong) NSMutableArray *modules;
@property (nonatomic, strong) UIView *line;
@end

@implementation MHModule22Cell


- (void)reloadData
{
    self.modules = [NSMutableArray array];
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        //self.backgroundColor = Color_Red;

        [self removeAllSubviews];
        
        MHModuleModel *model = self.cellData;
        int row,column = 0;
        MHItemModel *first = [model.items safeObjectAtIndex:0];
        CGFloat ar = first.ar;

        for (int i = 0; i<model.items.count; i++) {
            
            row = i/4;
            column = i%4;
            
            MHItemModel *item = [model.items safeObjectAtIndex:i];
            NSString *link = @"";
            if (item.link) {
                link = item.link;
            }
            [self.modules addObject:@{@"title":item.title,@"icon":item.image,@"link":link,@"ar":@(ar),@"placeholder":@"placeholder_s"}];
            
            MHomeModuleView *moduleView = [[MHomeModuleView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
            moduleView.left = PADDING + (70+PADDING)*column;
            moduleView.top = 20 + (20+70)*row;
            [moduleView reloadData:[self.modules safeObjectAtIndex:i]];
            [self cellAddSubview:moduleView];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        int row = (int)model.items.count/4;
        height = 20 + (20+70)*row;
    }
    return height;
}

//- (NSMutableArray*)moduleViews
//{
//    if (!_moduleViews) {
//        
//        int row,column = 0;
//        
//        MHModuleModel *model = self.cellData;
//        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:model.items.count];
//        for (int i = 0; i<model.items.count; i++) {
//            row = i/4;
//            column = i%4;
//            MHomeModuleView *moduleView = [[MHomeModuleView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
//            moduleView.left = PADDING + (70+PADDING)*column;
//            moduleView.top = 20 + (20+70)*row;
//            [modules addObject:moduleView];
//        }
//        
//        _moduleViews = modules;
//    }
//    return _moduleViews;
//}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 210;
        _line = view;
    }
    return _line;
}
@end
