//
//  DSUnavailableSumModel.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol DSUnavailableSumModel <NSObject>

@end

@interface DSUnavailableSumModel : BaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *amount;

@end
