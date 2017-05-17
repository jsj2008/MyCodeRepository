//
//  BackgroundStatusEnum.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#ifndef BackgroundStatusEnum_h
#define BackgroundStatusEnum_h

typedef NS_ENUM(NSInteger, CurrentScreenStatus) {
    Closed = 0,
    Opened = 1,
    Unknow = 2
};

typedef NS_ENUM(NSInteger, LeftViewSelectIndex) {
    EQuoteListView      = 000,
    EOpenPositionView   = 001,
    EOrderPositionView  = 002,
    EOrderHisView       = 003,
    EClosePositionView  = 004,
    EPositionSumView    = 005,
    EPriceWarningView   = 006,
    EForexNewsView      = 100,
    EMarginCallView     = 101,
    EMessageView        = 200,
    ESystemConfigView   = 201,
    EAbountView         = 202,
    ELogoutFromServer   = 203
};

#endif /* BackgroundStatusEnum_h */
