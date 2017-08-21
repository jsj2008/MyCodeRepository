//
//  MBOverseaModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/7.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol MBOverseaModel


@end

@interface MBOverseaModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *title;
@property (nonatomic,copy) NSString<Optional> *address;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) CGFloat ar;

@end
