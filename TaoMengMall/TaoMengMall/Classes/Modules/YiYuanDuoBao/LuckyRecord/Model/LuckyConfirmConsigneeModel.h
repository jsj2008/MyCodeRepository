//
//  LuckyConfirmConsigneeModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface LuckyConfirmConsigneeModel : BaseModel
@property (nonatomic, strong) NSString <Optional>*consigneeId;
@property (nonatomic, strong) NSString <Optional>*uname;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *address;
@end
