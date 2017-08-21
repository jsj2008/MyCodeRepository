//
//  LaunchGuideView.m
//  BabyDaily
//
//  Created by marco on 10/31/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "LaunchGuideView.h"
#import "TTAppLaunchView.h"

NSString *const LaunchViewWillRemoveNotification = @"LaunchViewWillRemoveNotification";

@interface LaunchGuideView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@end


@implementation LaunchGuideView

- (instancetype)init
{
    if (self = [super init]) {
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return self;
}

- (void)render
{
    [self addSubview:self.imageView];
    //[self addSubview:self.button];
    self.button.hidden = !self.showButton;
    
    NSString *fileName;
    NSString *name = [NSString stringWithFormat:@"app_guide_%ld_",(long)self.index];
    if (IS_IPHONE4) {
        fileName = [NSString stringWithFormat:@"%@fg4",name];
    } else if (IS_IPHONE5) {
        fileName = [NSString stringWithFormat:@"%@fg5",name];
    } else if (IS_IPHONE6) {
        fileName = [NSString stringWithFormat:@"%@fg6",name];
    } else if (IS_IPHONE6Plus) {
        fileName = [NSString stringWithFormat:@"%@fg6p",name];
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];

    self.imageView.image = image;
}

#pragma mark - SubViews
- (UIImageView*)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.userInteractionEnabled = YES;
        weakify(self);
        [imageView bk_whenTapped:^{
            strongify(self);
            if (self.index == 2) {
                [self removeLaunchView];
            }
        }];
        _imageView = imageView;
    }
    return _imageView;
}

- (UIButton*)button
{
    if (!_button) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
        button.layer.borderColor = Color_Gray216.CGColor;
        button.layer.borderWidth = 1.f;
        button.layer.cornerRadius = 4.f;
        button.layer.masksToBounds = YES;
        [button setTitle:@"立即体验" forState:UIControlStateNormal];
        [button setTitleColor:Color_Gray125 forState:UIControlStateNormal];
        [button addTarget:self action:@selector(removeLaunchView) forControlEvents:UIControlEventTouchUpInside];
        button.centerX = SCREEN_WIDTH/2;
        button.bottom = SCREEN_HEIGHT - 20;
        _button = button;
    }
    return _button;
}
    
- (void)removeLaunchView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LaunchViewWillRemoveNotification object:nil];
    TTAppLaunchView *launchView = [TTAppLaunchView sharedInstance];
    [launchView removeLaunchView];
}
@end
