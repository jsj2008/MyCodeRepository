//
//  SDReceivedView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDReceivedView.h"
#import "SDSlider.h"


@interface SDReceivedView ()<UITextFieldDelegate>

//到账金额
@property (nonatomic,weak) UIButton *receivedButton;

//手动输入到账金额
@property (nonatomic,weak) UILabel *receivedLabel;

//滑动视图
@property (nonatomic,weak) SDSlider *slider;

@property (nonatomic,assign) NSInteger receivedMoney;

@end

@implementation SDReceivedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        self.backgroundColor = [UIColor redColor];
        
        //到账金额
        UIButton *receivedButton = [[UIButton alloc] init];
        self.receivedButton = receivedButton;
        [self addSubview:receivedButton];
        receivedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [receivedButton setImage:[UIImage imageNamed:@"home_rmb"] forState:UIControlStateNormal];
        [receivedButton setTitleColor:FDColor(34, 34, 34) forState:UIControlStateNormal];
        receivedButton.titleLabel.font = [UIFont systemFontOfSize:28 * SCALE];
        [receivedButton setTitle:@" 到账金额(元)" forState:UIControlStateNormal];
        
        //手动输入到账金额
        UILabel *receivedLabel = [[UILabel alloc] init];
        self.receivedLabel = receivedLabel;
        [self addSubview:receivedLabel];
        receivedLabel.textColor = FDColor(241, 130, 48);
        receivedLabel.textAlignment = NSTextAlignmentCenter;
        receivedLabel.font = [UIFont systemFontOfSize:44 * SCALE];
        
        //滑动视图
        SDSlider *slider = [[SDSlider alloc] init];
        self.slider = slider;
        [self addSubview:slider];
        
        [SDNotificationCenter addObserver:self selector:@selector(sliderMoved:) name:SDSliderMovedNotification object:nil];
        
        [SDNotificationCenter addObserver:self selector:@selector(endMoved:) name:SDSliderEndNotification object:nil];
    }
    return self;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [self.receivedLabel resignFirstResponder];
//}

- (void)dealloc{
    
    [SDNotificationCenter removeObserver:self];
}


- (void)endMoved:(NSNotification *)notification{
    
    
    self.receivedLabel.x = SliderX + ((self.receivedMoney - 500)/100.0) * numBlank - self.receivedLabel.width/2;
    self.receivedLabel.text = [NSString stringWithFormat:@"%@",@(self.receivedMoney)];
    
    
}

- (void)sliderMoved:(NSNotification *)notification{
    
    NSInteger x = [notification.userInfo[SDSliderX] integerValue];
    self.receivedMoney = [notification.userInfo[SDReceivedMoney] integerValue];
  

    self.receivedLabel.text = [NSString stringWithFormat:@"%@",@(self.receivedMoney)];
    
    self.receivedLabel.centerX = x;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //到账金额
    CGFloat receivedX = 30 * SCALE;
    CGFloat receivedY = 46 * SCALE;
    CGFloat receivedH = 40 * SCALE;
    
    self.receivedButton.frame = CGRectMake(receivedX, receivedY, 150, receivedH);
    
    //手动输入到账金额
    
    CGFloat handY = receivedH + receivedY + 40 * SCALE;
    CGFloat handH = 44 * SCALE;
    CGFloat handW = 120 * SCALE;
    CGFloat handX = SliderX + 5 * numBlank - handW/2;
    self.receivedLabel.frame = CGRectMake(handX, handY, handW, handH);
    
    //滑动视图
    self.slider.frame = CGRectMake(0, handY + handH + 10 * SCALE, SCREENWIDTH, 40);
    
    self.receivedLabel.text = @"1000";
    
}

@end


