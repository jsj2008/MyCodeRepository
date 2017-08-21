//
//  CSPlatformCouponModel.h
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol CSPlatformCouponModel <NSObject>

@end

@interface CSPlatformCouponModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *platformCouponId;


//本地使用
@property (nonatomic, assign) BOOL selected;
@end
