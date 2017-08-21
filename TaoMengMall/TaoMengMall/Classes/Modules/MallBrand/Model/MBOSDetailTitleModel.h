//
//  MBOSDetailTitleModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/7.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface MBOSDetailTitleModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *desc;
@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,assign) CGFloat ar;

@end
