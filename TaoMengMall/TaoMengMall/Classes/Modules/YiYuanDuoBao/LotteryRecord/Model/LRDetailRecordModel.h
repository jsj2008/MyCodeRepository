//
//  LRDetailRecordModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/14.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol LRDetailRecordModel <NSObject>


@end

@interface LRDetailRecordModel : BaseModel
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *link;
@end
