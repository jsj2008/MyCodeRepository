//
//  TopStatusBarView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"

@interface TopStatusBarView : UIView {
    IBOutlet UIButton *leftButton;
    IBOutlet UIButton *iconButton;
    IBOutlet UIButton *rightButton;
    
    IBOutlet UILabel *marginCallLabel;
    IBOutlet UILabel *floatPLLabel;
    IBOutlet UILabel *percentLabel;
}

@property UIButton *leftButton;
@property UIButton *iconButton;
@property UIButton *rightButton;
@property UILabel *marginCallLabel;
@property UILabel *floatPLLabel;
@property UILabel *percentLabel;

@end
