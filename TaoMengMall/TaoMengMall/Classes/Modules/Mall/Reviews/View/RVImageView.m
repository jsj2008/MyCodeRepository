//
//  RVImageView.m
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RVImageView.h"

@interface RVImageView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation RVImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self render];
    }
    return self;
}

- (void)render
{
    [self addSubview:self.imageView];
    [self addSubview:self.deleteButton];
    
    self.imageView.left = 0;
    self.imageView.top = 0;
    self.imageView.width = self.width-0;
    self.imageView.height = self.height-0;
    
    self.deleteButton.centerY = 0;
    self.deleteButton.centerX = self.width;
}

- (UIImage*)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)setOnlineImage:(NSString *)url
{
    [self.imageView setOnlineImage:url placeHolderImage:[UIImage imageNamed:@"icon_placeholder"]];
}

#pragma mark - Subviews
- (UIImageView*)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        imageView.userInteractionEnabled = YES;
        [imageView bk_whenTapped:^{
            //[self handleDeleteButton];
            if ([self.delegate respondsToSelector:@selector(imageViewTappped:)]) {
                [self.delegate imageViewTappped:self];
            }
        }];
        _imageView = imageView;
    }
    return _imageView;
}

- (UIButton*)deleteButton
{
    if (!_deleteButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
        [button setImage:[UIImage imageNamed:@"review_image_delete"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton = button;
    }
    return _deleteButton;
}

#pragma mark - button actions
- (void)handleDeleteButton
{
    if ([self.delegate respondsToSelector:@selector(deleteButtonTapped:)]) {
        [self.delegate deleteButtonTapped:self];
    }
}

//重写hitTest方法，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *view = [super hitTest:point withEvent:event];
        if (view) {
            return view;
        }else {
            for (UIView *subView in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [self convertPoint:point toView:subView];
                view = [subView hitTest:subPoint withEvent:event];
                if (view) {
                    return view;
                }
            }
        }
    }
    return nil;
}

@end
