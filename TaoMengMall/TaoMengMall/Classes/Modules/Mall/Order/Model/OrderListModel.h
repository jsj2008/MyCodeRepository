//
//  OrderListModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ODLFeedModel.h"

@protocol OrderListModel

@end

@interface OrderListModel : BaseModel

@property (nonatomic, strong) NSArray<ODLFeedModel> *list;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSString<Optional> *wp;

@end
