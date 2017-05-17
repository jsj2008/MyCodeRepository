//
//  ZLKeyboardView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/30.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ZLKeyboardView.h"
#import "ZLLoginNumberKeyboard.h"
#import "ZLLoginSymbolKeyboard.h"
#import "ZLTradeNumberKeyboard.h"
#import "ZLSimpleNumberKeyboard.h"

#import "IOSLayoutDefine.h"

#import "ResizeForKeyboard.h"
#import "IosLogic.h"
#import "DebugUtil.h"

#import "TextFieldController.h"
#import "BlackgroundTextField.h"

@interface ZLKeyboardView()<UITextFieldDelegate> {
    ZLLoginNumberKeyboard *_loginNumberKeyboard;
    ZLLoginSymbolKeyboard *_loginSymbolKeyboard;
    ZLTradeNumberKeyboard *_tradeNumberKeyboard;
    ZLSimpleNumberKeyboard *_simpleNumberKeyboard;
    
    //    UITextField *_currentTextField;
    
    UIView *rootView;
    
    Boolean _isUpState;
}

- (ZLLoginNumberKeyboard *)getLoginNumberKeyboard;
- (ZLLoginSymbolKeyboard *)getLoginSymbolKeyboard;
- (ZLTradeNumberKeyboard *)getTradeNumberKeyboard;
- (ZLSimpleNumberKeyboard *)getSimpleNumberKeyboard;

@end

@implementation ZLKeyboardView

@synthesize keyboardDelegate;

#pragma PublicFunc

- (ZLLoginNumberKeyboard *)getLoginNumberKeyboard {
    if (_loginNumberKeyboard == nil) {
        _loginNumberKeyboard = [ZLLoginNumberKeyboard newInstance];
        [self initKeyboardButton:_loginNumberKeyboard];
    }
    return _loginNumberKeyboard;
}

- (ZLLoginSymbolKeyboard *)getLoginSymbolKeyboard {
    if (_loginSymbolKeyboard == nil) {
        _loginSymbolKeyboard = [ZLLoginSymbolKeyboard newInstance];
        [self initKeyboardButton:_loginSymbolKeyboard];
    }
    return _loginSymbolKeyboard;
}

- (ZLTradeNumberKeyboard *)getTradeNumberKeyboard {
    if (_tradeNumberKeyboard == nil) {
        _tradeNumberKeyboard = [ZLTradeNumberKeyboard newInstance];
        [self initKeyboardButton:_tradeNumberKeyboard];
    }
    [_tradeNumberKeyboard getClientDefineValue];
    return _tradeNumberKeyboard;
}

- (ZLSimpleNumberKeyboard *)getSimpleNumberKeyboard {
    if (_simpleNumberKeyboard == nil) {
        _simpleNumberKeyboard = [ZLSimpleNumberKeyboard newInstance];
        [self initKeyboardButton:_simpleNumberKeyboard];
    }
    return _simpleNumberKeyboard;
}

- (id)initWithType:(NSUInteger)type {
    if (self = [super init]) {
        double keyboardHeight = 180.0f;
        self.frame = CGRectMake(0, SCREEN_HEIGHT - keyboardHeight, SCREEN_WIDTH, keyboardHeight);
        self.backgroundColor = [UIColor blackColor];
        _isUpState = false;
        [self addKeyboard:type];
    }
    return self;
}

- (void)initKeyboardButton:(UIView *)keyboard {
    for (UIView *view in [keyboard subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button addTarget:self action:@selector(normalEdit:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)addKeyboard:(NSUInteger)type {
    switch (type) {
        case InputViewStyleLoginNumber:
            [self addSubview:[self getLoginNumberKeyboard]];
            break;
        case InputViewStyleLoginSymbol:
            [self addSubview:[self getLoginSymbolKeyboard]];
            break;
        case InputViewStyleTradeNumber:
            [self addSubview:[self getTradeNumberKeyboard]];
            break;
        case InputViewStyleSimpleNumber:
            [self addSubview:[self getSimpleNumberKeyboard]];
            break;
        break;
            case InputViewStyleLeftTradeNumber:
            [self addSubview:[self getTradeNumberKeyboard]];
            self.frame = CGRectZero;
            break;
        case InputViewStyleNon:
            break;
        default:
            break;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //    ZLKeyboardView *view = (ZLKeyboardView *)textField.inputView;
    //    [self setCurrentTextField:textField];
    [[TextFieldController getInstance] setCurrentTextFiled:textField];
    [self setNeedSecure];
    
    rootView = [[[[IosLogic getInstance] uiWindow] rootViewController] view];
    
    //    CGFloat currentY = textField.frame.origin.y;
    
//    CGFloat currentY = [self getYInRootView:textField];
    
//    if (currentY > SCREEN_HEIGHT - 300 ) {
//        [ResizeForKeyboard setViewPosition:rootView forY:SCREEN_HEIGHT - 300 - currentY];
//    } else if(currentY < 0) {
//        [ResizeForKeyboard setViewPosition:rootView forY:DISTANCE_FROM_TOP - currentY];
//    }
    
    if (keyboardDelegate != nil && [keyboardDelegate respondsToSelector:@selector(textFiledBeginEdit:)]) {
        [self.keyboardDelegate textFiledBeginEdit:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (keyboardDelegate != nil && [keyboardDelegate respondsToSelector:@selector(textFieldEndEdit:)]) {
        [self.keyboardDelegate textFieldEndEdit:textField];
    }
}

- (void)keyboardReturn {
    [[[TextFieldController getInstance] currentTextFiled] resignFirstResponder];
    [ResizeForKeyboard setViewPosition:rootView forY:0];
    [[TextFieldController getInstance] setCurrentTextFiled:nil];
}

- (CGFloat)getYInRootView:(UIView *)subView {
    CGFloat y = subView.frame.origin.y;
    while ([subView superview] != rootView) {
        subView = [subView superview];
        if ([subView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)subView;
            y -= [scrollView contentOffset].y;
        }
        y += subView.frame.origin.y;
    }
    return y;
}

-(void)normalEdit:(UIButton *)editButton {
    NSUInteger type = editButton.tag;
    NSString *insertSting = @"";
    if (type <= ButtonTypeStyleNormal) {
        insertSting = [self getInputStringBy:[[TextFieldController getInstance] currentTextFiled]
                                        text:editButton.titleLabel.text
                                        type:type];
    } else if (type == ButtonTypeStyleDelete) {
        [[[TextFieldController getInstance] currentTextFiled] deleteBackward];
    } else if (type == ButtonTypeStyleNumber) {
        [[[self subviews] lastObject] removeFromSuperview];
        [self addKeyboard:InputViewStyleLoginNumber];
        [self setNeedSecure];
        return;
    } else if (type == ButtonTypeStyleSymbol) {
        [[[self subviews] lastObject] removeFromSuperview];
        [self addKeyboard:InputViewStyleLoginSymbol];
        return;
    } else if (type == ButtonTypeStyleUp) {
        // 目前只有登錄 的 數字鍵盤需要 改變
        UIView *lastView = [[self subviews] lastObject];
        if ([lastView isKindOfClass:[ZLKeyboardSuperView class]]) {
            [(ZLKeyboardSuperView *)lastView changeUpState];
        }
        return;
    } else if (type == ButtonTypeStyleReturn) {
        [self keyboardReturn];
        return;
    } else if (type == ButtonTypeStyleSpace) {
        [[[TextFieldController getInstance] currentTextFiled] insertText:@" "];
        return;
    }
    
    Boolean shouldChange = false;
    if (keyboardDelegate != nil && [keyboardDelegate respondsToSelector:@selector(textFieldShouldChange:insertText:)]) {
        shouldChange = [self.keyboardDelegate textFieldShouldChange:[[TextFieldController getInstance] currentTextFiled]
                                                         insertText:insertSting];
        if (shouldChange) {
            [[[TextFieldController getInstance] currentTextFiled] insertText:insertSting];
        }
    }
    
    if (shouldChange && keyboardDelegate != nil && [keyboardDelegate respondsToSelector:@selector(textFieldDidEdit:)]) {
        [self.keyboardDelegate textFieldDidEdit:[[TextFieldController getInstance] currentTextFiled]];
    }
    
}

- (NSString *)getInputStringBy:(UITextField *)textFiled text:(NSString *)text type:(NSUInteger)type{
    NSString *inputString = @"";
    UITextField *textField = [[TextFieldController getInstance] currentTextFiled];
    if ([textField isKindOfClass:[BlackgroundTextField class]]) {
        BlackgroundTextField *blackTextField = (BlackgroundTextField *)textField;
        // 如果是不是Amount 就不能使用 自定义数字
        if (!([blackTextField inputStyle] != TextFieldStyleAmount && type >= 900)) {
            inputString = text;
        }
        
        if ([blackTextField inputStyle] == TextFieldStyleAmount) {
            if ([self getAmountLengt:text] + [self getAmountLengt:textField.text] > 7) {
                inputString = @"";
            }
        }
        
        if ([blackTextField inputStyle] == TextFieldStyleStopMove) {
            if ([self getAmountLengt:text] + [self getAmountLengt:textField.text] > 3) {
                inputString = @"";
            }
        }
        
        if ([textField.text containsString:@"."] && [text containsString:@"."]) {
            inputString = @"";
        }
        
        if ([blackTextField inputStyle] == TextFieldStyleAmount) {
            inputString = text;
        }
        
    } else {
        inputString = text;
    }
    
    return inputString;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_loginSymbolKeyboard setFrame:self.bounds];
    [_loginNumberKeyboard setFrame:self.bounds];
    [_tradeNumberKeyboard setFrame:self.bounds];
    [_simpleNumberKeyboard setFrame:self.bounds];
}

- (NSInteger)getAmountLengt:(NSString *)amount {
    if (amount == nil || [amount length] == 0) {
        return 0;
    }
    return [[amount stringByReplacingOccurrencesOfString:@"," withString:@""] length];
}

- (void)setNeedSecure {
    Boolean isSecure = [[[TextFieldController getInstance] currentTextFiled] isSecureTextEntry];
    if (isSecure) {
        [_loginNumberKeyboard needPwd:true];
    } else {
        [_loginNumberKeyboard needPwd:false];
    }
}

@end
