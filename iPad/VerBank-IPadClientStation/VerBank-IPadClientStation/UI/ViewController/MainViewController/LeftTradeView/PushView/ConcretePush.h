//
//  ConcreteNews.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/20.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushFromSystem.h"

@interface ConcretePush : UIView

@property IBOutlet UIButton *backButton;
@property IBOutlet UILabel  *titleLabel;
@property IBOutlet UILabel  *timeLabel;
@property IBOutlet UITextView   *contentTextView;

- (void)updateWithPush:(PushFromSystem *)push;

@end
