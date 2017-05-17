//
//  EnlargeButton.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/29.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "EnlargeButton.h"
#import "ZLKeyboardSuperView.h"

@interface EnlargeButton() {
    UIImageView *enlargeView;
}

@end

@implementation EnlargeButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addListener];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self addListener];
    }
    return self;
}

- (void)addListener {
    [self addTarget:self action:@selector(clickDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(clickUpinside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(clickOutside:) forControlEvents:UIControlEventTouchDragOutside];
}

- (void)clickDown:(id)sender {
    if ([self isClickable]) {
        [self setClickable:false];
        [self enlargeView];
        [[self superview] addSubview:enlargeView];
    }
}

- (void)clickUpinside:(id)sender {
    [enlargeView removeFromSuperview];
    [self setClickable:true];
}

- (void)clickOutside:(id)sender {
    [enlargeView removeFromSuperview];
    [self setClickable:true];
}

- (void)enlargeView {
    if (enlargeView != nil) {
        //        return;
        [enlargeView removeFromSuperview];
    }
    
    UIImage *image = [UIImage imageNamed:@"c_numKeyboardSmallLightButton"];
    CGRect rect = self.frame;
    rect.size.height *= 2;
    rect.size.width *= 2;
    rect.origin.x -= rect.size.width / 4;
    rect.origin.y -= rect.size.height;
    enlargeView = [[UIImageView alloc] initWithFrame:rect];
    [enlargeView setImage:image];
    
    UILabel *enlargeLabel = [[UILabel alloc] init];
    [enlargeLabel setFrame:enlargeView.bounds];
    [enlargeLabel setText:self.titleLabel.text];
    [enlargeLabel setTextColor:[UIColor blackColor]];
    [enlargeLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:25.0f]];
    [enlargeLabel setTextAlignment:NSTextAlignmentCenter];
    
    [enlargeView addSubview:enlargeLabel];
}

- (Boolean)isClickable {
    return [((ZLKeyboardSuperView *)[self superview]) clickable];
}

- (void)setClickable:(Boolean)clickable {
    [((ZLKeyboardSuperView *)[self superview]) setUserInteractionEnabled:clickable];
    [((ZLKeyboardSuperView *)[self superview]) setClickable:clickable];
}

@end
