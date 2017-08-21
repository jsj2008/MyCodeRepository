//
//  CTDiscountInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol CTDiscountInfoModel

@end

@interface CTDiscountInfoModel : BaseModel

@property (nonatomic, strong) NSString *show;
@property (nonatomic, strong) NSString<Optional> *formula;

@end
