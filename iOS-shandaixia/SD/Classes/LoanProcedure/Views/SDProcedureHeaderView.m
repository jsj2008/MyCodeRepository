//
//  SDProcedureHeaderView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/25.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDProcedureHeaderView.h"
#import "SDNumberView.h"
#import "SDLoan.h"

@interface SDProcedureHeaderView ()



@end

@implementation SDProcedureHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = FDColor(70, 151, 251);
        
        //借款金额
        SDNumberView *loanPriceView = [SDNumberView numberViewWithNumberFont:70 * SCALE numberColor:[UIColor whiteColor] desFont:24 * SCALE desColor:[UIColor whiteColor]];
        self.loanPriceView = loanPriceView;
        [self addSubview:loanPriceView];
        
        //借款期限
        SDNumberView *loanTimeView = [SDNumberView numberViewWithNumberFont:70 * SCALE numberColor:[UIColor whiteColor] desFont:24 * SCALE desColor:[UIColor whiteColor]];
        
        self.loanTimeView = loanTimeView;
        [self addSubview:loanTimeView];
        
        
        
        
    }
    return self;
}

- (void)dealloc{
    
    [SDNotificationCenter removeObserver:self];
}



- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat priceY = 204 * SCALE;
    CGFloat priceX = 150 * SCALE;
    CGFloat priceH = 114 * SCALE;
    CGFloat priceW = [@"1000" sizeOfMaxScreenSizeInFont:70 * SCALE].width * 1.1;
    
    self.loanPriceView.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    self.loanTimeView.frame = CGRectMake(SCREENWIDTH - priceW - priceX, priceY, priceW, priceH);
    
    
    
    [self.loanTimeView.descriptionButton setTitle:@"借款时间(天)" forState:UIControlStateNormal];
    
    [self.loanPriceView.descriptionButton setTitle:@"借款金额(元)" forState:UIControlStateNormal];
    
}

- (void)setLoan:(SDLoan *)loan{

    _loan = loan;
    
    self.loanTimeView.numberLabel.text = [NSString stringWithFormat:@"%@",loan.day];
    
    self.loanPriceView.numberLabel.text = [NSString stringWithFormat:@"%@",@(loan.price + [loan.charge integerValue])];

}

@end
