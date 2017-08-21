//
//  DSDACertificateCell.h
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol DSDACertificateCellDelegate <NSObject>

- (void)addButtonTappedAtIndex:(NSInteger)index;

@end

@interface DSDACertificateCell : BaseTableViewCell
@property (nonatomic, weak) id<DSDACertificateCellDelegate> delegate;
@end
