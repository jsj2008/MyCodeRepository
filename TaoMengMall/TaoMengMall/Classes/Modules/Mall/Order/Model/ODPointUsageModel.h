//
//  ODPointUsageModel.h
//  FlyLantern
//
//  Created by marco on 15/05/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol ODPointUsageModel <NSObject>

@end

@interface ODPointUsageModel : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

@end
