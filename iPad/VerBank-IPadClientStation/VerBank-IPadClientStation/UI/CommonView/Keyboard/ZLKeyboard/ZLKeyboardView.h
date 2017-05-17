//
//  ZLKeyboardView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/30.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTradeNumberKeyboard.h"
#import "TextFieldUtil.h"

typedef NS_ENUM(NSUInteger, ButtonTypeStyle) {
    ButtonTypeStyleNormal   = 1000,
    ButtonTypeStyleDelete   = 1001,
    ButtonTypeStyleUp       = 1002,
    ButtonTypeStyleSymbol   = 1003,
    ButtonTypeStyleNumber   = 1004,
    ButtonTypeStyleReturn   = 1005,
    ButtonTypeStyleSpace    = 1006
};

typedef NS_ENUM(NSUInteger, InputViewStyle) {
    InputViewStyleNon           = 0,
    InputViewStyleLoginNumber   = 1,
    InputViewStyleLoginSymbol   = 2,
    InputViewStyleTradeNumber   = 3,
    InputViewStyleLeftTradeNumber= 4,
    InputViewStyleSimpleNumber  = 5,
};

@protocol ZLKeyboardDelegate <NSObject>

// 对输入内容需要格式化， 或者要响应 编辑事件的 时候， 需要 这个 protocol
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text;

- (void)textFiledBeginEdit:(UITextField *)textField;
- (void)textFieldDidEdit:(UITextField *)textField;
- (void)textFieldEndEdit:(UITextField *)textField;

@end

@interface ZLKeyboardView : UIView

@property id<ZLKeyboardDelegate> keyboardDelegate;
//@property (nonatomic)  UITextField *currentTextField;

//- (void)setCurrentTextField:(UITextField *)textField;
- (void)keyboardReturn;
- (id)initWithType:(NSUInteger)type;

- (ZLTradeNumberKeyboard *)getTradeNumberKeyboard;

@end
