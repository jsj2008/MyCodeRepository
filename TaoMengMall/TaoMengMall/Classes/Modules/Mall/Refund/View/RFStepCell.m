//
//  RFStepCell.m
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RFStepCell.h"

@interface RFStepCell ()
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *spot1;
@property (nonatomic, strong) UILabel *spot2;
@property (nonatomic, strong) UILabel *spot3;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@end

@implementation RFStepCell

- (void)drawCell
{
    //self.backgroundColor = Color_White;

    [self addSubview:self.line];
    [self addSubview:self.spot1];
    [self addSubview:self.spot2];
    [self addSubview:self.spot3];
    [self addSubview:self.label1];
    [self addSubview:self.label2];
    [self addSubview:self.label3];
}

- (void)reloadData
{
    if (self.cellData) {
        
        //初始设置
        self.spot1.backgroundColor = Color_Gray216;
        self.spot2.backgroundColor = Color_Gray216;
        self.spot3.backgroundColor = Color_Gray216;

        self.label1.textColor = Color_Black;
        self.label2.textColor = Color_Black;
        self.label3.textColor = Color_Black;

        //1:申请，可取消
        //2:用户取消，再次申请页面
        //3:商家接受，处理中
        //5:申请结束，完成申请
        //6:商家拒绝，处理中
        NSString *status = (NSString*)self.cellData;

        if ([status isEqualToString:@"1"]) {
            
            self.spot1.backgroundColor = Color_Red9;
            self.label1.textColor = Color_Red9;
            
        }else if ([status isEqualToString:@"6"]) {
            
            self.spot1.backgroundColor = Color_Red9;
            self.label1.textColor = Color_Red9;
            
            self.spot2.backgroundColor = Color_Red9;
            self.label2.textColor = Color_Red9;
            
        }else if ([status isEqualToString:@"5"]||[status isEqualToString:@"3"]||[status isEqualToString:@"4"]) {
            
            self.spot1.backgroundColor = Color_Red9;
            self.label1.textColor = Color_Red9;
            
            self.spot2.backgroundColor = Color_Red9;
            self.label2.textColor = Color_Red9;
            
            self.spot3.backgroundColor = Color_Red9;
            self.label3.textColor = Color_Red9;
        }
        
        //布局
        self.spot1.top = 20;
        
        self.spot2.top = self.spot1.top;
        self.spot2.centerX = SCREEN_WIDTH/2;
        
        self.spot3.top = self.spot1.top;
        self.spot3.right = SCREEN_WIDTH - 24;
        
        self.label1.centerX = self.spot1.centerX;
        self.label1.top = self.spot1.bottom + 4;
        
        self.label2.centerX = self.spot2.centerX;
        self.label2.top = self.spot2.bottom + 4;
        
        self.label3.centerX = self.spot3.centerX;
        self.label3.top = self.spot3.bottom + 4;
        
        self.line.centerY = self.spot1.centerY;

    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 80;
    }
    return height;
}

#pragma mark -Subviews

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(24, 0, SCREEN_WIDTH - 24*2, 1)];
        view.backgroundColor = Color_Red9;
        _line = view;
    }
    return _line;
}


- (UILabel*)spot1
{
    if (!_spot1) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 0, 20, 20)];
        label.font = FONT(16);
        label.text = @"1";
        label.textColor = Color_White;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = Color_Gray216;
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        _spot1 = label;
    }
    return _spot1;
}

- (UILabel*)spot2
{
    if (!_spot2) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        label.font = FONT(16);
        label.text = @"2";
        label.textColor = Color_White;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = Color_Gray216;
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        _spot2 = label;
    }
    return _spot2;
}

- (UILabel*)spot3
{
    if (!_spot3) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        label.font = FONT(16);
        label.text = @"3";
        label.textColor = Color_White;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = Color_Gray216;
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        _spot3 = label;
    }
    return _spot3;
}

- (UILabel*)label1
{
    if (!_label1) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(12);
        label.text = @"申请退款";
        [label sizeToFit];
        _label1 = label;
    }
    return _label1;
}

- (UILabel*)label2
{
    if (!_label2) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(12);
        label.text = @"商家处理";
        [label sizeToFit];
        _label2 = label;
    }
    return _label2;
}

- (UILabel*)label3
{
    if (!_label3) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(12);
        label.text = @"退款完成";
        [label sizeToFit];
        _label3 = label;
    }
    return _label3;
}



@end
