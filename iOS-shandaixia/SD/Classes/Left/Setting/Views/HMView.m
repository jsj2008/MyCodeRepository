//
//  HMView.m
//  02-手势解锁
//
//  Created by heima on 16/2/26.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMView.h"

@interface HMView()
@property(nonatomic,strong)NSMutableArray *selectedBtns;
@property(nonatomic,assign)CGPoint currentPoint;

@end

@implementation HMView

- (NSMutableArray *)selectedBtns{
    
    if (_selectedBtns == nil) {
        _selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = SDWhiteColor;
        
//        1.添加按钮
        [self setupBtn];
    }
    return self;
}
//用来添加按钮
//绑定tag
- (void)setupBtn{
    
//    1.创建按钮(如果用到按钮的tag,一般在创建按钮的时候绑定)
    
    for (int i = 0; i < 9;++ i) {
        
        UIButton *btn = [[UIButton alloc]init];
//        1.1设置按钮不可以和用户交互
        btn.userInteractionEnabled = NO;
     
        btn.tag = i;
        
//        1.1添加按钮
        [self addSubview:btn];
//        1.2给按钮设置图片(普通状态)
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_gray_spot"] forState:UIControlStateNormal];
//        1.3设置选中图片
//        按钮的状态
//        UIControlStateNormal       = 0,//普通
//        UIControlStateHighlighted  = 1 << 0,   //高亮               // used when UIControl isHighlighted is set
//        UIControlStateDisabled     = 1 << 1,//不可用
//        UIControlStateSelected//选中
//        最后两种状态一般用通过手动设置才能实现,看到具体的效果
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_sh_blue"] forState:UIControlStateSelected];
//        btn.backgroundColor = [UIColor redColor];
        
    }
    
    
}

//这个方法中可以用来设置按钮的frame,必须调用父类的方法
- (void)layoutSubviews{
//    1.调用父类的方法
    [super layoutSubviews];
//    2.给按钮设置frame
//    2.1获取总共的列数
    NSInteger totalColumn = 3;
    
    for (int i = 0; i < self.subviews.count; ++i) {
//        2.0获取按钮
        UIButton *btn = self.subviews[i];
//        2.1获取行号
        NSInteger row = i/totalColumn;
        NSInteger col = i%totalColumn;
//        2.2确定按钮的宽度和高度
        CGFloat btnW = 74;
        CGFloat btnH = btnW;
        CGFloat marginX = (self.frame.size.width - btnW *totalColumn)/(totalColumn +1);
        CGFloat marginY = marginX;
        
        CGFloat btnX = marginX + (marginX + btnW)*col;
        CGFloat btnY = marginY + (marginY + btnH)*row;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        
        
        
        
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

//    0.重新触摸的时候,把最后的点设置为0
    self.currentPoint = CGPointZero;
//    1.获取位置
    CGPoint currentPoint = [self pointWithTouches:touches];
//    2.判断按钮是包含触摸的点
    UIButton *btn = [self btnWithPoint:currentPoint];
    if (btn && btn.selected == NO) {//如果有值,设置选中
        btn.selected = YES;
//        2.1把按钮添加到数组中
        [self.selectedBtns addObject:btn];
        [self setNeedsDisplay];
    }
   
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //    1.获取位置
    CGPoint currentPoint = [self pointWithTouches:touches];
    //    2.判断按钮是包含触摸的点
    UIButton *btn = [self btnWithPoint:currentPoint];
    if (btn &&btn.selected == NO) {//如果有值,设置选中
        btn.selected = YES;
        [self.selectedBtns addObject:btn];
        
    }else{
        
        self.currentPoint = currentPoint;
       
    }
     [self setNeedsDisplay];
}
//获取触摸的位置
- (CGPoint)pointWithTouches:(NSSet<UITouch *> *)touches{
    //    1.获取手指头
    UITouch *touch = [touches anyObject];
    //    2.获取触摸的位置
    CGPoint currentPoint = [touch locationInView:self];
    return currentPoint;
}

//获取触摸的时候,是否有包含触摸点的按钮
- (UIButton *)btnWithPoint:(CGPoint)point{
    
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
    }
    }
        return nil;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    0.获取我们选中按钮中的tag值,连接成一个字符窜
//    NSMutableString *tempString = [NSMutableString string];
//    for (int i = 0; i < self.selectedBtns.count; i ++) {
//        UIButton *btn = self.selectedBtns[i];
//       
//       NSString *word =  [NSString stringWithFormat:@"%ld",btn.tag];
//        if ([tempString isEqualToString:@"123"]) {
//             
//        }
//           }
    
//    0.进行跳转
//    01.判断密码是否正确
//    02.获取密码
    NSMutableString *pwdString = [NSMutableString string];
    for (UIButton *btn in self.selectedBtns) {
        NSString *word = [NSString stringWithFormat:@"%ld",btn.tag];
        [pwdString appendString:word];
        
    }
    
    if ([self.delegate respondsToSelector:@selector(viewTranslateDataWithView:andString:)]) {
        [self.delegate viewTranslateDataWithView:self andString:pwdString];
    }
   
//
//    1.取消选中状态
    for (UIButton *btn in self.selectedBtns) {
        btn.selected = NO;
    }
//    2.清空数组,移除所有的元素,
    [self.selectedBtns removeAllObjects];
//    3.重新绘制,清空连线
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
//1.使用oc,创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
// 2.绘制路径
//    for (UIButton *btn in self.selectedBtns) {
//        <#statements#>
//    }'
    for (int i = 0; i < self.selectedBtns.count; ++i) {
//        2.1获取每一个选中的按钮
        UIButton *selectedBtn = self.selectedBtns[i];
        if (i == 0) {
            [path moveToPoint:selectedBtn.center];
        }else{
            
            [path addLineToPoint:selectedBtn.center];
        }
    }
    
//    if (CGPointEqualToPoint(self.currentPoint, CGPointZero)== NO) {
//        
//    }
//    CGPointEqualToPoint:判断两个点是否相等
    if (CGPointEqualToPoint(self.currentPoint, CGPointZero)== NO) {
            [path addLineToPoint:self.currentPoint];
    }
 
 
//    2.1设置颜色
    [FDColor(70, 151, 251) set];
    [path setLineWidth:4 * SCALE];
//    3.渲染
    [path stroke];
}


@end
