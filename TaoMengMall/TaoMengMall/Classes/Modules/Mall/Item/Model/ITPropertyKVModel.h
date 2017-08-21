//
//  ITPropertyKVModel.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ITPropertyKVModel

@end

@interface ITPropertyKVModel : BaseModel

@property (nonatomic, strong) NSString *k;
@property (nonatomic, strong) NSString *v;

@end
