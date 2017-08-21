//
//  ITItemInfoCell.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseTableViewCell.h"

@class ITItemInfoCell;

@protocol ITItemInfoCellDelegate <NSObject>

- (void)cell:(ITItemInfoCell*)cell shareButtonTapped:(id)model;

@end

@interface ITItemInfoCell : BaseTableViewCell
@property (nonatomic, assign) BOOL showShare;
@property (nonatomic, weak)id<ITItemInfoCellDelegate> delegate;
@end
