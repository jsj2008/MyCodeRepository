//
//  PMItemModel.h
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol PMItemModel <NSObject>


@end

@interface PMItemModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,copy) NSString<Optional> *title;
@property (nonatomic,copy) NSString<Optional> *desc;
@property (nonatomic,copy) NSString<Optional> *link;
@property (nonatomic,assign) CGFloat ar;

@end
