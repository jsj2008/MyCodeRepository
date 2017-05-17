//
//  TiArgumentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TiArgumentView : UIView {
    IBOutlet UIButton *_backButton;
    IBOutlet UIButton *_commitButton;
    IBOutlet UIButton *_resetButton;
}

@property UIButton *backButton;
@property UIButton *commitButton;
@property UIButton *resetButton;

+ (TiArgumentView *)newInstance;

@end
