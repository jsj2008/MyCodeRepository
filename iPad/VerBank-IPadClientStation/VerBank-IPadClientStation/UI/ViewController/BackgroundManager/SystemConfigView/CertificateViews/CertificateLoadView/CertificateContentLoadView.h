//
//  CertificateContentLoadView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"

@interface CertificateContentLoadView : LayoutContentView

@property IBOutlet UILabel *titleLabel;
@property IBOutlet UIButton *backButton;

@property IBOutlet UILabel *aeidLabel;
@property IBOutlet UILabel *loadedLabel;
@property IBOutlet UILabel *stateLabel;
@property IBOutlet UILabel *startTimeLabel;
@property IBOutlet UILabel *endTimeLabel;

@end
