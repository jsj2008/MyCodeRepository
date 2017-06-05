//
//  SDBannerController.m
//  SD
//
//  Created by 余艾星 on 17/3/10.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDBannerController.h"
#import "SDBanner.h"
#import "SDUserInfo.h"

@interface SDBannerController ()

@end

@implementation SDBannerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:_banner.title];
    
    NSString *urlString;
    
    if ([SDUserInfo getUserInfo].ID.length) {
        
        urlString = [NSString stringWithFormat:@"%@?userId=%@",_banner.httpUrl,[SDUserInfo getUserInfo].ID];
    }else{
    
        urlString = _banner.httpUrl;
    }

    [self addWebViewWithUrlString:urlString];
    
    
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
