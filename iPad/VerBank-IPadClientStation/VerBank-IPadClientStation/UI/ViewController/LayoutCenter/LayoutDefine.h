//
//  LayoutDefine.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#ifndef LayoutDefine_h
#define LayoutDefine_h

typedef NS_ENUM(NSInteger, ViewFunction) {
    Function_Unknow                         = 0,
    
    Function_Left_QuoteList                 = 1,
    Function_Left_MarketTrade               = 2,
    Function_Left_AddOrderTrade             = 3,
    Function_Left_PriceWarnigTrade          = 4,
    
    Function_Left_News                      = 5,
    Function_Left_EconomicData              = 6,
    Function_Left_Review                    = 7,
    Function_Left_MargincallHis             = 8,
    
    Function_Bottom_OpenPosition            = 9,
    Function_Bottom_OrderPosition           = 10,
    Function_Bottom_PositionSum             = 11,
    Function_Bottom_ClosePositionHis        = 12,
    Function_Bottom_OrderHis                = 13,
    Function_Bottom_PriceWarning            = 14,
    
    Function_Left_Message                   = 15,
    Function_Left_Push                      = 16,
    
    Function_Left_AddOpenPositionOrder      = 17,
    Function_Left_ModifyOpenPositionOrder   = 18,
    Function_Left_ModifyOrderTrade          = 19,
    Function_Left_ModifyPriceWarning        = 20,
    
};

#endif /* LayoutDefine_h */
