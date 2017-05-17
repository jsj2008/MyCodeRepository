//
//  JBNoticeView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/5/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBNoticeView : UIView {
    IBOutlet UIButton *_okButton;
    IBOutlet UILabel *_titleLabel;
}

@property IBOutlet UITextView *contentTextView;
@property IBOutlet UILabel *subnoticeLabel;

+ (JBNoticeView *)newInstance;

@end
