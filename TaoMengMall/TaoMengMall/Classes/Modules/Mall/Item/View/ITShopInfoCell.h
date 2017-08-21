//
//  ITShopInfoCell.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol ITShopInfoCellDelegate <NSObject>

- (void)addFavButtonDidTapped:(UIButton*)sender;
- (void)cancelFavButtonDidTapped:(UIButton*)sender;
@end

@interface ITShopInfoCell : BaseTableViewCell
@property (nonatomic, strong)id<ITShopInfoCellDelegate> delegate;
@end
