//
//  HedgingSumView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HedgingSumView.h"

@implementation HedgingSumView

@synthesize instrumentLabel = _instrumentLabel;
@synthesize sellDirLabel = _sellDirLabel;
@synthesize buyDirLabel = _buyDirLabel;
@synthesize sellAmountLabel = _sellAmountLabel;
@synthesize buyAmountLabel = _buyAmountLabel;
@synthesize sellAvgLabel = _sellAvgLabel;
@synthesize buyAvgLabel = _buyAvgLabel;

@synthesize sellAmount;
@synthesize buyAmount;

+ (HedgingSumView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HedgingSumView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

@end
