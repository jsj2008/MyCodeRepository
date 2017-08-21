//
//  MHModule03Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule03Cell.h"
#import "MHModuleModel.h"
#import "MHSingleImageView.h"

#define PADDING 12


@interface MHModule03Cell ()
@property (nonatomic, strong) NSMutableArray *moduleViews;
@property (nonatomic, strong) UIView *line;
@end

@implementation MHModule03Cell



- (void)reloadData
{
    
    if (self.cellData) {
        self.backgroundColor = Color_White;
        
        MHModuleModel *model = self.cellData;
        
        int row,column = 0;
        
        MHItemModel *firstItem = [model.items safeObjectAtIndex:0];
        CGFloat width = (SCREEN_WIDTH - PADDING) / 2.0f -PADDING;
        CGFloat height = width / firstItem.ar ;

        for (int i = 0; i<model.items.count; i++) {
            row = i/2;
            //column = i%2;

            MHItemModel *item = [model.items safeObjectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";
            
            MHSingleImageView *module = [self.moduleViews safeObjectAtIndex:i];
            module.top = 12 + (12 + height)*row;
            module.height = height;
            [module reloadData:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_w"}];
        }
    }else{
        [self removeAllSubviews];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    MHModuleModel *model = cellData;
    if (model.items.count) {
        int row = ceil(model.items.count/2.);
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        CGFloat width = (SCREEN_WIDTH - PADDING) / 2.0f -PADDING;
        height = 12 + (12 +width / item.ar)* row ;
    }
    return height;
}

- (NSMutableArray*)moduleViews
{
    if (!_moduleViews) {
        int row,column = 0;
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:4];
        CGFloat width = (SCREEN_WIDTH - PADDING) / 2.0f -PADDING;
        for (int i = 0; i<4; i++) {
            row = i/2;
            column = i%2;
            MHSingleImageView *moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(0, 0, width, 70)];
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
