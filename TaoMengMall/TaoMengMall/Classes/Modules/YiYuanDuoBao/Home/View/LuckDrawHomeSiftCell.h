//
//  DHChildSiftCell.h
//  BabyDaily
//
//  Created by marco on 9/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@protocol LuckDrawHomeSiftCellDelegate <NSObject>

- (void)siftTypeChange:(NSString*)type;

@end

@interface LuckDrawHomeSiftCell : BaseCollectionViewCell
@property (nonatomic, weak) id<LuckDrawHomeSiftCellDelegate> delegate;
@end
