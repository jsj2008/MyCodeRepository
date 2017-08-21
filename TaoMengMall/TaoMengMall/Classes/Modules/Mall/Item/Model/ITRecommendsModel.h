//
//  ITRecommends.h
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ITRecommendModel.h"

@interface ITRecommendsModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<ITRecommendModel,Optional> *list;
@end
