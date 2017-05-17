//
//  CertificateContentLoadView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CertificateContentLoadView.h"
#import "LangCaptain.h"
#import "ClientAPI.h"
#import "FnCertState.h"
#import "JumpDataCenter.h"
#import "ActionUtils.h"
#import "UIColor+CustomColor.h"

@implementation CertificateContentLoadView

@synthesize titleLabel;
@synthesize backButton;

@synthesize aeidLabel;
@synthesize loadedLabel;
@synthesize stateLabel;
@synthesize startTimeLabel;
@synthesize endTimeLabel;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"CertificateManagement"]];
        [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    
    [backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    
    [aeidLabel setText:[[ClientAPI getInstance] aeid]];
    [loadedLabel setText:[[LangCaptain getInstance] getLangByCode:@"Loaded"]];
    
    [backButton addTarget:[ActionUtils getInstance]
                   action:@selector(showSystemConfigView)
         forControlEvents:UIControlEventTouchUpInside];
    
    [self setBackgroundColor:[UIColor grayColor]];
}

- (void)resetContentView {
    FnCertState *certState = [[JumpDataCenter getInstance] fnCertState];
    if (certState != nil) {
        NSString *state = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"CertificateStateCode"], [[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"CA_%d", [certState getCaState]]]];
        
        NSString *beginDate = [NSString stringWithFormat:@"%@：%@", [[LangCaptain getInstance] getLangByCode:@"CertificateBeginDate"],[JEDIDateTime getCertificateTimeString:[certState getBeginValidTime]]];
        NSString *endDate = [NSString stringWithFormat:@"%@：%@", [[LangCaptain getInstance] getLangByCode:@"CertificateEndDate"], [JEDIDateTime getCertificateTimeString:[certState getEndValidTime]]];
        
        [self.stateLabel setText:state];
        [self.startTimeLabel setText:beginDate];
        [self.endTimeLabel setText:endDate];
    }
}

@end
