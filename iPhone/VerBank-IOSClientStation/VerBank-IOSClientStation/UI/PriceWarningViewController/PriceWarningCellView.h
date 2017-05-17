//
//  PriceWarningCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceWarningCellView : UIView {
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_buySellLabel;
    IBOutlet UILabel *_warningPriceLabel;
    IBOutlet UILabel *_timeLabel;
}

@property (nonatomic, retain)UILabel *instrumentLabel;
@property (nonatomic, retain)UILabel *buySellLabel;
@property (nonatomic, retain)UILabel *warningPriceLabel;
@property (nonatomic, retain)UILabel *timeLabel;

+ (PriceWarningCellView *)newInstance;

@end
