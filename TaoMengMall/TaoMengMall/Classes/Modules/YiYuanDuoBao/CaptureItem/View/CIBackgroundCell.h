//
//  CPBackgroundCell.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol CIBackgroundCellDelegate <NSObject>

- (void)handleContinueButton;
- (void)handleRecordButton;

@end

@interface CIBackgroundCell : BaseTableViewCell

@property (nonatomic, assign) id<CIBackgroundCellDelegate> delegate;

@end
