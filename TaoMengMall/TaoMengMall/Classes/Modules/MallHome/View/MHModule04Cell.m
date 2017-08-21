//
//  MHModule04Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule04Cell.h"
#import "MHModuleModel.h"
#import "MHSingleImageView.h"

#define PADDING 12

@interface MHModule04Cell ()
@property (nonatomic, strong) NSMutableArray *moduleViews;
@property (nonatomic, strong) UIView *line;
@end

@implementation MHModule04Cell



- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        
        MHModuleModel *model = self.cellData;
        MHItemModel *firstItem = [model.items safeObjectAtIndex:0];

        CGFloat width = (SCREEN_WIDTH - PADDING) / 3 -PADDING;
        CGFloat height = width / firstItem.ar ;
        
        for (int i = 0; i<3; i++) {
            
            MHItemModel *item = [model.items safeObjectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";
            
            MHSingleImageView *module = [self.moduleViews safeObjectAtIndex:i];
            module.height = height;
            [module reloadData:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_h"}];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    MHModuleModel *model = cellData;
    if (model.items.count) {
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            CGFloat width = (SCREEN_WIDTH - PADDING) / 3 -PADDING;
            height = width / item.ar + 2 * PADDING;
        }
        
    }
    return height;
}

- (NSMutableArray*)moduleViews
{
    if (!_moduleViews) {
        
        int row,column = 0;
        
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:3];
        CGFloat width = (SCREEN_WIDTH - PADDING) / 3 -PADDING;
        
        for (int i = 0; i<3; i++) {
            row = i/3;
            column = i%3;
            MHSingleImageView *moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
            moduleView.left = PADDING + (width+PADDING)*column;
            moduleView.top = 12 + (12+0)*row;
            [modules addObject:moduleView];
            [self cellAddSubview:moduleView];
        }
        
        _moduleViews = modules;
    }
    return _moduleViews;
}

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

