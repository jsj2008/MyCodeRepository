//
//  UserInputView.h
//  XiaoPa
//
//  Created by wzningjie on 2016/11/21.
//  Copyright © 2016年 marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInputView : UIView

- (void)setName:(NSString *)name andValue:(NSString *)value;
@property (nonatomic, strong) UILabel *valueLabel;
@end
