//
//  DSAdvertItemModel.h
//  BabyDaily
//
//  Created by wzningjie on 16/9/21.
//  Copyright © 2016年 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol LuckDrawHomeAdvertItemModel  <NSObject>


@end

@interface LuckDrawHomeAdvertItemModel : BaseModel
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *link;
@end
