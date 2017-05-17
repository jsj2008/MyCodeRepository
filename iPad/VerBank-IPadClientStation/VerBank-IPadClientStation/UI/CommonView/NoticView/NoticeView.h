//
//  NoticeView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"

@interface NoticeView : UIView {
    IBOutlet UIButton *_okButton;
    IBOutlet UITextView *_contentTextView;
    IBOutlet UILabel *_titleLabel;
}

- (void)setShowViewTitle:(NSString *)title;
- (void)setShowViewContent:(NSString *)content;

@end
