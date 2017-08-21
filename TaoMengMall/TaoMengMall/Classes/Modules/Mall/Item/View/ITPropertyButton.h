//
//  ITPropertyButton.h
//  HongBao
//
//  Created by Ivan on 16/2/12.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITPropertyKVModel.h"

@interface ITPropertyButton : UIButton

@property (nonatomic, strong, readonly) ITPropertyKVModel *propertyKV;

+ (ITPropertyButton *) buttonWithPropertyKV: (ITPropertyKVModel *)propertyKV;

@end
