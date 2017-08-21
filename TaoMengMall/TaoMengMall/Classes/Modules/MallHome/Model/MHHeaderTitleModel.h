//
//  MHHeaderTitleModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface MHHeaderTitleModel : BaseModel
@property (nonatomic, strong) NSString <Optional>*text;
@property (nonatomic, strong) NSString <Optional>*font;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, assign) BOOL bold;
@end
