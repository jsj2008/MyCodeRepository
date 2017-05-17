//
//  DefaultAmountChangePopView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemConfigContentView.h"

@interface DefaultAmountChangePopView : UIView {
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_priceLabel;
    IBOutlet UITextField *_inputTextField;
    IBOutlet UIButton *_yesButton;
    IBOutlet UIButton *_noButton;
    int _index;
}

//@property UIButton *_yesButton;
//@property UIButton *_noButton;

@property int index;

+ (DefaultAmountChangePopView *)newInstance;

- (void)returnKeyboard;
- (void)setTarget:(SystemConfigContentView *)systemConfigView;

@end
