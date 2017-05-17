//
//  TiSuperContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/27.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"
#import "TiArgumentConfig.h"

typedef NS_ENUM(NSUInteger, TiArgumentViewType) {
    TiArgumentViewTypeUnkown            = 0,
    TiArgumentViewTypeRSI               = 1,
    TiArgumentViewTypeMA                = 2,
    TiArgumentViewTypeMACD              = 3,
    TiArgumentViewTypeKDJ               = 4,
    TiArgumentViewTypeBollingerBand     = 5,
};

@interface TiSuperContentView : UIView {
    UIButton *_currentButton;
}

- (void)commitArgument;
- (void)resetArgument;
- (void)setTiArgumentConfig:(TiArgumentConfig *)config withIndex:(int)index;

- (void)initPickButton:(UIButton *)button;

- (void)showColorPicker:(id)sender;

@property int index;
@property TiArgumentConfig *config;

@end
