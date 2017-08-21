//
//  ReviewInfoModel.h
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseModel.h"

@interface ReviewInfoModel : BaseModel

@property (nonatomic, strong) NSString *skuId;
@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *d;

@property (nonatomic, assign) BOOL anonymous;

@property (nonatomic, strong) NSString<Optional> *comment;

//本地使用
@property (nonatomic, strong) NSMutableArray<Ignore> *imageObjs;

@end
