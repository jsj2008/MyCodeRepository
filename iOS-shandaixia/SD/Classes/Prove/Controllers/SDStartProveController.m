//
//  SDStartProveController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDStartProveController.h"
#import "SDProveHeaderView.h"
#import "SDNameProveController.h"
#import "SDIDCardProveController.h"
#import "SDProveOperatorsController.h"
@interface SDStartProveController ()

@end

@implementation SDStartProveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)leftBtnDidTouch{

    if ([self.imageNamed isEqualToString:@"bigicon_card"]) {
        
        [super leftBtnDidTouch];
    }else if ([self.imageNamed isEqualToString:@"bg_icon_OK"]){
    
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}


- (void)startButtonDidClicked{

    
    
    if ([self.imageNamed isEqualToString:@"bigicon_card"]) {
        
        [self.navigationController pushViewController:[[SDIDCardProveController alloc] init] animated:YES];
        
//        [self.navigationController pushViewController:[[SDProveOperatorsController alloc] init] animated:YES];
        
    }else{
    
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
}

- (void)dealloc{

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}


@end
















