//
//  MineResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/12.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "MineOrderBadgeModel.h"

@protocol MineResultModel

@end

@interface MineResultModel : BaseModel

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *aboutLink;
@property (nonatomic, strong) NSString<Optional> *coins;
@property (nonatomic, strong) NSString *supportLink;
@property (nonatomic, strong) NSString *protocolLink;
@property (nonatomic,copy) NSString<Optional> *representLink;
//@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) MineOrderBadgeModel<Optional> *orderPendingCount;
@property (nonatomic, assign) BOOL showLuck;
@property (nonatomic,copy) NSString<Optional> *address;
@end
