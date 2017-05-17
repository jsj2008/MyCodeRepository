//
//  FreezeTableView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "QuoteItem.h"

#define UP 1
#define DOWN -1
#define NORMAL 0

//typedef NS_ENUM(NSUInteger, SortColumnType) {
//    SortColumnTypeInteger,
//    SortColumnTypeFloat,
//    SortColumnTypeDate,
//};

typedef NS_ENUM(NSUInteger, FreezeTableState) {
    Landscape,
    PortraitNormal,
    PortraitPoped,
    PortraitNormalForce,
    PortraitPopedForce,
};

@protocol FreezeTableViewDataSource;

@interface FreezeTableView : UIView

@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat topHeaderHeight;
@property (nonatomic, assign) CGFloat leftHeaderWidth;
@property (nonatomic, assign) CGFloat boldSeperatorLineWidth;
@property (nonatomic, assign) CGFloat normalSeperatorVLineWidth;
@property (nonatomic, assign) CGFloat normalSeperatorHLineWidth;

@property (nonatomic, strong) UIColor *boldSeperatorLineColor;
@property (nonatomic, strong) UIColor *normalSeperatorLineColor;

@property (nonatomic, assign) BOOL leftHeaderEnable;

@property (nonatomic, weak) id<FreezeTableViewDataSource> datasource;

- (void)reloadData;
- (void)updateCellQuoteAtIndex:(int)index;

- (void)addLongPressGesture;
- (void)removeLongPressGesture;
- (void)addTapPressGesture;
- (void)removeTapPressGesture;
- (void)hiddenCell;

- (void)setFreezeTableViewState:(int)state;

@end

@protocol FreezeTableViewDataSource <NSObject>

@required
- (NSArray *)arrayDataForTopHeader;
- (NSArray *)arrayDataForContent;


@optional
- (CGFloat)tableView:(FreezeTableView *)tableView contentTableCellWidth:(NSUInteger)column;
@end