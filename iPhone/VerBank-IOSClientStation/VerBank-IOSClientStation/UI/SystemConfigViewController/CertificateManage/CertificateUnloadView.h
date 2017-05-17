//
//  CertificateUnloadView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/23.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateUnloadView : UIView {
    IBOutlet UILabel *_iphoneOrderLabel;
    IBOutlet UITextField *_passwordField;
    IBOutlet UIButton *_nextButton;
}

@property (nonatomic, retain) UILabel *iphoneOrderLabel;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UIButton *nextButton;

+ (CertificateUnloadView *)newInstance;

@end
