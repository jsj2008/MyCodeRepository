//
//  SDChangeBaseUrlView.m
//  SD
//
//  Created by 余艾星 on 17/4/12.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDChangeBaseUrlView.h"
#import "SDNetworkTool.h"

#define url1 "http://116.62.26.225:8080"
#define url2 "https://api.shandaixia.com.cn:9191"

@interface SDChangeBaseUrlView ()

@property(nonatomic, weak) UITextField *inputTextField;
@property(nonatomic, weak) UIButton *shadowButton;

@end

@implementation SDChangeBaseUrlView

+ (void)show{

    SDChangeBaseUrlView *view = [[self alloc] initWithFrame:CGRectMake(0, 200, SCREENWIDTH, 200)];
    
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.shadowButton = shadowButton;
    shadowButton.backgroundColor = SDBlackColor;
    shadowButton.alpha = 0.5;
    
    [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = SDWhiteColor;
        
        UITextField *inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        self.inputTextField = inputTextField;
        inputTextField.placeholder = @"请输入";
        [self addSubview:inputTextField];
        inputTextField.backgroundColor = FDColor(230, 230, 230);
        
        
        UIButton *url1Button = [UIButton buttonWithTitle:@url1 titleColor:[UIColor blackColor] titleFont:20];
        url1Button.width = self.width;
        url1Button.y = inputTextField.height + 10;
        url1Button.height = 30;
        url1Button.x = 10;
        url1Button.tag = 0;
        url1Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:url1Button];
        
        UIButton *url2Button = [UIButton buttonWithTitle:@url2 titleColor:[UIColor blackColor] titleFont:20];
        url2Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        url2Button.width = self.width;
        url2Button.y = CGRectGetMaxY(url1Button.frame) + 10;
        url2Button.height = 30;
        url2Button.x = 10;
        url2Button.tag = 1;
        [self addSubview:url2Button];
        
        //https://api.shandaixia.com.cn:9191
        //http://116.62.26.225:8080
        
        UIButton *sureButton = [UIButton buttonWithTitle:@"确定" titleColor:[UIColor blackColor] titleFont:30];
        
        sureButton.tag = 2;
        sureButton.width = self.width/3;
        sureButton.y = CGRectGetMaxY(url2Button.frame) + 30;
        sureButton.height = 30;
        sureButton.centerX = self.width/2;
        [self addSubview:sureButton];
        
        
        
        [sureButton addTarget:self action:@selector(sureButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [url1Button addTarget:self action:@selector(sureButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [url2Button addTarget:self action:@selector(sureButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)sureButtonDidClicked:(UIButton *)button{

    switch (button.tag) {
        case 0:
            
            self.inputTextField.text = @url1;
            
            break;
            
        case 1:
            
        
            self.inputTextField.text = @url2;
            
            break;
            
        case 2:
        {
            if (self.inputTextField.text.length) {
                
                [[SDNetworkTool getManager] setValue:[NSURL URLWithString:self.inputTextField.text] forKey:@"baseURL"];
                
                [self removeFromSuperview];
                [self.shadowButton removeFromSuperview];
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.inputTextField endEditing:YES];
}

@end
