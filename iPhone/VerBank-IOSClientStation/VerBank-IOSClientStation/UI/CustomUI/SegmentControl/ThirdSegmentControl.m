//
//  ThirdSegmentControl.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/2.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ThirdSegmentControl.h"

@implementation ThirdSegmentControl


- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initThirdSegment];
    }
    return self;
}

- (void)initThirdSegment {
    self.titleArray = @[@"LIMIT", @"STOP", @"OCO"];
    self.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    
    self.selectIndex = 0;
    _normalTitleColor = DEFAULT_NORMAL_COLOR;
    _selectTitleColor = DEFAULT_SELECTE_COLOR;
    _backgroundColor = [UIColor backgroundColor];
    
    _cornerRadio = 16.0f;
    [self initLayout];
    [self initBtnOnView];
    [self setBackgroundColor:[UIColor backgroundColor]];
}

- (void)layoutSubviews {
    [self updateLayout];
}
@end
