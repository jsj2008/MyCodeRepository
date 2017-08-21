//
//  CIWinnerModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol CIWinnerModel <NSObject>

@end

@interface CIWinnerModel : BaseModel

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *participantTimes;
@property (nonatomic, strong) NSString *luckNumber;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString <Optional>*announceTime;

@end
