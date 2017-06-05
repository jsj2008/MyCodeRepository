//
//  SDHelpController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDHelpController.h"
#import "SDNetworkTool.h"

@interface SDHelpController ()

@end

@implementation SDHelpController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = YPWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"帮助与反馈"];
    
    
    [self addWebViewWithUrlString:[NSString stringWithFormat:@"%@/help/helpInfo",BaseURLString]];
    
    
    
}



@end
