//
//  PushPopView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushFromSystem.h"

@interface PushPopView : UIView{
    PushFromSystem *_pushMessage;
}

- (void)setPushMessage:(PushFromSystem *)pushMessage;

@end
