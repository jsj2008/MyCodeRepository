//
//  IosLayoutDefine.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/5.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ScreenAuotoSizeScale.h"

#ifndef VerBank_IOSClientStation_IosLayoutDefine_h
#define VerBank_IOSClientStation_IosLayoutDefine_h



#define IOS7_OR_LATER  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0  

#define AccountChoose 1
#define InstrumentChoose 2
#define OrderChoose 3

#define DISTANCE_FROM_TOP [ScreenAuotoSizeScale CGAutoMakeFloat:100]
#define FloatPLStatusHeight 30.0f
#define SliderBarHeight [ScreenAuotoSizeScale CGAutoMakeFloat:30.0f]
#define ContentRect CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT - FIXHOTTOPIC_HEIGHT)

#define ClosePositionViewRect   CGRectMake(20, 160, SCREEN_WIDTH - 40, 145)
#define OpenFailedViewRect      CGRectMake(20, 160, SCREEN_WIDTH - 40, 135)
#define OpenSuccessViewRect     CGRectMake(20, 160, SCREEN_WIDTH - 40, 175)
#define InputPinViewRect        CGRectMake(20, 120, SCREEN_WIDTH - 40, 110)

#define IPHONE5_WIDTH 320
#define IPHONE5_HEIGHT 568

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_TOPST_HEIGHT [ScreenAuotoSizeScale CGAutoMakeFloat:50]
//#define AUTOHOTTOPIC_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height >= 25.0 ? 20.0 : 0)
#define AUTOSTATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height >= 25.0 ? 5 : 20.0)
#define FIXHOTTOPIC_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height >= 25.0 ? 20.0 : 0)

#define SCREEN_STATUS_BAR  [ScreenAuotoSizeScale CGAutoMakeFloat:AUTOSTATUSBAR_HEIGHT]

#define DEFAULT_LEFT_WIDTH [ScreenAuotoSizeScale CGAutoMakeFloat:IPHONE5_WIDTH-160]
#define DEFAULT_ALPHA 0.5
#define DEFAULT_DIM_ALPHA 0.4

// show marginView layout
#define TitleHeight [ScreenAuotoSizeScale CGAutoMakeFloat:20.0f]
#define BottomHeight [ScreenAuotoSizeScale CGAutoMakeFloat:5.0f]
#define ShowViewDistanceFromTop [ScreenAuotoSizeScale CGAutoMakeFloat:80.0f]
#define ShowViewMaxHeight [ScreenAuotoSizeScale CGAutoMakeFloat:400.0f]
#define ShowViewWidth [ScreenAuotoSizeScale CGAutoMakeFloat:250.0f]

#define LeftTableViewCellHeight [ScreenAuotoSizeScale CGAutoMakeFloat:38.35]

#define WeekSecInterval 7 * 24 * 60 * 60
#define DefaultIndex 0

#define KChartViewTag 1002

#define IsPortrait SCREEN_WIDTH < SCREEN_HEIGHT

#endif
