//
//  CIRecordItemModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "CIRecordItemContentModel.h"

@protocol  CIRecordItemModel<NSObject>


@end

@interface CIRecordItemModel : BaseModel
@property (nonatomic, strong) NSString <Optional>*head;
@property (nonatomic, strong) CIRecordItemContentModel *content;
@end
