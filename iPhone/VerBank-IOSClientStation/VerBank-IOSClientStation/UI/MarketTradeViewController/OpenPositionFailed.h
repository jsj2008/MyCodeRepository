//
//  OpenPositionFailed.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenPositionFailed : UIView {
    IBOutlet UIButton *_confirmButton;
    
    IBOutlet UILabel *_titleLabel;
    IBOutlet UITextView *_contentView;
}

@property (nonatomic, retain)UIButton *confirmButton;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UITextView *contentView;

+ (OpenPositionFailed *)newInstance;

@end
