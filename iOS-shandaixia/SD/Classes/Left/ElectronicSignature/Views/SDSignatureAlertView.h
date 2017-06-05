//
//  SDSignatureAlertView.h
//  SD
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDSSQStatus.h"

@protocol SignatureAlertProtocol <NSObject>

- (void)okButtonClick:(SSQSatusCode)ssqStatus;

@end

@interface SDSignatureAlertView : UIView

@property (nonatomic, weak)id<SignatureAlertProtocol> delegate;

+ (instancetype)sharedSignatureAlertView;

+ (void)showSelected:(Boolean)isSelect;
+ (void)dismiss;


@end
