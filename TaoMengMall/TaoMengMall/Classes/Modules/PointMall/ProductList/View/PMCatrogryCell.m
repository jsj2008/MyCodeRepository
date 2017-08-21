//
//  PMCatrogryCell.m
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import "PMCatrogryCell.h"
#import "PMCategoryModuleView.h"

#define PADDING 4
#define ITEMWITH (SCREEN_WIDTH-20-PADDING*2)/3

@interface PMCatrogryCell()

@property (nonatomic, strong) NSMutableArray *moduleViews;

@end

@implementation PMCatrogryCell

- (void)reloadData
{
    if (self.cellData) {
        NSArray *modules = (NSArray*)self.cellData;
        
        for (PMCategoryModuleView *moduleView in self.moduleViews) {
            [self cellAddSubview:moduleView];
        }
        for (int i = 0; i<9; i++) {
            PMCategoryModuleView *module = [self.moduleViews safeObjectAtIndex:i];
            [module reloadData:[modules safeObjectAtIndex:i]];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        NSArray *data = cellData;
        height = 20 + ITEMWITH/2 * ceil(data.count/3.0f) + 2 * PADDING;
    }
    return height;
}

- (NSMutableArray*)moduleViews
{
    if (!_moduleViews) {
    
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:9];
        
        int row,column = 0;
        for (int i = 0; i<9; i++) {
            row = i/3;
            column = i%3;
            PMCategoryModuleView *moduleView = [[PMCategoryModuleView alloc]initWithFrame:CGRectMake(0, 0, ITEMWITH, ITEMWITH/2)];
            moduleView.left = 10 + (ITEMWITH+PADDING)*column;
            moduleView.top = 10 + (PADDING+ITEMWITH/2)*row;
            [modules addObject:moduleView];
            moduleView.layer.cornerRadius = 3;
            moduleView.layer.masksToBounds = YES;

            
        }
        
        _moduleViews = modules;
    }
    return _moduleViews;
}


@end
