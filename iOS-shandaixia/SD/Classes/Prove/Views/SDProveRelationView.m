//
//  SDProveRelationView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDProveRelationView.h"
#import "SDImageRightButton.h"
#import "SDInputView.h"


@interface SDProveRelationView ()



@end

@implementation SDProveRelationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat height = 100 * SCALE;
        
        //与本人关系
        CGFloat labelX = 30 * SCALE;
        CGFloat blank = 20 * SCALE;
        UILabel *relationLabel = [UILabel labelWithText:@"与本人关系" textColor:FDColor(34,34,34) font:30 * SCALE textAliment:0];
        
        relationLabel.frame = CGRectMake(labelX, 0, 100, 30 * SCALE);
        relationLabel.centerY = height/2;
        [self addSubview:relationLabel];
        
        //选择按钮
        NSString *title = @"请选择";
        NSString *imageNamed = @"icon_next";
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        
        [image sizeToFit];
        
        CGFloat nameW = [@"中国工商银行" sizeOfMaxScreenSizeInFont:30 * SCALE].width;
        
        CGFloat width = nameW + blank + image.width;
        
        
        SDImageRightButton *rightButton = [[SDImageRightButton alloc] initWithFrame:CGRectZero blank:blank title:title font:30 * SCALE titleColor:FDColor(153, 153, 153) imageNamed:imageNamed];
        rightButton.height = height;
        rightButton.x = SCREENWIDTH - labelX * 2 - width;
        rightButton.centerY = height/2;
        rightButton.width = width;
        self.rightButton = rightButton;
        
        [self addSubview:rightButton];
        
        
        
        //姓名
        SDInputView *nameInputView = [[SDInputView alloc] initWithFrame:CGRectMake(0, height, SCREENWIDTH, height) title:@"姓名" placeholder:@"请输入紧急联系人姓名"];
        self.nameInputView = nameInputView;
        [self addSubview:nameInputView];
        nameInputView.rightButton.hidden = NO;
        
        //手机号
        SDInputView *phoneInputView = [[SDInputView alloc] initWithFrame:CGRectMake(0, height * 2, SCREENWIDTH, height) title:@"手机号" placeholder:@"请输入手机号码"];
        self.phoneInputView = phoneInputView;
        [self addSubview:phoneInputView];
        
        
//        UIButton *getContactButton = [[UIButton alloc] initWithFrame:CGRectMake(50, height, SCREENWIDTH - 50, height * 2)];
//        [self addSubview:getContactButton];
//        self.getContactButton = getContactButton;
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(labelX, height, self.width - labelX * 2, 1 * SCALE)];
        line1.backgroundColor = FDColor(240, 240, 240);
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(labelX,2 * height, self.width - labelX * 2, 1 * SCALE)];
        line2.backgroundColor = FDColor(240, 240, 240);
        [self addSubview:line2];
        
        
    }
    
    return self;
    
}



@end
