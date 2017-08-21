//
//  MallResultModel.h
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/16.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MallItemModel.h"

@interface MallResultModel : BaseModel
@property (nonatomic,strong) NSArray<MallItemModel> *list;
@property (nonatomic,copy) NSString *wp;
@property (nonatomic,assign) BOOL isEnd;
@end
