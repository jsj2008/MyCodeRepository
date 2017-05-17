//
//  TradeContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/25.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOSLayoutDefine.h"
#import "TradeViewShowUtils.h"
#import "LangCaptain.h"
#import "SinglePageView.h"

#import "ClientAPI.h"
#import "TradeApi.h"
#import "UIView+AddLine.h"
#import "ClosePositionDetails.h"
#import "DecimalUtil.h"
#import "APIDoc.h"

#import "TimeUtil.h"

#import "LayoutCenter.h"
#import "JumpDataCenter.h"
#import "TradeContentViewProtocol.h"
#import "ListenerProtocol.h"

#define CellSubViewTag 200

//#define WeekSecInterval 7 * 24 * 60 * 60

@interface TradeContentView : SinglePageView<TradeContentViewProtocol,ListenerProtocol> {
//    NSUInteger _currentIndex;
//    NSArray *_selectArray;
}

@property UIView *contentTopView;
@property UITableView *contentTableView;

@property UIView *leftTopView;
@property UITableView *leftTableView;

@property UIScrollView *contentScrollView;

@property NSMutableArray *contentArray;

@property CGFloat topBarHeight;
@property CGFloat cellHeight;

//- (UITableViewCell *)getTableViewCell:(NSString *)cellIndentifier andNibName:(NSString *)nibName;

- (UITableViewCell *)getContentTableViewCell;
- (UITableViewCell *)getLeftTableViewCell;

- (NSIndexPath *)getIndexPathOfGesture:(UIGestureRecognizer *)gesture;

- (void)updateSelectIndex;

- (void)initData;

- (void)selectNewIndex:(NSArray *)indexArray;

@end


