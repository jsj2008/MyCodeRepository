//
//  ITRecommendModel.h
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol ITRecommendModel <NSObject>

@end

@interface ITRecommendModel : BaseModel

@property (nonatomic, assign) CGFloat ar;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString<Optional> *price;

@property (nonatomic, strong) NSString *link;

@end
