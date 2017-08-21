//
//  CIPrizeDetailResultModel.h
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "CIDetailContentModel.h"

@interface CIPrizeDetailResultModel : BaseModel

@property (nonatomic, strong) NSArray<CIDetailContentModel,Optional> *list;
@end
