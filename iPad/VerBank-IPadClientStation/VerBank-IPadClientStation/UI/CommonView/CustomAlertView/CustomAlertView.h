//
//  CustomAlertView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertView;

@protocol CustomAlertDelegate<NSObject>

@optional
-(void)customAlert:(CustomAlertView *)alertView didClickButtonAtIndex:(NSUInteger)index;

@end


@interface CustomAlertView : UIView

@property (weak,nonatomic)      id<CustomAlertDelegate> delegate;
@property (strong, nonatomic)   UIButton *contentMessageButton;

-(instancetype)initWithTitle:(NSString *)title
              contentMessage:(NSString *)contentMessage
                cancelButton:(NSString *)cancelButton
                    okButton:(NSString *)okButton;

- (void)show;
- (void)dismiss;

@end
