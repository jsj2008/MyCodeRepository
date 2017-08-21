//
//  ITSkuCoverModel.h
//  FlyLantern
//
//  Created by marco on 11/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseModel.h"

@protocol ITSkuCoverModel <NSObject>


@end

@interface ITSkuCoverModel : BaseModel

@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString *cover;
@end
