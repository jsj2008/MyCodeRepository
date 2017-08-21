//
//  MHModule20Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "PMModuleCell.h"
#import "PMItemModel.h"
#import "PMModuleView.h"

#define PADDING 10.f
#define ICON_WIDTH ((SCREEN_WIDTH - 3 * PADDING) / 2)

@interface PMModuleCell ()


@property (nonatomic, strong) PMModuleView *leftItemView;
@property (nonatomic, strong) PMModuleView *rightItemView;
@property (nonatomic,strong) NSMutableArray *modules;

@end

@implementation PMModuleCell


- (void)reloadData {
    
    if ( self.cellData ) {
        [self cellAddSubview:self.leftItemView];
        [self cellAddSubview:self.rightItemView];
        
        NSMutableDictionary *items = (NSMutableDictionary *)self.cellData;
        
        PMItemModel *model = [items objectForKey:@"leftItem"];

        self.leftItemView.height = self.rightItemView.height = ICON_WIDTH / model.ar;
        
        [self.leftItemView reloadData:[items objectForKey:@"leftItem"]];
        
        [self.rightItemView reloadData:[items objectForKey:@"rightItem"]];
    }
}


+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        
        NSMutableDictionary *items = (NSMutableDictionary *)cellData;
        PMItemModel *itemModel = [items objectForKey:@"leftItem"];
        if (itemModel) {
            height = (ICON_WIDTH / itemModel.ar + 70) ;
        }
        
    }
    return height;
}

#pragma mark - Getters And Setters

- (PMModuleView *)leftItemView
{
    if ( !_leftItemView ) {
        
        _leftItemView = [[PMModuleView alloc] initWithFrame:CGRectMake(5, 0, CELL_WIDTH, 0)];
    }
    return _leftItemView;
}

- (PMModuleView *)rightItemView
{
    if ( !_rightItemView ) {
        
        _rightItemView = [[PMModuleView alloc] initWithFrame:CGRectMake(10 + CELL_WIDTH, 0, CELL_WIDTH,  0)];
    }
    return _rightItemView;
}
@end
