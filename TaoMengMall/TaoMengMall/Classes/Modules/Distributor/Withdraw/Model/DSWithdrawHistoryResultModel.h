//
//  DSWithdrawHistoryResultModel.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSWithdrawHistoryModel.h"

@interface DSWithdrawHistoryResultModel : BaseModel

@property (nonatomic, strong) NSArray<DSWithdrawHistoryModel,Optional> *list;
@property (nonatomic, strong) NSString *wp;
@property (nonatomic, assign) BOOL isEnd;
@end
