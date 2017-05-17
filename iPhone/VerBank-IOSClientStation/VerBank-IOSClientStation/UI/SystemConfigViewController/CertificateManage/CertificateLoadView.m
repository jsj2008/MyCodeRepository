//
//  CertificateLoadView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/23.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "CertificateLoadView.h"
#import "ClientAPI.h"
#import "LangCaptain.h"

@implementation CertificateLoadView

@synthesize aeidLabel = _aeidLabel;
@synthesize loadedLabel = _loadedLabel;
@synthesize stateLabel = _stateLabel;
@synthesize startTimeLabel = _startTimeLabel;
@synthesize endTimeLabel = _endTimeLabel;

+ (CertificateLoadView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CertificateLoadView" owner:self options:nil];
    CertificateLoadView *certificateLoadView = [nib objectAtIndex:0];
    [certificateLoadView initContentView];
    return [nib objectAtIndex:0];
}

- (void)initContentView {
    [_aeidLabel setText:[[ClientAPI getInstance] aeid]];
    [_loadedLabel setText:[[LangCaptain getInstance] getLangByCode:@"Loaded"]];
    [self setBackgroundColor:[UIColor blackColor]];
}


@end
