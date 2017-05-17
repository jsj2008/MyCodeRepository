//
//  PriceWarningAddOrModifyContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceWarning.h"
#import "QuoteSegmentControl.h"
#import "FloatPLStatus.h"
#import "LHSlideView.h"

@interface PriceWarningAddOrModifyContentView : UIView {
    PriceWarning *_priceWarning;
    NSString *_instrument;
    
    IBOutlet FloatPLStatus *_floatPLStatus;
    IBOutlet UILabel *_accountLabel;
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_timeLabel;
    IBOutlet QuoteSegmentControl *_quoteSegmentControl;
    
//    IBOutlet UILabel *_touchLabel;
//    IBOutlet UIButton *_touchButton;
    IBOutlet UILabel *_priceLabel;
    IBOutlet UITextField *_priceTextField;
    IBOutlet UILabel *_valueTimeLabel;
    IBOutlet UIButton *_valueTimeButton;
    
    IBOutlet LHSlideView *_lhSlideView;
}

//@property PriceWarning *priceWarning;
//@property NSString *instrument;

//@property FloatPLStatus *floatPLStatus;
@property UILabel *accountLabel;
@property UILabel *instrumentLabel;
@property UILabel *timeLabel;
@property QuoteSegmentControl *quoteSegmentControl;

//@property UIButton *touchButton;
@property UILabel *priceLabel;
@property UITextField *priceTextField;
@property UIButton *valueTimeButton;

//@property UILabel *touchLabel;
@property UILabel *valueTimeLabel;

@property LHSlideView *lhSlideView;


+ (PriceWarningAddOrModifyContentView *)newInstance;
//- (void)refreshUI;

- (void)addListener;
- (void)removeListener;

@end
