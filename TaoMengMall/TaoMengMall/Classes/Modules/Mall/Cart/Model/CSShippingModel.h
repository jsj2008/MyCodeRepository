//
//  CSShippingModel.h
//  LianWei
//
//  Created by marco on 8/5/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol CSShippingModel <NSObject>

@end


@interface CSShippingModel : BaseModel
@property (nonatomic, strong) NSString  *shippingId;
@property (nonatomic, strong) NSString  *content;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString<Optional> *shipType;

@end
