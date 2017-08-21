//
//  LRStatusCell.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/14.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol LRStatusCellDelegate <NSObject>

- (void)handleBuyButttonWithModel:(id)model;

@end

@interface LRStatusCell : BaseTableViewCell
@property (nonatomic, weak) id <LRStatusCellDelegate>delegate;
@end
