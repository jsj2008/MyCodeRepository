//
//  ConsigneeCell.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ConsigneeModel.h"

@protocol ConsigneeCellDelegate <NSObject>

- (void) defaultButtonDidTappedWithConsignee:(ConsigneeModel *)consignee;
- (void) editButtonDidTappedWithConsignee:(ConsigneeModel *)consignee;
- (void) deleteButtonDidTappedWithConsignee:(ConsigneeModel *)consignee;

@end

@interface ConsigneeCell : BaseTableViewCell

@property (nonatomic, weak) id<ConsigneeCellDelegate> delegate;

@end
