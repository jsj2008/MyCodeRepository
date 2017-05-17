//
//  ForexNewsCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ForexNewsCellView.h"

@implementation ForexNewsCellView

@synthesize newsTypeLabel = _newsTypeLabel;
@synthesize timeLabel = _timeLabel;
@synthesize titleLabel = _titleLabel;

@synthesize backgroundView = _backgroundView;

+ (ForexNewsCellView *)newInstance {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ForexNewsCellView" owner:self options:nil];
    return [nibs objectAtIndex:0];
}

@end
