//
//  CIItemResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIActivityModel.h"
#import "CIParticipantModel.h"
#import "CIRecordModel.h"
#import "CIItemInfoModel.h"
#import "CIItemButtonModel.h"
#import "ShareInfoModel.h"

@interface CIItemResultModel : BaseModel
@property (nonatomic, strong) CIItemInfoModel *item;
@property (nonatomic, strong) CIActivityModel *activity;
@property (nonatomic, strong) CIParticipantModel <Optional>*participant;
@property (nonatomic, strong) CIRecordModel <Optional>*record;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL showBuy;
@property (nonatomic, strong) CIItemButtonModel <Optional>*button;
@property (nonatomic, assign) float singlePrice;
@property (nonatomic, strong) ShareInfoModel<Optional> *share;
@property (nonatomic, strong) NSString <Optional>*prizeDetailLink;
@end
