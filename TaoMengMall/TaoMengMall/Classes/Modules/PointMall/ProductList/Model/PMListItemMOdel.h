//
//  PMListItemMOdel.h
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "PMItemModel.h"

@protocol PMListItemMOdel <NSObject>


@end

@interface PMListItemMOdel : BaseModel

@property (nonatomic,copy) NSString<Optional> *title;
@property (nonatomic,strong) NSArray<PMItemModel,Optional> *items;

@end
