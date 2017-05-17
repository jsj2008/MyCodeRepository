//
//  TextFieldController.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/5.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextFieldController : NSObject

@property UITextField *currentTextFiled;

+ (TextFieldController *)getInstance;
- (void)keyboardReturen;

@end
