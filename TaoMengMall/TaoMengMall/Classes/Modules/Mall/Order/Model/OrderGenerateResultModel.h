//
//  OrderGenerateResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol OrderGenerateResultModel

@end

@interface OrderGenerateResultModel : BaseModel

@property (nonatomic, strong) NSString *payLink;

@end