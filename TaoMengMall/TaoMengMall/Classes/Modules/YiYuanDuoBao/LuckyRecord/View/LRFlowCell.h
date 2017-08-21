//
//  LLRFlowCell.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol LRFlowCellDelegate <NSObject>

- (void)handleRecieveButton;

@end

@interface LRFlowCell : BaseTableViewCell
@property (nonatomic, assign) BOOL isBegin;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, weak)id <LRFlowCellDelegate>delegate;
@end
