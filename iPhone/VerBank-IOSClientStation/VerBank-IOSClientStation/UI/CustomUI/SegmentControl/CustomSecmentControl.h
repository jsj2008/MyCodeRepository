//
//  CustomSecmentControl.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/16.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+CustomButton.h"
#import "UIColor+CustomColor.h"

#define LEFT -1
#define MIDDLE 0
#define RIGHT 1
#define OFFSET 10
#define CORNER_RADIUS 8.0f
#define CORNER_WIDTH 1.0f

#define DEFAULT_NORMAL_COLOR [UIColor whiteColor]
#define DEFAULT_SELECTE_COLOR [UIColor whiteColor]
#define BUTTON_EDGE 2.0f

@protocol CustomSecmentControlViewDelegate <NSObject>

@required
- (void)customSecmentControlClick:(NSInteger)index;
@end

@interface CustomSecmentControl : UIView{
    NSInteger _viewCount;
    
    UIImage *_normalImage;
    UIImage *_selectImage;
    
    UIImage *_leftSelectImage;
    UIImage *_leftNormalImage;
    
    UIImage *_rightSelectImage;
    UIImage *_rightNormalImage;
    
    CGSize _buttonSize;
    
    UIColor *_normalTitleColor;
    UIColor *_selectTitleColor;
    UIColor *_backgroundColor;
    
    CGFloat _cornerRadio;
}

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSArray *titleArray;
@property CGFloat cornerRadio;
@property(nonatomic, strong) UIFont *titleFont;
@property (nonatomic, retain) id <CustomSecmentControlViewDelegate> segmentDelegate;

- (void)updateLayout;
- (void)initLayout;
- (void)initBtnOnView;
- (void)changeBtnTitle;

@end
