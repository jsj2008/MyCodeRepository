//
//  SDAboutSDXController.m
//  SD
//
//  Created by 余艾星 on 17/3/21.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDAboutSDXController.h"
#import "SDNetworkTool.h"

@interface SDAboutSDXController ()

@end

@implementation SDAboutSDXController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = YPWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"关于闪贷侠"];
    
    
    [self addWebViewWithUrlString:[NSString stringWithFormat:@"%@/common/about",BaseURLString]];
    
    
    
}



@end
