//
//  ButtonPanel.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"

@interface ButtonPanelView : UIView

@property IBOutlet UIView   *modifyButtonPanel;
@property IBOutlet UIButton *modifyCommitButton;
@property IBOutlet UIButton *modifyDeleteButton;
@property IBOutlet UIButton *modifyCancelButton;

@property IBOutlet UIView   *addButtonPanel;
@property IBOutlet UIButton *addCommitButton;
@property IBOutlet UIButton *addCancelButton;

@end
