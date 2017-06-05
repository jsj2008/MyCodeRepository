//
//  SDGJJTitleView.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDGJJTitleView.h"
#import "SDGJJ.h"

@interface SDGJJTitleView ()

@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation SDGJJTitleView

- (instancetype)initWithFrame:(CGRect)frame gjjArray:(NSArray *)gjjArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = self.height/2;
        self.clipsToBounds = YES;
        
        UIView *backView =  [[UIView alloc] initWithFrame:CGRectMake(1, 1, self.width - 2, self.height - 2)];
        
        backView.layer.cornerRadius = backView.height/2;
        backView.clipsToBounds = YES;
        
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        UIColor *backColor = FDColor(70, 151, 251);
        self.backgroundColor = backColor;
        
        CGFloat buttonW = backView.width/gjjArray.count;
        CGFloat buttonH = backView.height;
        
        
        for (NSInteger i = 0; i < gjjArray.count; i ++) {
            
            
            SDGJJ *gjj = gjjArray[i];
            
            UIButton *button = [UIButton buttonWithTitle:gjj.label titleColor:FDColor(70, 151, 251) titleFont:26 * SCALE];
            
            button.tag = i;
            
            if (i == 0) {
                
                [self titleButtonDidClicked:button];
            }
            
            button.frame = CGRectMake(buttonW * i, 0, buttonW, buttonH);
            
            [button setBackgroundImage:[UIImage imageWithBgColor:backColor] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageWithBgColor:[UIColor clearColor]] forState:UIControlStateNormal];
            
            [button setTitleColor:backColor forState:UIControlStateNormal];
            [button setTitleColor:SDWhiteColor forState:UIControlStateSelected];
            
            [backView addSubview:button];
            
            [button addTarget:self action:@selector(titleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 2) {
                
                UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(buttonW, 0, 1, buttonH)];
                line1.backgroundColor = backColor;
                [backView addSubview:line1];
                UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(buttonW * 2, 0, 1, buttonH)];
                line2.backgroundColor = backColor;
                [backView addSubview:line2];

            }
            
        }
        
    }
    return self;
}

- (void)titleButtonDidClicked:(UIButton *)button{

    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    if ([self.delegate respondsToSelector:@selector(gjjTitleViewButtonDidClicked:)]) {
        
        [self.delegate gjjTitleViewButtonDidClicked:button.tag];
    }
    
}


@end
