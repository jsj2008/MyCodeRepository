//
//  SDProvinceView.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDProvinceView.h"
#import "SDProvinceButton.h"

@interface SDProvinceView ()

@property (nonatomic, weak) SDProvinceButton *sellectedButton;

@end

@implementation SDProvinceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat topBlank = 40 * SCALE;
        CGFloat vBlank = 21 * SCALE;
        CGFloat hBlank = 11 * SCALE;
        
        NSArray *princeArray = @[@[@"京",@"沪",@"津",@"渝"],@[@"川",@"鄂",@"甘",@"赣",@"桂",@"贵"],@[@"黑",@"吉",@"晋",@"辽",@"鲁",@"蒙",@"闽",@"宁"],@[@"青",@"琼",@"陕",@"苏",@"皖"],@[@"湘",@"新",@"翼",@"豫",@"粤",@"云",@"藏",@"浙"]];
        
        NSArray *titleArray = @[@"直辖市:",@"A-G",@"H-N",@"Q-W",@"X-Z"];
        
        CGFloat height = [@"直" sizeOfMaxScreenSizeInFont:28 * SCALE].height;
        
        SDProvinceButton *pButton = [[SDProvinceButton alloc] initWithTitle:@""];
        CGFloat buttonH = pButton.height;
        CGFloat buttonW = pButton.width;
        CGFloat titleY = topBlank;
        for (NSInteger i = 0; i < princeArray.count; i ++ ) {
            
            FDLog(@"i ------ %@",@(i));
            
            UIColor *color = FDColor(153, 153, 153);
            
            if (i > 0) {
                
                color = FDColor(34, 34, 34);
            }
            
            if (i == 1) {
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(vBlank, titleY + topBlank * 0.7, self.width - vBlank * 2, 1 * SCALE)];
                lineView.backgroundColor = FDColor(200, 202, 204);
                [self addSubview:lineView];
                
                UILabel *titleLabel = [UILabel labelWithText:@"其他省市:" textColor:FDColor(153, 153, 153) font:28 * SCALE textAliment:0];
                
                titleLabel.frame = CGRectMake(vBlank, titleY + topBlank * 1.4, 100, height);
                
                titleY += topBlank * 2 + height;
                
                [self addSubview:titleLabel];
            }
            
            UILabel *titleLabel = [UILabel labelWithText:titleArray[i] textColor:color font:28 * SCALE textAliment:0];
            
            titleLabel.frame = CGRectMake(vBlank, titleY, 100, height);
            
            titleY += (height + vBlank * 2 + buttonH);
            
            [self addSubview:titleLabel];
            
            NSArray *firstArray = princeArray[i];
            
            if (firstArray.count > 6) {
                
                titleY += hBlank + buttonH;
            }
            
            for (NSInteger i = 0; i < firstArray.count; i ++ ) {
                
                SDProvinceButton *provinceButton = [[SDProvinceButton alloc] initWithTitle:firstArray[i]];
                
                provinceButton.y = CGRectGetMaxY(titleLabel.frame) + vBlank;
                
                
                provinceButton.x = vBlank + (buttonW + hBlank) * i;
                
                if (i > 5) {
                    
                    provinceButton.y += hBlank + buttonH;
                    provinceButton.x = vBlank + (buttonW + hBlank) * (i - 6);
                }
                
                [self addSubview:provinceButton];
                
                [provinceButton addTarget:self action:@selector(provinceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            
        }
        
    }
    return self;
}

- (void)provinceButtonDidClicked:(SDProvinceButton *)button{

    self.sellectedButton.selected = NO;
    button.selected = YES;
    self.sellectedButton = button;
    
    if ([self.delagate respondsToSelector:@selector(provinceButtonDidClicked:)]) {
        
        [self.delagate provinceButtonDidClicked:[button currentTitle]];
    }
}
@end








