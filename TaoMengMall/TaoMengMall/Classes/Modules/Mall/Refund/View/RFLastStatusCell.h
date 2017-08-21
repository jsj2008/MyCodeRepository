//
//  RFLastStatusCell.h
//  Refound
//
//  Created by marco on 6/6/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol RFLastStatusCell <NSObject>

- (void)cancelButtonTapped;
- (void)applyButtonTapped;
- (void)recordButtonTapped;

@end

@interface RFLastStatusCell : BaseTableViewCell

@property (nonatomic, weak) id<RFLastStatusCell> delegate;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *expireTime;
@end
