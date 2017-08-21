//
//  RefundApplyModel.h
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseModel.h"

@interface RefundApplyModel : BaseModel

//0,1
@property (nonatomic, strong) NSString *receiptStatus;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger reason;

@property (nonatomic, strong) NSString *sum;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSMutableArray *imageObjs;

- (instancetype)initModel;
@end
