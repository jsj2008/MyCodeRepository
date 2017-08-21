//
//  ITCoverImageCell.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol ITCoverImageCellDelegate <NSObject>

- (void)didTapCoverAtIndex:(NSInteger)index;

@end


@interface ITCoverImageCell : BaseTableViewCell

@property (nonatomic, weak) id<ITCoverImageCellDelegate> delegate;

- (void)scrollToCoverAtIndex:(NSInteger)index;
@end
