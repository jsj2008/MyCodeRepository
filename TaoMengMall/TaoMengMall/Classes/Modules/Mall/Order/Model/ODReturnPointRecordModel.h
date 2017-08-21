//
//  ODReturnPointRecordModel.h
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/12.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol ODReturnPointRecordModel <NSObject>

@end

@interface ODReturnPointRecordModel : BaseModel

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *amount;
@end
