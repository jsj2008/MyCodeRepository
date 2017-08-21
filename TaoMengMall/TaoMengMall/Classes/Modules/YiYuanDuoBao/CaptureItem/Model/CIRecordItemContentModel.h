//
//  CIRecordItemContentModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol CIRecordItemContentModel <NSObject>

@end

@interface CIRecordItemContentModel : BaseModel
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *time;
@end
