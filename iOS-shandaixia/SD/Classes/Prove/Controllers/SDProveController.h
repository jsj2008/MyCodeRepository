//
//  SDProveController.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/23.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "YPCustomNavBarController.h"
@class SDProveHeaderView;

@interface SDProveController : YPCustomNavBarController

@property (nonatomic, weak) SDProveHeaderView *blueView;

@property (nonatomic, weak) UIButton *startButton;

@property (nonatomic, copy) NSString *imageNamed;

- (void)addHeaderWithImage:(NSString *)imageNamed;

- (void)addContentWithImageNamed:(NSString *)imageNamed;

@end
