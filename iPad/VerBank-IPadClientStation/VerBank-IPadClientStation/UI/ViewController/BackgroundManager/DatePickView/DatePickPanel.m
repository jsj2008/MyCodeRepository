//
//  DatePickPanel.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "DatePickPanel.h"

@implementation DatePickPanel

@synthesize dateValuePickMainView;
@synthesize dateTypePickMainView;

@synthesize dateValuePicker;
@synthesize dateTypePickView;

@synthesize currentType;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"DatePickPanel" owner:self options:nil];
    [self addSubview:self.dateValuePickMainView];
    [self addSubview:self.dateTypePickMainView];
    [self.dateValuePickMainView     setHidden:true];
    [self.dateTypePickMainView      setHidden:true];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setDefault];
}

- (void)setDefault {
    self.currentType = DatePickEnumDateType;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.dateValuePickMainView setFrame:self.bounds];
    [self.dateTypePickMainView  setFrame:self.bounds];
}

- (void)setEnableView:(DatePickEnum)type {
    self.currentType = type;
    switch (type) {
        case DatePickEnumDateType:
            [self.dateValuePickMainView     setHidden:true];
            [self.dateTypePickMainView      setHidden:false];
            break;
        case DatePickEnumDateValue:
            [self.dateValuePickMainView     setHidden:false];
            [self.dateTypePickMainView      setHidden:true];
            break;
        default:
            break;
    }
}

@end
