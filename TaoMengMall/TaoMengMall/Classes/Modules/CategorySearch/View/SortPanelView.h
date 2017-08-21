//
//  SortPanelView.h
//  HongBao
//
//  Created by marco on 5/10/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SortPanelView;

typedef NS_ENUM(NSUInteger, SortKind) {
    SortKindComprehensive  = 0,
    SortKindFromLowPrice   = 1,
    SortKindFromHighPrice  = 2,
    SortKindMarketFirst    = 3
};

typedef NS_ENUM(NSUInteger, CSDisplayMode) {
    CSDisplayModeSmall,
    CSDisplayModeBig,
};


@protocol SortPanelViewDelegate <NSObject>

- (void)sortPanelView:(SortPanelView *)panelView sortKindChanged:(SortKind)kind;
- (void)sortPanelView:(SortPanelView *)panelView dispalyModeChanged:(CSDisplayMode)mode;
@end

@interface SortPanelView : UIView <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) id<SortPanelViewDelegate> delegate;
@end
