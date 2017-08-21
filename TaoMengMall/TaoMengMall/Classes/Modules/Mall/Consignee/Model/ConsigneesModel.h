//
//  ConsigneesModel.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ConsigneeModel.h"

@protocol ConsigneesModel

@end

@interface ConsigneesModel : BaseModel

@property (nonatomic, strong) NSArray<ConsigneeModel> *list;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSString *wp;

@end
