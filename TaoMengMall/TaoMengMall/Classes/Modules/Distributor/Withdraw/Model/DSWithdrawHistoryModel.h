//
//  DSWithdrawHistoryModel.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol DSWithdrawHistoryModel <NSObject>

@end

@interface DSWithdrawHistoryModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *link;

@end
