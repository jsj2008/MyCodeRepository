//
//  RVImageView.m
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RFImageView.h"

@interface RFImageView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation RFImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.deleteButton];
        self.deleteButton.centerY = 0;
        self.deleteButton.centerX = self.width;
    }
    return self;
}

- (void)setOnlineImage:(NSString *)image
{
    if (image) {
        [self.imageView setOnlineImage:image];
    }
}

- (UIImage*)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (UIImageView*)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        imageView.layer.borderWidth = 1.;
        imageView.layer.borderColor = Color_Gray(151).CGColor;
        _imageView = imageView;
    }
    return _imageView;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        [button setImage:[UIImage imageNamed:@"refund_image_delete"] forState:UIControlStateNormal];
        _deleteButton = button;
    }
    return  _deleteButton;
}

@end
