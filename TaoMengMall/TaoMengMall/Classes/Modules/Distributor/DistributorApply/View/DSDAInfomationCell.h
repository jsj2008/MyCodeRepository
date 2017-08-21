//
//  DSDAInfomationCell.h
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol DSDAInfomationCellDelegate <NSObject>

- (void)textFieldDidChanged;
@end

@interface DSDAInfomationCell : BaseTableViewCell
@property (nonatomic, weak) id<DSDAInfomationCellDelegate> delegate;
@end
