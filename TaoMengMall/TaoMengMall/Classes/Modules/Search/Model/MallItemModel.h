//
//  MallItemModel.h
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/16.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol MallItemModel <NSObject>

@end

@interface MallItemModel : BaseModel
@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,copy) NSString<Optional> *title;
@property (nonatomic,copy) NSString<Optional> *desc;
@property (nonatomic,copy) NSString<Optional> *link;
@property (nonatomic,assign) CGFloat ar;
@end
