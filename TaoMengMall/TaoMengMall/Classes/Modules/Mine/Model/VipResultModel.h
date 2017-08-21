//
//  VipResultModel.h
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/17.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface VipResultModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *content;
@property (nonatomic,copy) NSString<Optional> *price;
@property (nonatomic,copy) NSString<Optional> *tip;
@property (nonatomic,assign) BOOL isVip;

@end
