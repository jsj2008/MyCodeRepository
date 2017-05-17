//
//  AboutContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutContentView : UIView {
    IBOutlet UIImageView *_logoImageView;
    IBOutlet UILabel *_bankTitle;
    IBOutlet UILabel *_sysTitle;
    IBOutlet UILabel *_phoneNameTitle;
    IBOutlet UILabel *_phoneNumberLabel;
    IBOutlet UIImageView *_emailImageView;
    IBOutlet UILabel *_emailLabel;
    IBOutlet UIImageView *_facebookImageView;
    IBOutlet UILabel *_facebookLabel;
    IBOutlet UILabel *_version;
}

+ (AboutContentView *)newInstance;

@end
