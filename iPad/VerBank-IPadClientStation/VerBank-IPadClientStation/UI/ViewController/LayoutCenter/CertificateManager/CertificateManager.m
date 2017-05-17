//
//  CertificateManager.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CertificateManager.h"
#import "CertificateUtil.h"
#import "LayoutCenter.h"
#import "JumpDataCenter.h"
#import "LangCaptain.h"
#import "ShowAlertManager.h"

static CertificateManager *instance = nil;

@implementation CertificateManager

+ (CertificateManager *)getInstance {
    if (instance == nil) {
        instance = [[CertificateManager alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)showCertificateView {
    if ([CertificateUtil isLoadedRsaKey]) {
        if ([CertificateUtil checkCertState]) {
            [[[LayoutCenter getInstance] backgroundLayoutCenter] showCertificateLoadView];
            return;
        } else {
            if ([[[JumpDataCenter getInstance] fnCertResult] isEqualToString:@"Err_CATRADE_ServerNotConnection"]) {
                //                [self initUnconnectView];
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:[[JumpDataCenter getInstance] fnCertResult]]
                                                                     delegate:nil];
                
                return;
            }
            if ([[[JumpDataCenter getInstance] fnCertResult] isEqualToString:@"NetErr"]) {
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:[[JumpDataCenter getInstance] fnCertResult]]
                                                                     delegate:nil];
                return;
            }
        }
    }
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showCertificateUnloadView];
}

- (Boolean)checkCertificateState {
    if ([CertificateUtil isLoadedRsaKey]) {
        if ([CertificateUtil checkTradeCertState]) {
            return true;
        } else {
            if ([[[JumpDataCenter getInstance] fnCertResult] isEqualToString:@"Err_CATRADE_ServerNotConnection"]) {
                //                [self initUnconnectView];
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:[[JumpDataCenter getInstance] fnCertResult]]
                                                                     delegate:nil];
                return false;
            }
            
            if ([[[JumpDataCenter getInstance] fnCertResult] isEqualToString:@"NetErr"]) {
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:[[JumpDataCenter getInstance] fnCertResult]]
                                                                     delegate:nil];
                return false;
            }
            
            if ([[[JumpDataCenter getInstance] fnCertResult] isEqualToString:@"CANotLoaded"]) {
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:[[JumpDataCenter getInstance] fnCertResult]]
                                                                     delegate:nil];
                return false;
            }
            
            
            [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                               andMessage:[[LangCaptain getInstance] getLangByCode:[[JumpDataCenter getInstance] fnCertResult]]
                                                                 delegate:nil];
            
            return false;
        }
    }
    
    [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                       andMessage:[[LangCaptain getInstance] getLangByCode:@"CANotLoaded"]
                                                         delegate:nil];
    return false;
}


- (void)destroy {
    instance = nil;
}
@end
