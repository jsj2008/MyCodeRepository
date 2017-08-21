//
//  StreetSnapItemCell.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "StreetSnapItemCell.h"
#import "StreetSnapeItemView.h"

#define margin 10.0f
@interface StreetSnapItemCell()

@property (nonatomic, strong) NSMutableArray *moduleViews;


@end

@implementation StreetSnapItemCell

- (void)drawCell
{
    
}

- (void)reloadData
{
    if (self.cellData) {
        
        for (StreetSnapeItemView *moduleView in self.moduleViews) {
            [self cellAddSubView:moduleView];
        }
        
        NSArray *modules = (NSArray*)self.cellData;
        for (int i = 0; i<8; i++) {
            StreetSnapeItemView *module = [self.moduleViews safeObjectAtIndex:i];
            [module reloadData:[modules safeObjectAtIndex:i]];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        NSArray *modules = (NSArray*)cellData;
        WallItemModel *model = [modules safeObjectAtIndex:0];
        height = 10 +(SCREEN_WIDTH-4*margin)/3/model.image.ar + 6 + 30;
    }
    return height;
}

- (NSMutableArray*)moduleViews
{
    if (!_moduleViews) {
        NSArray *data = (NSArray*)self.cellData;
        WallItemModel *model = [data safeObjectAtIndex:0];
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:8];
        
        int row,column = 0;
        for (int i = 0; i<3; i++) {
            //row = i/3;
            column = i%3;
            StreetSnapeItemView *moduleView = [[StreetSnapeItemView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-4*margin)/3, (SCREEN_WIDTH-4*margin)/3/model.image.ar)];
            moduleView.left = 10 + ((SCREEN_WIDTH-4*margin)/3+10)*column;
            moduleView.top = 10;
            [modules addObject:moduleView];
        }
        
        _moduleViews = modules;
    }
    return _moduleViews;
}

@end
