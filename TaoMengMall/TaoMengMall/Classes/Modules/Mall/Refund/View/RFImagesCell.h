//
//  RFImagesCell.h
//  YouCai
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseTableViewCell.h"

@class RFImagesCell;
@protocol RFImagesCell <NSObject>

- (void)addImageTapped:(RFImagesCell*)cell;
- (void)deleteImageTappedWithIndex:(NSInteger)index;
@end


@interface RFImagesCell : BaseTableViewCell
@property (nonatomic, weak)id<RFImagesCell> delegate;
@end
