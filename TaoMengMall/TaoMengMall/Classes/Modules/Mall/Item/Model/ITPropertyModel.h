//
//  ITPropertyModel.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ITPropertyKVModel.h"

@protocol ITPropertyModel

@end

@interface ITPropertyModel : BaseModel

@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSArray<ITPropertyKVModel> *propertyValueList;

@end
