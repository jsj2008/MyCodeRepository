//
//  LuckyRecordItemModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LuckyRecordStatusModel.h"

@protocol LuckyRecordItemModel <NSObject>

@end

@interface LuckyRecordItemModel : BaseModel

@property (nonatomic, strong) NSString *times;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *required;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString <Optional>*link;
@property (nonatomic, strong) LuckyRecordStatusModel <Optional>*status;

@end
