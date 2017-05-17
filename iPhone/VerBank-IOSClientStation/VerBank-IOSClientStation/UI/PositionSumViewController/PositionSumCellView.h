//
//  PositionSumCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionSumCellView : UIView{
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_sumAmountLabel;
    IBOutlet UILabel *_sumFloatPLLabel;
    IBOutlet UILabel *_tradeDirLabel;
    IBOutlet UILabel *_sellLable;
    IBOutlet UILabel *_buyLabel;
    IBOutlet UILabel *_sellAmountLabel;
    IBOutlet UILabel *_buyAmountLabel;
    IBOutlet UILabel *_sellAvgLabel;
    IBOutlet UILabel *_buyAvgLabel;
    IBOutlet UILabel *_sellFloatPLLabel;
    IBOutlet UILabel *_buyFloatPLLabel;
}

@property (nonatomic, retain)UILabel *instrumentLabel;
@property (nonatomic, retain)UILabel *sumAmountLabel;
@property (nonatomic, retain)UILabel *sumFloatPLLabel;
@property (nonatomic, retain)UILabel *tradeDirLabel;
@property (nonatomic, retain)UILabel *sellLable;
@property (nonatomic, retain)UILabel *buyLabel;
@property (nonatomic, retain)UILabel *sellAmountLabel;
@property (nonatomic, retain)UILabel *buyAmountLabel;
@property (nonatomic, retain)UILabel *sellAvgLabel;
@property (nonatomic, retain)UILabel *buyAvgLabel;
@property (nonatomic, retain)UILabel *sellFloatPLLabel;
@property (nonatomic, retain)UILabel *buyFloatPLLabel;


+ (PositionSumCellView *)newInstance;

@end
