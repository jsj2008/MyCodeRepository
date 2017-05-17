//
//  ClosePositionView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClosePositionPopView : UIView{
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_amountLabel;
    IBOutlet UILabel *_buySellLabel;
    IBOutlet UILabel *_priceLabel;
    
    IBOutlet UIButton *_commitButton;
    IBOutlet UIButton *_cancelButton;
}

@property UILabel *titleLabel;
@property UILabel *instrumentLabel;
@property UILabel *amountLabel;
@property UILabel *buySellLabel;
@property UILabel *priceLabel;

@property UIButton *commitButton;
@property UIButton *cancelButton;

+ (ClosePositionPopView *)newInstance;

- (void)setInstrument:(NSString *)instrument;
- (void)setDigist:(int)digist;
- (void)setBuySell:(Boolean)buySell;

@end
