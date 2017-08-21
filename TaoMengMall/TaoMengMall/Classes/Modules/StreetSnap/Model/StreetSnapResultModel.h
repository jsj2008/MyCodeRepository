//
//  StreetSnapResultModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "StreetSnapeBannerModel.h"

@interface StreetSnapResultModel : BaseModel

@property (nonatomic, strong) WallModel *items;

@property (nonatomic,strong) StreetSnapeBannerModel *banner;
//@property (nonatomic,copy) NSString *wp;
//@property (nonatomic,assign) BOOL isEnd;
@end
