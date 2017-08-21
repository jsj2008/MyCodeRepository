//
//  CIPayResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/17.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface CIPayResultModel : BaseModel
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *numbers;
@property (nonatomic, strong) NSString *itemCount;
@property (nonatomic, strong) NSString *times;
@end
