//
//  ITCoverImageModel.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ITCoverImageModel

@end

@interface ITCoverImageModel : BaseModel

@property (nonatomic, strong) NSArray *src;
@property (nonatomic, assign) CGFloat ar;

@end
