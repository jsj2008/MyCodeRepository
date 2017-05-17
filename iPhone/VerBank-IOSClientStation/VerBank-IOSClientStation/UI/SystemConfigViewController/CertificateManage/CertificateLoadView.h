//
//  CertificateLoadView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/23.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateLoadView : UIView {
    IBOutlet UILabel *_aeidLabel;
    IBOutlet UILabel *_loadedLabel;
    IBOutlet UILabel *_stateLabel;
    IBOutlet UILabel *_startTimeLabel;
    IBOutlet UILabel *_endTimeLabel;
}

@property (nonatomic, retain) UILabel *aeidLabel;
@property (nonatomic, retain) UILabel *loadedLabel;
@property (nonatomic, retain) UILabel *stateLabel;
@property (nonatomic, retain) UILabel *startTimeLabel;
@property (nonatomic, retain) UILabel *endTimeLabel;


+ (CertificateLoadView *)newInstance;

@end
