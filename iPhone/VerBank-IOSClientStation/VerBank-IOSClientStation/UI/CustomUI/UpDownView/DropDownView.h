//
//  UpDownView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownView;

@protocol DropDownViewDelegate <NSObject>

- (void)otherAction:(int)index atView:(DropDownView *)atView;

@end

@interface DropDownView : UIView

@property id<DropDownViewDelegate> delegate;

@property Boolean isShowState;
//@property int selectIndex;
- (void)setSelectIndex:(int)selectIndex;
- (int)getSelectIndex;

- (id)initWithRect:(UIButton *)button array:(NSArray *)array direction:(Boolean)direction;

- (void)hideDropDown;
- (void)showDropDown;

@end
