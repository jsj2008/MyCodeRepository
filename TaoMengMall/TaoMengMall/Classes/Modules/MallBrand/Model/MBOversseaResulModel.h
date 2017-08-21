//
//  MBOversseaResulModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/7.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MBOverseaModel.h"

@interface MBOversseaResulModel : BaseModel

@property (nonatomic,strong) NSArray<Optional,MBOverseaModel> *list;

@property (nonatomic,assign) BOOL isEnd;

@property (nonatomic,copy) NSString *wp;

@end
