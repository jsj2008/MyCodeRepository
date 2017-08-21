//
//  RefundApplyModel.m
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "RefundApplyModel.h"

@implementation RefundApplyModel

- (instancetype)initModel
{
    if (self = [super init]) {
        _receiptStatus = @"0";
        _imageObjs = [NSMutableArray array];
    }
    return self;
}

@end
