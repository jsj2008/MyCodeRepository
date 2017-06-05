//
//  SDSpeedView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/13.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDSpeedView.h"
#import "SDUserVerifyDetail.h"

@interface SDSpeedView ()

//圆的背景
@property (nonatomic, weak) UIImageView *roundImageView;

//数字
@property (nonatomic, weak) UILabel *numberLabel;

//提速率文字
@property (nonatomic, weak) UILabel *speedLabel;

//结束的角度
@property (nonatomic, assign) CGFloat endAngle;



@end

@implementation SDSpeedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.endAngle = - M_PI_2;
        
//        self.layer.cornerRadius = self.width/2;
        
        self.backgroundColor = [UIColor clearColor];
        
        //圆的背景
        UIImageView *roundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bg_round"]];
        self.roundImageView = roundImageView;
        [self addSubview:roundImageView];
        
        //数字
        UILabel *numberLabel = [UILabel labelWithText:@"99" textColor:FDColor(62, 154, 225) font:78 * SCALE textAliment:1];
        self.numberLabel = numberLabel;
        [self addSubview:numberLabel];
        
        //提速率文字
        UILabel *speedLabel = [UILabel labelWithText:@"提速率" textColor:FDColor(62, 154, 225) font:22 * SCALE textAliment:1];
        self.speedLabel = speedLabel;
        [self addSubview:speedLabel];
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.roundImageView.width = self.width - 4;
    self.roundImageView.height = self.height - 4;
    
    
    
    CGSize size = [@"100" sizeOfMaxScreenSizeInFont:78 * SCALE];
    self.numberLabel.width = size.width;
    self.numberLabel.height = size.height;
    
    self.numberLabel.centerX = self.roundImageView.centerX = self.width/2;
    self.roundImageView.centerY = self.height/2;
    
    self.numberLabel.centerY = self.height/2 ;
    
    self.speedLabel.frame = CGRectMake(0, CGRectGetMaxY(self.numberLabel.frame), size.width, 22 * SCALE);
    
    self.speedLabel.centerX = self.width/2;
    
    
    
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat radius = self.width/2;
 
    //设置路径
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    //第一个参数是起点，是圆形的圆心
    //第二个参数是半径
    //第三个参数是起始弧度
    //第四个参数是结束弧度
    //第五个参数是传入yes是顺时针,no为顺时针，下面的另外一种实现方法的参数意思也是一致
    //path addArcWithCenter:<#(CGPoint)#> radius:<#(CGFloat)#> startAngle:<#(CGFloat)#> endAngle:<#(CGFloat)#> clockwise:<#(BOOL)#>
    
    
    [path1 addArcWithCenter:[self getViewCenterPoint] radius:radius startAngle:-M_PI_2 endAngle:self.endAngle clockwise:1];
    [[UIColor colorWithWhite:1 alpha:0.4] set];
    //渲染
    [path1 stroke];
    
    
    
}

- (CGPoint)getViewCenterPoint{
    
    return CGPointMake(self.width*0.5, self.height*0.5);
    
}

- (void)setUserVerifyDetail:(SDUserVerifyDetail *)userVerifyDetail{

    _userVerifyDetail = userVerifyDetail;
    
    NSInteger num = 0;
    
    if ([userVerifyDetail.tbStatus integerValue]) {
        
        num += 20;
    }
    if ([userVerifyDetail.jdStatus integerValue]) {
        
        num += 20;
    }
    if ([userVerifyDetail.yhStatus integerValue]) {
        
        num += 20;
    }
    if ([userVerifyDetail.sbStatus integerValue]) {
        
        num += 10;
    }//10
    if ([userVerifyDetail.gjjStatus integerValue]) {
        
        num += 10;
    }//10
    if ([userVerifyDetail.xueStatus integerValue]) {
        
        num += 20;
    }
    
    self.numberLabel.text = [NSString stringWithFormat:@"%@",@(num)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1 animations:^{
            
            self.endAngle = M_PI*2*(num/100.0) - M_PI_2;
            
            [self setNeedsDisplay];
        }];
        
    });
}

@end










