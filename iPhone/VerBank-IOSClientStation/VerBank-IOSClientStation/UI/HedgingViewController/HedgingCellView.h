//
//  HedgingCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HedgingCellView : UIView {
    
    IBOutlet UIImageView  *_buttonView;
    
    IBOutlet UILabel *_ticketLabel;
    IBOutlet UILabel *_timeLabel;
    
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_amountLabel;
    IBOutlet UILabel *_floatPLLabel;
    
    IBOutlet UILabel *_tradeDirLabel;
    IBOutlet UILabel *_openPriceLabel;
    IBOutlet UILabel *_mktPriceLabel;
}

@property (nonatomic, retain) UIImageView  *buttonView;

@property (nonatomic, retain) UILabel *ticketLabel;
@property (nonatomic, retain) UILabel *timeLabel;

@property (nonatomic, retain) UILabel *instrumentLabel;
@property (nonatomic, retain) UILabel *amountLabel;
@property (nonatomic, retain) UILabel *floatPLLabel;

@property (nonatomic, retain) UILabel *tradeDirLabel;
@property (nonatomic, retain) UILabel *openPriceLabel;
@property (nonatomic, retain) UILabel *mktPriceLabel;

+ (HedgingCellView *)newInstance;

@end
