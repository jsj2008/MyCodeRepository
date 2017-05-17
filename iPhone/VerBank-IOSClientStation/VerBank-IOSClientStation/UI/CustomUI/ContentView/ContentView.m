//
//  ContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/11.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ContentView.h"
#import "IosLayoutDefine.h"
#import "UIColor+CustomColor.h"

NSInteger const _kDefaultSelectedCell = -1;

@implementation ContentView

@synthesize contentArray;

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initPressGesture];
        [self initContentTableView];
    }
    return self;
}

- (void)initContentTableView {
    contentTableView = [[UITableView alloc] init];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    [contentTableView setBackgroundColor:[UIColor backgroundColor]];
}

- (void)initPressGesture{
    longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressToDo:)];
    longPressGr.minimumPressDuration = 0.8;
    
    tapPressGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapPressToDo:)];
}

- (UILongPressGestureRecognizer *)newLongPressGestureRecognizer {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressToDo:)];
    longPressGr.minimumPressDuration = 0.8;
    return longPress;
}


#pragma PressGesture
- (void)addLongPressGesture{
    [contentTableView addGestureRecognizer:longPressGr];
}
- (void)removeLongPressGesture{
    [contentTableView removeGestureRecognizer:longPressGr];
}

- (void)addOnePressGesture{
    [contentTableView addGestureRecognizer:tapPressGr];
}
- (void)removeOnePressGesture{
    [contentTableView removeGestureRecognizer:tapPressGr];
}

-(void)LongPressToDo:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:contentTableView];
        NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        [self popCellLogic:indexPath];
    }
}

-(void)TapPressToDo:(UIGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:contentTableView];
    NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
    if(indexPath == nil) return ;
    [self popCellLogic:indexPath];
}

#pragma popCell

- (void)popCellLogic:(NSIndexPath *)indexPath{
    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
    
    if (selectCellIndex == _kDefaultSelectedCell) {
        selectCellIndex = [indexPath row];
        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    } else if(selectCellIndex == [indexPath row]){
        selectCellIndex = _kDefaultSelectedCell;
        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    } else if(selectCellIndex > [indexPath row]){
        int temp = (int)selectCellIndex;
        selectCellIndex = [indexPath row];
        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
        NSMutableArray *preReloadArray = [[NSMutableArray alloc] init];
        [preReloadArray addObject:[NSIndexPath indexPathForRow:temp inSection:0]];
        [contentTableView reloadRowsAtIndexPaths:preReloadArray withRowAnimation:UITableViewRowAnimationNone];
    } else if(selectCellIndex < [indexPath row]){
        [reloadArray addObject:[NSIndexPath indexPathForRow:selectCellIndex inSection:0]];
        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
        selectCellIndex = [indexPath row];
    }
    
    [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
}

- (void)dealloc{
    [self removeLongPressGesture];
    [self removeOnePressGesture];
}

@end
