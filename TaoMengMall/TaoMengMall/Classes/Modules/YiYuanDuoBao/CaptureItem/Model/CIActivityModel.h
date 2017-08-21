//
//  CIActivityModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "CIWinnerModel.h"

@interface CIActivityModel : BaseModel
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString <Optional>*allParticipantTimes;
@property (nonatomic, copy) NSString <Optional>*participantTimes;
@property (nonatomic, copy) NSString <Optional>*restParticipantTimes;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) NSString <Optional>*announceTime;
@property (nonatomic, strong) NSArray<CIWinnerModel,Optional> *winners;
@property (nonatomic, copy) NSString <Optional>*endTime;
@property (nonatomic, strong) NSString <Optional>*previousWinnersLink;
@end
