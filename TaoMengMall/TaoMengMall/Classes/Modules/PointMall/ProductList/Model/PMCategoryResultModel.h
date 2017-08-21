//
//  PMCategoryResultModel.h
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "PMItemModel.h"
@interface PMCategoryResultModel : BaseModel

@property (nonatomic,strong) NSArray<PMItemModel> *list;
@property (nonatomic,copy) NSString *wp;
@property (nonatomic,assign) BOOL isEnd;
@property (nonatomic,copy) NSString<Optional> *title;
@end
