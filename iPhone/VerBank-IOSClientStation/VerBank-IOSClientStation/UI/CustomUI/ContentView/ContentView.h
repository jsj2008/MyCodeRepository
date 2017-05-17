//
//  ContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/11.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define DEFAULT_SELECTEDCELL -1
extern NSInteger const _kDefaultSelectedCell;

@interface ContentView : UIView {
    UITableView *contentTableView;
//    NSArray *contentArray;
    
    NSInteger selectCellIndex;
    
    UILongPressGestureRecognizer * longPressGr;
    UITapGestureRecognizer * tapPressGr;
}

@property (atomic) NSArray *contentArray;

- (void)addLongPressGesture;
- (void)addOnePressGesture;

- (UILongPressGestureRecognizer *)newLongPressGestureRecognizer;

// 为了让子类 添加长按手势。
-(void)LongPressToDo:(UIGestureRecognizer *)gesture;
- (void)popCellLogic:(NSIndexPath *)indexPath;

@end
