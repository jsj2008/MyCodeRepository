//
//  RefundInfoModel.h
//  YouCai
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol RefundInfoModel <NSObject>

@end

@interface RefundInfoModel : BaseModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString<Optional> *desc;
@property (nonatomic, strong) NSArray<Optional> *images;
@end
