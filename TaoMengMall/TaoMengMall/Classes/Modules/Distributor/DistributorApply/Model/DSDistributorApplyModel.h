//
//  DSDistributorApplyModel.h
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface DSDistributorApplyModel : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSDictionary *frontImageObj;
@property (nonatomic, strong) NSDictionary *backImageObj;

@end
