//
//  HedgingSumView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HedgingSumView : UIView {
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_sellDirLabel;
    IBOutlet UILabel *_buyDirLabel;
    IBOutlet UILabel *_sellAmountLabel;
    IBOutlet UILabel *_buyAmountLabel;
    IBOutlet UILabel *_sellAvgLabel;
    IBOutlet UILabel *_buyAvgLabel;
}

@property (nonatomic, retain) UILabel *instrumentLabel;
@property (nonatomic, retain) UILabel *sellDirLabel;
@property (nonatomic, retain) UILabel *buyDirLabel;
@property (nonatomic, retain) UILabel *sellAmountLabel;
@property (nonatomic, retain) UILabel *buyAmountLabel;
@property (nonatomic, retain) UILabel *sellAvgLabel;
@property (nonatomic, retain) UILabel *buyAvgLabel;

@property double sellAmount;
@property double buyAmount;

+ (HedgingSumView *)newInstance;

@end
