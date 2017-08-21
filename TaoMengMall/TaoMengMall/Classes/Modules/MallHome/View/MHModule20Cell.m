//
//  MHModule20Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule20Cell.h"
#import "MHModuleModel.h"
#import "MHModule20View.h"

#define PADDING 10.f
#define ICON_WIDTH ((SCREEN_WIDTH - 3 * PADDING) / 2)

@interface MHModule20Cell ()


@property (nonatomic, strong) MHModule20View *leftItemView;
@property (nonatomic, strong) MHModule20View *rightItemView;
@property (nonatomic,strong) NSMutableArray *modules;

@end

@implementation MHModule20Cell


- (void)reloadData {
    
    if ( self.cellData ) {
        [self cellAddSubview:self.leftItemView];
        [self cellAddSubview:self.rightItemView];

        NSMutableDictionary *items = (NSMutableDictionary *)self.cellData;
        
        MHItemModel *model = [items objectForKey:@"leftItem"];
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
        MHItemModel *itemModel = [items objectForKey:@"leftItem"];
        
        if (itemModel) {
            height = (ICON_WIDTH / itemModel.ar + 70) ;
        }
        
    }
    return height;
}

#pragma mark - Getters And Setters

- (MHModule20View *)leftItemView
{
    if ( !_leftItemView ) {
        
        _leftItemView = [[MHModule20View alloc] initWithFrame:CGRectMake(5, 0, CELL_WIDTH, 0)];
    }
    return _leftItemView;
}

- (MHModule20View *)rightItemView
{
    if ( !_rightItemView ) {
        
        _rightItemView = [[MHModule20View alloc] initWithFrame:CGRectMake(10 + CELL_WIDTH, 0, CELL_WIDTH,  0)];
    }
    return _rightItemView;
}
@end
