//
//  MessageCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MessageCellView.h"

@implementation MessageCellView

@synthesize titleLabel = _titleLabel;
@synthesize timeLabel = _timeLabel;
@synthesize backgroundImageView = _backgroundImageView;

+ (MessageCellView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MessageCellView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

@end
