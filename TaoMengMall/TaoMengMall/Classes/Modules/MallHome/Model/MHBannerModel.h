//
//  MHBannerModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface MHBannerModel : BaseModel
@property (nonatomic, strong) NSString <Optional>*cover;
@property (nonatomic, assign) CGFloat ar;
@property (nonatomic, strong) NSString <Optional>*link;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*desc;
@end
