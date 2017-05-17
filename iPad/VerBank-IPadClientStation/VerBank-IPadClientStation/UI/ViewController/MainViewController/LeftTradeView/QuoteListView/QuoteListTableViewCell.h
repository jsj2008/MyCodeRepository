//
//  QuoteListTableViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/26.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteView.h"

@interface QuoteListTableViewCell : UITableViewCell {
    IBOutlet QuoteView *_quoteView;
    
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_timeLabel;
    IBOutlet UILabel *_lowPriceLabel;
    IBOutlet UILabel *_highPriceLabel;
    IBOutlet UILabel *_upDownLabel;
    
    IBOutlet UIButton *_leftButton;
    IBOutlet UIButton *_rightButton;
}

@property Boolean isAddListener;

@property QuoteView *quoteView;

@property UILabel *instrumentLabel;
@property UILabel *timeLabel;
@property UILabel *lowPirceLabel;
@property UILabel *highPriceLabel;
@property UILabel *upDownLabel;

@property UIButton *leftButton;
@property UIButton *rightButton;

@end
