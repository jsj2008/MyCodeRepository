//
//  RVSkuRateCell.h
//  FlyLantern
//
//  Created by marco on 18/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseTableViewCell.h"

extern NSString *const kNOTIFY_PROOF_IMAGE_UPDATE;

@class RVSkuRateCell;

@protocol RVSkuRateCellDelegate <NSObject>

- (void)addImageTapped:(RVSkuRateCell*)cell;

@end

@interface RVSkuRateCell : BaseTableViewCell

@property (nonatomic, weak) id<RVSkuRateCellDelegate> delegate;
@end
