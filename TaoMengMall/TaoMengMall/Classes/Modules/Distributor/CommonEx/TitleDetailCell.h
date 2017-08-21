//
//  TitleDetailCell.h
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TitleDetailCell : BaseTableViewCell

@property (nonatomic, strong,readonly)UILabel *titleLabel;
@property (nonatomic, strong,readonly)UILabel *descLabel;

@property (nonatomic, assign) BOOL showMore;
@property (nonatomic, assign) BOOL showLine;
@end
