//
//  MessagePopView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageToAccount.h"

@interface MessagePopView : UIView{
    MessageToAccount *_message;
}

- (void)setMessage:(MessageToAccount *)message;

@end
