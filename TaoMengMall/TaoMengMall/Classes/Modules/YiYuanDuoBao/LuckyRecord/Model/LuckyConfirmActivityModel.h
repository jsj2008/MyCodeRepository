//
//  LuckyConfirmActivityModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface LuckyConfirmActivityModel : BaseModel
@property (nonatomic, strong) NSString *maxThreshold;
@property (nonatomic, strong) NSString *currentThreshold;
@property (nonatomic, strong) NSString *announceTime;
@property (nonatomic, strong) NSString *prizeId;
@end
