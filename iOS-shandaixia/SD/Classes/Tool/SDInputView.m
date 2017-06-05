//
//  SDInputView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDInputView.h"
#import "SDImageRightButton.h"

@interface SDInputView ()<UITextFieldDelegate>

//文本
@property (nonatomic, weak) UILabel *headerLabel;



@end

@implementation SDInputView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //名字
        NSString *name = title;
        CGFloat nameX = 30 * SCALE;
        CGFloat nameW = [name sizeOfMaxScreenSizeInFont:30 * SCALE].width;
        CGFloat nameH = self.height;
        
        UILabel *nameLabel = [UILabel labelWithText:name textColor:FDColor(34, 34, 34) font:nameX textAliment:0];
        
        nameLabel.frame = CGRectMake(nameX, 0, nameW, nameH);
        
        [self addSubview:nameLabel];
        
        nameLabel.centerY = frame.size.height/2;
        
        //输入框
        CGFloat textX = nameX * 2 + nameW;
        
        UITextField *inputTextField = [UITextField textFieldWithFont:30 * SCALE color:FDColor(34, 34, 34) placeholder:placeholder];
        inputTextField.frame = CGRectMake(textX, 0, SCREENWIDTH - 20 - textX - nameX, nameH);
        inputTextField.centerY = nameLabel.centerY;
        [self addSubview:inputTextField];
        self.inputTextField = inputTextField;
        inputTextField.delegate = self;
        inputTextField.returnKeyType = UIReturnKeyDone;
        
        //只有文字的按钮
        UIButton *titlesButton = [UIButton buttonWithTitle:@"只有文字的按钮" titleColor:FDColor(70,151,251) titleFont:28 * SCALE];
        titlesButton.width = [@"重新获取 (99)" sizeOfMaxScreenSizeInFont:28 * SCALE].width;
        titlesButton.height = self.height;
        self.titlesButton = titlesButton;
        titlesButton.x = self.width - nameX - titlesButton.width;
        [self addSubview:titlesButton];
        titlesButton.centerY = nameLabel.centerY;
        titlesButton.hidden = YES;
        
        //右侧按钮
        UIButton *rightButton = [UIButton buttonWithImage:@"btn_address" backImageNamed:nil];
        [rightButton sizeToFit];
        self.rightButton = rightButton;
        rightButton.x = self.width - nameX - rightButton.width;
        [self addSubview:rightButton];
        rightButton.centerY = nameLabel.centerY;
        rightButton.hidden = YES;
        
        //选择按钮
        CGFloat blank = 20 * SCALE;
        NSString *title = @"请选择";
        NSString *imageNamed = @"icon_next";
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        
        [image sizeToFit];
        
        CGFloat titleW = [@"中国工商银行" sizeOfMaxScreenSizeInFont:30 * SCALE].width + 15;
        
        CGFloat width = titleW + blank + image.width;
        
        
        SDImageRightButton *chooseButton = [[SDImageRightButton alloc] initWithFrame:CGRectZero blank:blank title:title font:30 * SCALE titleColor:FDColor(153, 153, 153) imageNamed:imageNamed];
        CGFloat labelX = 30 * SCALE;
        CGFloat height = 100 * SCALE;
        chooseButton.height = height;
        chooseButton.x = SCREENWIDTH - labelX - width;
        chooseButton.centerY = height/2;
        chooseButton.width = width;
        self.chooseButton = chooseButton;
        chooseButton.hidden = YES;
        [self addSubview:chooseButton];
        
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.inputTextField endEditing:YES];
    
    return YES;
    
}


@end
