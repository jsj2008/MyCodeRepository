//
//  PushViewShow.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/4.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "PushViewShow.h"

@implementation PushViewShow

+ (void)showPushViewAtSuperView:(UIView *)superView alert:(NSString *)alert{
    UILabel *pushView = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, superView.frame.size.width, 50.0f)];
    [pushView setBackgroundColor:[UIColor whiteColor]];
    [pushView setTextAlignment:NSTextAlignmentCenter];
    [pushView setText:alert];
    [superView addSubview:pushView];
    [self downMoveView:pushView];
}

+ (void)downMoveView:(UIView *)view {
    [UIView transitionWithView:view
                      duration:3
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        CGRect rect = view.frame;
                        rect.origin.y += 50;
                        view.frame = rect;
                    }
                    completion:^(BOOL finished){
                        [self stopMoveView:view];
                    }];
}

+ (void)stopMoveView:(UIView *)view {
    [UIView transitionWithView:view
                      duration:8
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        //                        CGRect rect = view.frame;
                        //                        rect.origin.y += 100;
                    }
                    completion:^(BOOL finished){
                        [self upMoveView:view];
                    }];
}

+ (void)upMoveView:(UIView *)view {
    [UIView transitionWithView:view
                      duration:3
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        CGRect rect = view.frame;
                        rect.origin.y -= 50;
                        view.frame = rect;
                    }
                    completion:^(BOOL finished){
                        [view removeFromSuperview];
                    }];
}


@end
