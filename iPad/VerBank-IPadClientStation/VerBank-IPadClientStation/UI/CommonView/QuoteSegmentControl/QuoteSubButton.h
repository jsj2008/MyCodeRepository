//
//  uoteSubButton.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerLabel.h"
#import "MTP4CommDataInterface.h"

@interface QuoteSubButton : UIView {
    IBOutlet UIView *_mainView;
    IBOutlet VerLabel *_leftLabel;
    IBOutlet VerLabel *_middleLabel;
    IBOutlet VerLabel *_rightLabel;
    
    IBOutlet UILabel *_buySellLabel;
    
    IBOutlet UIButton *_backgroundButton;
}

@property (nonatomic, retain) UIView *mainView;

@property (nonatomic, retain) VerLabel *leftLabel;
@property (nonatomic, retain) VerLabel *middleLabel;
@property (nonatomic, retain) VerLabel *rightLabel;

@property (nonatomic, retain) UILabel *buySellLabel;

@property (nonatomic, retain) UIButton *backgroundButton;

@property int buySellType;

// 暂时没有附加小数位
//- (void)setExtraDigit:(int)extraDigit;
- (void)updateValue:(NSString *)value;

@end
