//
//  ODReturenPointResultModel.h
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/12.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "ODReturnPointTotalModel.h"
#import "ODReturnPointRecordModel.h"

@interface ODReturenPointResultModel : BaseModel

@property (nonatomic,strong) ODReturnPointTotalModel<Optional> *plan;

@property (nonatomic,strong) NSArray<Optional,ODReturnPointRecordModel> *list;

@property (nonatomic,assign) BOOL isEnd;
@property (nonatomic,strong) NSString *wp;
@end
