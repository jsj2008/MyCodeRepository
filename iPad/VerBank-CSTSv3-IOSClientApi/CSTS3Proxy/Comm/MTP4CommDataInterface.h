//
//  MTP4CommDataInterface.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/3/29.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#ifndef JEDIv7_CSTSv3_ClientAPI_MTP4CommDataInterface_h
#define JEDIv7_CSTSv3_ClientAPI_MTP4CommDataInterface_h

enum MTP4CommDataInterface {
    //int型数值的默认值
    DEFAULT=-1,
    
    //买入卖出
    BUY = 1,
    SELL = 0,
    
    // 止盈止损
    LIMIT = 1,
    STOP = 0,
    
    //TURE,FLASE的int标示
    _TRUE=1,
    _FALSE=0,
         
    //margin type
    MARGINTYPE_PERCENTAGE_BY_MKTPRICE=0,
    MARGINTYPE_PERCENTAGE_BY_OPENPRICE=1,
    
    //instrument margin type
    INSTRUMENT_MARGINTYPE_PERCENTAG=0,
    INSTRUMENT_MARGINTYPE_FIXED=1,
    
    //佣金计算方式
    COMMISION_CACULATE_STYLE_MONEYPERLOT=0,
    COMMISION_CACULATE_STYLE_MONEYPERCENTAGE=1,
    COMMISION_CACALATE_STYLE_BYPRICEGAP=2,
    
    //系统开收盘状态
    CLOSESTATUS_OPEN=1,
    CLOSESTATUS_CLOSE=-1,
    CLOSESTATUS_CLOSING=0 ,
    
    //order的类别
    ORDERTYPE_MKT=0,
    ORDERTYPE_CLOSE_PART_OF_1_TRADE_MKT=1,
    ORDERTYPE_NORMAL=2,
    ORDERTYPE_CLOSE_N_FIXED_TRADES_MKT=3,
    ORDERTYPE_CLOSE_1_FIXED_TRADE_ORDER=4,
    ORDERTYPE_HEDGE=5,
    ORDERTYPE_LIQUIDATION=6,
    
    // 委托单有效类型
    ORDER_EXPIRE_TYPE_GTC = 0,
    ORDER_EXPIRE_TYPE_DAY = 1,
    ORDER_EXPIRE_TYPE_WEEK = 2,
    ORDER_EXPIRE_TYPE_USER_DEFINED = 3,
    
    ORDER_EXPIRE_TYPE_H1 = 3600 * 1,
    ORDER_EXPIRE_TYPE_H2 = 3600 * 2,
    ORDER_EXPIRE_TYPE_H4 = 3600 * 4,
    ORDER_EXPIRE_TYPE_H8 = 3600 * 8,
    ORDER_EXPIRE_TYPE_H12 = 3600 * 12,
    ORDER_EXPIRE_TYPE_H16 = 3600 * 16,
    
    //OrderHis reason
    ORDERCLOSEREASON_SUCCEED_QUOTESCAN=1,
    ORDERCLOSEREASON_SUCCEED_USERTRADE=2,
    ORDERCLOSEREASON_SUCCEED_PHONEORDERTRADE=3,
    ORDERCLOSEREASON_SUCCEED_DEALERTRADE=4,
    ORDERCLOSEREASON_SUCCEED_DEALERAFFIRM=5,
    ORDERCLOSEREASON_SUCCEED_FUNDTRADE=6,
    
    ORDERCLOSEREASON_MODIFY_ByUSER=11,
    ORDERCLOSEREASON_MODIFY_ByPHONEORDER=12,
    ORDERCLOSEREASON_MODIFY_ByDEALER=13,
    ORDERCLOSEREASON_MODIFY_ByFUND=14,
    ORDERCLOSEREASON_MODIFY_MoveStop = 15,
    
    ORDERCLOSEREASON_CANCEL_ByUser=21,
    ORDERCLOSEREASON_CANCEL_ByPHONEORDER=22,
    ORDERCLOSEREASON_CANCEL_ByDEALER=23,
    ORDERCLOSEREASON_CANCEL_ByTimeOut=24,
    ORDERCLOSEREASON_CANCEL_corPositionClosed=25,
    ORDERCLOSEREASON_CANCEL_ByFund=26,
    
    ORDERCLOSEREASON_FAILED_OUTOFNOPL=-1,
    ORDERCLOSEREASON_FAILED_OUTOFPOSITIONLIMIT=-2,
    ORDERCLOSEREASON_FAILED_MARGINNOTENOUGH=-3,
    ORDERCLOSEREASON_FAILED_OTHER=-4,
    ORDERCLOSEREASON_FAILED_PRESELLERR=-5,
    ORDERCLOSEREASON_FAILED_CUTLOSS = -6,
    
    //Order Scan Way
    ORDERSCANWAY_COMPAREPRICE=0,
    ORDERSCANWAY_PRICETHROUGHT=1,
    
    //交易的类型
    TRADETYPE_MKT=0,
    TRADETYPE_LIMIT=1,
    TRADETYPE_STOP=2,
    TRADETYPE_MODIFY=-1,
    TRADETYPE_DELETE=-2,
    TRADETYPE_FAILED=-3,
    
    //用户类型，法人，自然人
    USERTYPE_NORMAL=1,
    USERTYPE_CORPORATE=2,
    
    //帐户改变记录流水的原因
    ACCOUNTSTREAMTYPE_DEPOSIT=1,
    ACCOUNTSTREAMTYPE_WITHDRAW=2,
    ACCOUNTSTREAMTYPE_CHARGE=3,
    ACCOUNTSTREAMTYPE_ADJUST=4,
    ACCOUNTSTREAMTYPE_ROLLOVER=5,
    ACCOUNTSTREAMTYPE_COMMISION=6,
    ACCOUNTSTREAMTYPE_TRADE=7,
    ACCOUNTSTREAMTYPE_ADJUST_FIXDEPOSIT=8,
    ACCOUNTSTREAMTYPE_IBCHARGE=9,
    ACCOUNTSTREAMTYPE_LIQUIDATION=10,
    ACCOUNTSTREAMTYPE_MARGIN2=11,
    ACCOUNTSTREAMTYPE_PROMPT=12,
    ACCOUNTSTREAMTYPE_FIXDEPOSIT=13,
    ACCOUNTSTREAMTYPE_HALFANNUAL_INTEREST=14,
    ACCOUNTSTREAMTYPE_CLOSEACCOUNT_INTEREST=15,
    
    ACCOUNTSTREAM_TTYPE_BATCH=1,
    ACCOUNTSTREAM_TTYPE_NORMAL=2,
    ACCOUNTSTREAM_TTYPE_RESERVE=3,
    
    ACCOUNTSTREAM_ADJUST_TYPE_DEPOSIT = 1,
    ACCOUNTSTREAM_ADJUST_TYPE_ADJUST = 2,
    
//价格种类
    PRICETYPE_BID=1,
    PRICETYPE_ASK=2,
    PRIVATE_MODDLE=3,
    
    PRICE_REACH_STATE_NORMAL = 0,
    PRICE_REACH_STATE_REACHED = 1,
    PRICE_REACH_STATE_EXPIRY = 2,
    PRICE_REACH_STATE_DELETE = -1,
    
    //用户验证结果
    USERIDENTIFY_RESULT_SUCCEED=0,
    USERIDENTIFY_RESULT_ERR_USER_NOT_FOUND=-1,
    USERIDENTIFY_RESULT_ERR_PASSWORD_ERR=-2,
    USERIDENTIFY_RESULT_ERR_USER_LOCKED=-3,
    USERIDENTIFY_RESULT_ERR_PASSWORDEXPIRED=-4,
    USERIDENTIFY_RESULT_ERR_IP_ERR=-5,
    USERIDENTIFY_RESULT_ERR_UNKNOW=-15,
    USERIDENTIFY_RESULT_ERR_NETERR=-20,
    USERIDENTIFY_RESULT_ERR_CASTSERR=-21,
    USERIDENTIFY_RESULT_ERR_NETCFG=-30,
    USERIDENTIFY_RESULT_ERR_INITDOC=-100,
    
    
    // ca
    CA_TRADE_SUCCEED = 0,
    CA_FNSTATUS_REQUEST_DONOT = 0,
    CA_FNSTATUS_REQUEST_MAKECSR = 1,
    CA_FNSTATUS_REQUEST_NOTCSR = 2,
    CA_FNSTATUS_UPDATE_DONOT = 0,
    CA_FNSTATUS_UPDATE_MAKECSR = 1,
    CA_FNSTATUS_UPDATE_NOTCSR = 2,
    
    // trade limit
    
    AMOUNT_STEP = 10000,
    
    PUSH_TYPE_IPHONE = 1,
    PUSH_TYPE_APHONE = 2,
    PUSH_TYPE_IPAD = 3,
    PUSH_TYPE_APAD = 4,
    
    ROLETYPE_USER = 10
};

#endif
