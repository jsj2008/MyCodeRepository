//
//  SDRegisterProtocolController.m
//  SD
//
//  Created by 余艾星 on 17/3/20.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDRegisterProtocolController.h"
#import "SDNetworkTool.h"

@interface SDRegisterProtocolController ()

@end

@implementation SDRegisterProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"注册协议"];

    [self addWebViewWithUrlString:[NSString stringWithFormat:@"%@/agreement/agreementInfo",BaseURLString]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
