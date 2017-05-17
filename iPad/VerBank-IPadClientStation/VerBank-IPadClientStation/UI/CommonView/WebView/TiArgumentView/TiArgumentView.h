//
//  TiArgumentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"
#import "KChartSaveData.h"
#import "TiSuperContentView.h"



@interface TiArgumentView : UIView {
    IBOutlet UIButton *_backButton;
    IBOutlet UIButton *_commitButton;
    IBOutlet UIButton *_resetButton;
}

@property UIButton *backButton;
@property UIButton *commitButton;
@property UIButton *resetButton;

@property TiSuperContentView *contentView;
@property NSString *viewType;

- (void)showTiArgumentViewWithType:(id)type withTiArgumentConfig:(TiArgumentConfig *)config withIndex:(int)index;

@end
