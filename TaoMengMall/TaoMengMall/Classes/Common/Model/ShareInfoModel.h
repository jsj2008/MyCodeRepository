//
//  ShareInfoModel.h
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol ShareInfoModel <NSObject>

@end

@interface ShareInfoModel : BaseModel
@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareDesc;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *shareImg;
@end
