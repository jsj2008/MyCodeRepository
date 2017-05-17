//
//  ConcreteEconomicView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/6/12.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EconomicData.h"

@interface ConcreteEconomicView : UIView
@property IBOutlet UIButton *backButton;
@property IBOutlet UILabel  *titleLabel;
@property IBOutlet UILabel  *timeLabel;
@property IBOutlet UITextView   *contentTextView;

- (void)updateWithEconomicData:(EconomicData *)economicData;

@end
