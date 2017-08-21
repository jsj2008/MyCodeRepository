//
//  LuckyHistoryContentModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface LuckyHistoryContentModel : BaseModel
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *luckyNumber;
@property (nonatomic, strong) NSString *currentThreshold;
@end
