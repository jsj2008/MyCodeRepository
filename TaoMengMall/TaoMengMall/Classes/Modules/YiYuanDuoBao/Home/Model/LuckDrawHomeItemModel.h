//
//  feedsItemModel.h
//  BabyDaily
//
//  Created by bingo on 16/8/23.
//  Copyright © 2016年 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol LuckDrawHomeItemModel <NSObject>

@end

@interface LuckDrawHomeItemModel : BaseModel

@property (nonatomic, strong) NSString *cover;
//@property (nonatomic, assign) CGFloat ar;
@property (nonatomic, assign) float progress;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL showBuy;

@end
