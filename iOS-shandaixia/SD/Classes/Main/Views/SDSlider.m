//
//  SDSlider.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDSlider.h"
#import "SDSliderLabel.h"


#define RightBlank (30 * SCALE)

@interface SDSlider ()<UIGestureRecognizerDelegate>

//滑动按钮
@property (nonatomic,weak) UIButton *sliderButton;

@property (nonatomic,weak) UIImageView *grayBackImageView;

//蓝色背景
@property (nonatomic,weak) UIImageView *blueBackView;

@property (nonatomic, assign) CGFloat sliderButtonX;

@property (nonatomic, assign) BOOL moving;


@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@property (nonatomic, assign) CGFloat leftBlank;

@end

@implementation SDSlider

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
        self.moving = NO;
        
        self.receivedMoney = 500;
        
        self.sliderButtonX = SliderX;
        
        //灰色背景
        
        UIImageView *grayBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"progress-bar"]];
        [self addSubview:grayBackImageView];
        self.grayBackImageView = grayBackImageView;
        
        //蓝色背景
        UIImageView *blueBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_progressbar"]];
        [self addSubview:blueBackView];
        self.blueBackView = blueBackView;
        blueBackView.backgroundColor = FDColor(82, 168, 251);
        self.blueBackView.width = 0;
        
        
        //滑动按钮
        UIButton *sliderButton = [[UIButton alloc] init];
        [self addSubview:sliderButton];
        self.sliderButton = sliderButton;
        [sliderButton setImage:[UIImage imageNamed:@"btn_-round"] forState:UIControlStateNormal];
        [sliderButton sizeToFit];
        sliderButton.userInteractionEnabled = NO;
        

        
//        sliderButton.backgroundColor = [UIColor redColor];
        
        //1.创建长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressTouch:)];
        
        longPress.delegate = self;
        
        self.longPress = longPress;
        //1.1设置最短长按时间
        longPress.minimumPressDuration = 0.02;
        
        //1.2设置长按的范围
//        longPress.allowableMovement = 1;
        
        //2.添加手势
        [self addGestureRecognizer:longPress];
        
        for (NSInteger i = 0; i < 6; i++) {
            
            SDSliderLabel *sliderLabel = [[SDSliderLabel alloc] init];
            [self addSubview:sliderLabel];
            
            switch (i) {
                case 0:
                    sliderLabel.sliderLabel.text = @"500";
                    
                    break;
                case 1:
                    sliderLabel.sliderLabel.text = @"600";
                    
                    break;
                case 2:
                    sliderLabel.sliderLabel.text = @"700";
                    
                    break;
                case 3:
                    sliderLabel.sliderLabel.text = @"800";
                    
                    break;
                case 4:
                    sliderLabel.sliderLabel.text = @"900";
                    
                    break;
                case 5:
                    sliderLabel.sliderLabel.text = @"1000";
                    
                break;
            }
        }
        
        self.leftBlank = SliderX - self.sliderButton.width/2 + 4 * SCALE;
        self.sliderButton.centerX = SliderX - 4 * SCALE;
        self.blueBackView.width = self.sliderButton.width/2;
//        [SDNotificationCenter addObserver:self selector:@selector(sliderMoved:) name:SDSliderMovedNotification object:nil];
        
        [self set];
    }
    return self;
}

- (void)set{
    
    //SCREENWIDTH - SliderX + 4 * SCALE
    
    CGFloat x = SCREENWIDTH - SliderX + 4 * SCALE;
    
    self.movedX = x;
    
    self.sliderButtonX = x;
    
    self.sliderButton.centerX = x;
    
    self.blueBackView.width = x - self.leftBlank;
    
    [self setNeedsLayout];
    
    self.receivedMoney = 1000;



    [SDNotificationCenter postNotificationName:SDSliderMovedNotification object:nil userInfo:@{SDSliderX:@(x),SDReceivedMoney:@(1000)}];

}

- (void)dealloc{
    
    [SDNotificationCenter removeObserver:self];
}
//
//- (void)sliderMoved:(NSNotification *)notification{
//    
//    //到账金额
//    CGFloat receivedMoney = [notification.userInfo[SDReceivedMoney] floatValue];
//    
////    [self movedIconWithX:receivedMoney];
//    
//
//}
- (void)layoutSubviews{
 
    [super layoutSubviews];
    
    
    
    //数字
    CGFloat numY = self.blueBackView.y + self.blueBackView.height + 24 * SCALE;
    
    
    //灰色背景
    CGFloat grayX = self.leftBlank;
    
    CGFloat height = 12 * SCALE;
    CGFloat backH = 34 * SCALE;
    CGFloat backW = SCREENWIDTH - 2 * grayX;
    
    self.grayBackImageView.frame = CGRectMake(grayX, backH - height, backW, height);
    
    //蓝色条码
    self.blueBackView.x = grayX;
//     = grayX;
    self.blueBackView.height = height;
    self.blueBackView.layer.cornerRadius = height/2;
    self.blueBackView.clipsToBounds = YES;
    self.blueBackView.y = backH - height;
//    self.grayBackImageView.frame = self.blueBackView.frame;
    
    //移动按钮
    
    self.sliderButton.centerY = self.blueBackView.centerY;

    
    NSInteger i=0;
    for (UIView *obj in self.subviews) {
        
        if ([obj isKindOfClass:[SDSliderLabel class]]) {
            
            
            
            obj.frame = CGRectMake(0, numY, 60 * SCALE, 36 * SCALE);
            obj.centerX = SliderX + i * numBlank;
            
            i ++;
            
            
        }
    }
    
}

- (void)longPressTouch:(id)sender{

    
    UILongPressGestureRecognizer *longPress = sender;
    
    
    
    if (longPress.state == UIGestureRecognizerStateEnded) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self movedIconWithX:self.movedX];
            [SDNotificationCenter postNotificationName:SDSliderEndNotification object:@{SDReceivedMoney:@(self.receivedMoney)}];
            
        });
        
        
    }
    
    UITouch *touch = sender;
    
    CGFloat blank = numBlank;
    
    CGPoint point = [touch locationInView:self];
    
//    CGFloat grayX = SliderX - self.sliderButton.width/2 + 4 * SCALE;

    
    if (point.x < SliderX - 4 * SCALE || point.x > SCREENWIDTH - SliderX + 4 * SCALE) return;
    
    self.movedX = point.x;
    
    self.sliderButtonX = point.x;
    
    self.sliderButton.centerX = point.x;
    
    self.blueBackView.width = point.x - self.leftBlank;
    
    [self setNeedsLayout];
    
//    NSInteger receivedMoney = 0;
    
    if (point.x > SliderX && point.x < SliderX + blank/2) {
        
        self.receivedMoney = 500;
    }
    
    if (point.x > SliderX + blank/2 && point.x < SliderX + blank * 3/2) {
        
        self.receivedMoney = 600;
    }
    
    if (point.x >= SliderX + blank * 3/2 && point.x < SliderX + blank * 5/2) {
        
        self.receivedMoney = 700;
    }
    
    if (point.x >= SliderX + blank * 5/2 && point.x < SliderX + blank * 7/2) {
        
        self.receivedMoney = 800;
    }
    
    if (point.x >= SliderX + blank * 7/2 && point.x < SliderX + blank * 9/2) {
        
        self.receivedMoney = 900;
    }
    
    if (point.x >= SliderX + blank * 9/2 && point.x < SliderX + blank * 11/2) {
        
        self.receivedMoney = 1000;
    }
    
    [SDNotificationCenter postNotificationName:SDSliderMovedNotification object:nil userInfo:@{SDSliderX:@(point.x),SDReceivedMoney:@(self.receivedMoney)}];
    
    if (CGRectContainsPoint(self.sliderButton.frame, point)) {
        
        
    }
    
}

- (void)movedIconWithX:(CGFloat)x{
    
    CGFloat receivedMoney = self.receivedMoney;
    
    CGFloat tag = receivedMoney/(CGFloat)100.0 - 5.0;
    
//    FDLog(@"tag --- %@,receivedMoney --- %@",@(tag),@(receivedMoney));
    
    CGFloat width = SliderX + tag * numBlank;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.sliderButton.centerX = width;
        
        self.blueBackView.width = width - _leftBlank;
        
    }];
    
//    [self setNeedsLayout];
    
}



@end
