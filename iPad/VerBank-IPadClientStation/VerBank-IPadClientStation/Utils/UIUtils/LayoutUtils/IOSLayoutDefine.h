//
//  IOSLayoutDefine.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ScreenAuotoSizeScale.h"
#import "IosScreen.h"


#ifndef IOSLayoutDefine_h
#define IOSLayoutDefine_h

//#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
//#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT   [IosScreen getScreenHeight]
#define SCREEN_WIDTH    [IosScreen getScreenWidth]

#define BottomHiddenHeight [ScreenAuotoSizeScale CGAutoMakeFloat:20]
//#define BottomContentHeight (int)(SCREEN_HEIGHT / 3)
#define BottomContentHeight [ScreenAuotoSizeScale CGAutoMakeFloat:256]
#define LeftHiddenWidth [ScreenAuotoSizeScale CGAutoMakeFloat:15]
//#define LeftContentWidth (int)(SCREEN_WIDTH / 3)
#define LeftContentWidth [ScreenAuotoSizeScale CGAutoMakeFloat:341]

#define LeftRect CGRectMake(0, 0, (int)(LeftContentWidth - 15), SCREEN_HEIGHT)

#define SCREEN_TOPST_HEIGHT [ScreenAuotoSizeScale CGAutoMakeFloat:50]
#define SCREEN_STATUS_BAR  [ScreenAuotoSizeScale CGAutoMakeFloat:20]

#define DISTANCE_FROM_TOP [ScreenAuotoSizeScale CGAutoMakeFloat:300]

#endif /* IOSLayoutDefine_h */
