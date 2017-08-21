//
//  MCItemModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol MCItemModel <NSObject>


@end

@interface MCItemModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *id;
@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,copy) NSString<Optional> *name;
@property (nonatomic,copy) NSString<Optional> *price;
@property (nonatomic,copy) NSString<Optional> *oPrice;
@property (nonatomic,copy) NSString<Optional> *link;
@property (nonatomic,copy) NSString<Optional> *similarLink;
@property (nonatomic,copy) NSString<Optional> *error;
@property (nonatomic,assign) BOOL xxSelected;

@end
