//
//  VersionCheckService.m
//  ZhenBaoHui
//
//  Created by marco on 8/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "VersionCheckService.h"
#import "VersionRequest.h"
#import "AppInfoManager.h"

@interface VersionCheckService ()<UIAlertViewDelegate>

@property (nonatomic, strong) VersionResultModel *resultModel;

@end

@implementation VersionCheckService

+ (instancetype)sharedService
{
    static VersionCheckService *sharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[VersionCheckService alloc] init];
    });
    return sharedService;
}


- (void)check
{
    [VersionRequest getVersionWithParams:nil success:^(VersionResultModel *resultModel) {
//        resultModel = [VersionResultModel new];
//        resultModel.versionCode = @"20";
//        resultModel.force  = NO;
        if ([resultModel.versionCode compare:[AppInfoManager shortVersionString] options:NSNumericSearch] ==NSOrderedDescending) {
            //resultModel.force = YES;
            self.resultModel = resultModel;
            
            if (resultModel.force) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有新版本" message:[NSString stringWithFormat:@"%@",resultModel.updateLog] delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即更新", nil];
                [alertView show];
                
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有新版本" message:[NSString stringWithFormat:@"%@",resultModel.updateLog] delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"立即更新", nil];
                [alertView show];
            }
            
        }
    } failure:^(StatusModel *status) {
        
    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (self.resultModel.force) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            [[TTNavigationService sharedService] openUrl:self.resultModel.link];
            CFRunLoopRun();
        }
    }else{
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            [[TTNavigationService sharedService] openUrl:self.resultModel.link];
        }
    }
    
}
@end
