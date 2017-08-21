//
//  StreetSnapeItemModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreetSnapeBannerModel : BaseModel
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *image;
@property (nonatomic, strong)NSString<Optional> *link;
@property (nonatomic, assign)CGFloat ar;
@end
