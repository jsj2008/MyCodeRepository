//
//  MHModule05Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule05Cell.h"
#import "MHomeModuleView.h"
#import "MHModuleModel.h"

#define PADDING (SCREEN_WIDTH-70*4)/5

@interface MHModule05Cell ()
@property (nonatomic, strong) NSMutableArray *moduleViews;
@property (nonatomic, strong) UIView *line;
@end

@implementation MHModule05Cell



- (void)reloadData
{
    if (self.cellData) {
        self.backgroundColor = Color_White;
        
        MHModuleModel *model = self.cellData;
        
        for (int i = 0; i<4; i++) {
            MHItemModel *item = [model.items safeObjectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *title = item.title?item.title:@"";
            NSString *image = item.image?item.image:@"";

            MHomeModuleView *module = [self.moduleViews safeObjectAtIndex:i];
            [module reloadData:@{@"title":title,@"icon":image,@"link":link}];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    MHModuleModel *model = cellData;
    if (model.items.count) {
        int row = ceil(model.items.count/4.);
        height = 12 + (12+70)*row;
    }
    return height;
}

- (NSMutableArray*)moduleViews
{
    if (!_moduleViews) {
        
        int row,column = 0;
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:4];
        
        for (int i = 0; i<4; i++) {
            row = i/4;
            column = i%4;
            MHomeModuleView *moduleView = [[MHomeModuleView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
            moduleView.left = PADDING + (70+PADDING)*column;
            moduleView.top = 12 + (12+70)*row;
            moduleView.iconImageView.layer.cornerRadius = 35;
            moduleView.iconImageView.layer.masksToBounds = YES;
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
