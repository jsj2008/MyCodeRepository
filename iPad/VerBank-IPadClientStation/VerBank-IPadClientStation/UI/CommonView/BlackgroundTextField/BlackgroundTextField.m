//
//  BlackgroundButton.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BlackgroundTextField.h"

@implementation BlackgroundTextField

@synthesize inputStyle;

- (id)init {
    if (self = [super init]) {
//        [self initStyle];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        [self initStyle];
    }
    return self;
}

- (void)initStyle {
    [self setBorderStyle:UITextBorderStyleRoundedRect];
    CGFloat radio = self.frame.size.height / 2 - 4.0f;
    self.layer.cornerRadius = radio;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTextColor:[UIColor whiteColor]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initStyle];
}

@end
