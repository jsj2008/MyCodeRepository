//
//  OptRecordTable.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/6/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#ifndef OptRecordTable_h
#define OptRecordTable_h
/**
 * 操作行為记录
 */
enum OptRecordTable {
    APP_OPT_TYPE_NONE = 0,// 无操作行为
    
    APP_OPT_TYPE_LOGIN = 0 ,// 登入
    APP_OPT_TYPE_ACCOUNT = 1 ,// 保證金狀態
    APP_OPT_TYPE_PRICE = 2 ,// 報價
    APP_OPT_TYPE_OPEN = 3 ,// 開倉單
    APP_OPT_TYPE_ORDER = 4 ,// 掛單
    APP_OPT_TYPE_ORDERHIS = 5 ,// 掛單歷史
    APP_OPT_TYPE_CLOSEHIS = 6 ,// 平倉記錄
    APP_OPT_TYPE_SUMMARY = 7 ,// 部位匯總
    APP_OPT_TYPE_PRICEWARNING = 8 ,// 價格提示
    APP_OPT_TYPE_FOREGIN = 9 ,// 外匯資訊
    APP_OPT_TYPE_MARGIN = 10 ,// 保證金查詢
    APP_OPT_TYPE_MESSAGE = 11 ,// 系統消息
    APP_OPT_TYPE_SYSTEMSETTING = 12 ,// 系統設定
    APP_OPT_TYPE_ABOUT = 13 ,// 聯絡我們
    APP_OPT_TYPE_LOGOUT = 14 ,// 登出
    
    // 報價
    APP_OPT_TYPE_PRICE_ITEM_1 = 211 ,// 報價-掛單.
    APP_OPT_TYPE_PRICE_ITEM_2 = 212 ,// 報價-價格提示
    APP_OPT_TYPE_PRICE_ITEM_3 = 213 ,// 報價-圖型        ????
    APP_OPT_TYPE_PRICE_ITEM_4 = 214 ,// 報價-直式-報價點擊  ????
    APP_OPT_TYPE_PRICE_ITEM_5 = 215 ,// 報價-橫式-報價點擊  ????
    APP_OPT_TYPE_PRICE_ITEM_6 = 216 ,// 報價-市價交易-開倉成功
    APP_OPT_TYPE_PRICE_ITEM_7 = 217 ,// 報價-市價交易-開倉失敗
    APP_OPT_TYPE_PRICE_ITEM_8 = 218 ,// 報價-市價交易-圖型  ????
    
    // 開倉單
    APP_OPT_TYPE_OPEN_ITEM_1 = 311 ,// 開倉單-圖型(點擊貨幣對)  ???
    APP_OPT_TYPE_OPEN_ITEM_2 = 312 ,// 開倉單-平倉(點擊金額/損益)
    APP_OPT_TYPE_OPEN_ITEM_3 = 313 ,// 開倉單-確認平倉-平倉成功
    APP_OPT_TYPE_OPEN_ITEM_4 = 314 ,// 開倉單-確認平倉-平倉失敗
    APP_OPT_TYPE_OPEN_ITEM_5 = 315 ,// 開倉單-對沖
    APP_OPT_TYPE_OPEN_ITEM_6 = 316 ,// 開倉單-對沖-成功
    APP_OPT_TYPE_OPEN_ITEM_7 = 317 ,// 開倉單-對沖-失敗
    APP_OPT_TYPE_OPEN_ITEM_8 = 318 ,// 開倉單-附掛單
    APP_OPT_TYPE_OPEN_ITEM_9 = 319 ,// 開倉單-附掛單-修改
    APP_OPT_TYPE_OPEN_ITEM_10 = 320 ,// 開倉單-附掛單-刪除
    APP_OPT_TYPE_OPEN_ITEM_11 = 321 ,// 開倉單-附掛單-取消
    
    // 掛單
    
    APP_OPT_TYPE_ORDER_ITEM_1 = 411 ,// 掛單-圖型  ????
    APP_OPT_TYPE_ORDER_ITEM_2 = 412 ,// 掛單+
    APP_OPT_TYPE_ORDER_ITEM_3 = 413 ,// 掛單+ - 成功
    APP_OPT_TYPE_ORDER_ITEM_4 = 414 ,// 掛單+ - 失敗
    APP_OPT_TYPE_ORDER_ITEM_5 = 415 ,// 掛單-修改
    APP_OPT_TYPE_ORDER_ITEM_6 = 416 ,// 掛單 -刪除
    APP_OPT_TYPE_ORDER_ITEM_7 = 417 ,// 掛單-取消
    
    // 掛單歷史
    APP_OPT_TYPE_ORDERHIS_ITEM_1 = 511 ,// 掛單歷史-明細展開   ???
    
    // 平倉記錄
    APP_OPT_TYPE_CLOSEHIS_ITEM_1 = 611 ,// 平倉記錄-明細展開    ???
    
    // 部位匯總
    APP_OPT_TYPE_SUMMARY_ITEM_1 = 711 ,// 部位滙總-明細展開   ????
    
    // 價格提示
    APP_OPT_TYPE_PRICEWARNING_ITEM_1 = 811 ,// 價格提示-完成
    
    // 外匯資訊
    APP_OPT_TYPE_FOREGIN_ITEM_1 = 911 ,// 外匯資訊-新聞
    APP_OPT_TYPE_FOREGIN_ITEM_2 = 912 ,// 外匯資訊-經濟數據
    APP_OPT_TYPE_FOREGIN_ITEM_3 = 913 ,// 外匯資訊-外匯評論
    
    // 系統設定
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_1 = 1211 ,// 系統設定-貨幣對選擇
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_2 = 1212 ,// 系統設定-密碼修改
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_3 = 1213 ,// 系統設定-開倉單排序-商品
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_4 = 1214 ,// 系統設定-開倉單排序-開倉價
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_5 = 1215 ,// 系統設定-開倉單排序-浮動損益
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_6 = 1216 ,// 系統設定-開倉單排序-成交時間
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_7 = 1217 ,// 系統設定-掛單排序-商品
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_8 = 1218 ,// 系統設定-掛單排序-時間
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_9 = 1219 ,// 系統設定-部位匯總排序-商品
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_10 = 1220 ,// 系統設定-部位匯總排序-浮動損益
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_11 = 1221 ,// 系統設定-自定輸入金額
    APP_OPT_TYPE_SYSTEMSETTING_ITEM_12 = 1222 ,// 系統設定-報價欄位顯示
    
    // 聯絡我們
    APP_OPT_TYPE_ABOUT_ITEM_1 = 1311 ,// 聯絡我們-電話
    APP_OPT_TYPE_ABOUT_ITEM_2 = 1312 ,// 聯絡我們-Mail
    APP_OPT_TYPE_ABOUT_ITEM_3 = 1313 ,// 聯絡我們-Facebook
};
#endif /* OptRecordTable_h */
