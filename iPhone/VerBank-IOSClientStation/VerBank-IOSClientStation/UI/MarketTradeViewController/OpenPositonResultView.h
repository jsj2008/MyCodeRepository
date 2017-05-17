//
//  OpenPositonResultView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenPositonResultView : UIView {
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_accountLabel;
    IBOutlet UILabel *_timeLabel;
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_amountLabel;
    IBOutlet UILabel *_buySellLabel;
    IBOutlet UILabel *_priceLabel;
    IBOutlet UIButton *_confirmButton;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *accountLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *instrumentLabel;
@property (nonatomic, retain) UILabel *amountLabel;
@property (nonatomic, retain) UILabel *buySellLabel;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UIButton *confirmButton;


+ (OpenPositonResultView *)newInstance;

@end
