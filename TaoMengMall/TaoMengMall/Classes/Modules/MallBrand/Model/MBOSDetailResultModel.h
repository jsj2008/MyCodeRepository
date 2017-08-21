//
//  MBOSDetailResultModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/7.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MBOSDetailTitleModel.h"

@interface MBOSDetailResultModel : BaseModel

@property (nonatomic,strong) MBOSDetailTitleModel<Optional> *header;
@property (nonatomic, strong) WallModel *items;

@property (nonatomic,copy) NSString<Optional> *title;

@end
