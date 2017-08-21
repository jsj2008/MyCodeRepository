//
//  TagItemCell.m
//  HongBao
//
//  Created by marco on 5/12/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "TagItemCell.h"

@interface TagItemCell ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation TagItemCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //[self.label sizeToFit];
    self.label.top = 0;
    self.label.height = self.height;
    self.label.left = 0;
    self.label.width = self.width;
}

- (UILabel*)label
{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 32)];
        _label.textColor = Color_Gray(108);
        _label.layer.borderColor = Color_Gray(225).CGColor;
        _label.layer.borderWidth = 1.f;
        _label.layer.cornerRadius = 2.f;
        _label.font = FONT(14);
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)setTitle:(NSString *)title
{
    self.label.text = title;
}

@end
