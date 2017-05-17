//
//  ConcreteMessage.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/20.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"
#import "MessageToAccount.h"

@interface ConcreteMessage : UIView

@property IBOutlet UIButton *backButton;
@property IBOutlet UILabel  *titleLabel;
@property IBOutlet UILabel  *timeLabel;
@property IBOutlet UITextView   *contentTextView;

- (void)updateWithMessage:(MessageToAccount *)message;

@end
