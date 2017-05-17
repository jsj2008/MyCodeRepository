//
//  OrderHisTableViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHisTableViewContentCell : UITableViewCell

@property IBOutlet UILabel *typeLabel;  // 類型

@property IBOutlet UILabel *limitPriceLabel;
@property IBOutlet UILabel *stopPriceLabel;
@property IBOutlet UILabel *stopMoveLabel;
@property IBOutlet UILabel *dealPriceLabel; // 成交價
@property IBOutlet UILabel *IFDLimitPriceTLabel;
@property IBOutlet UILabel *IFDStopPriceTLabel;

@property IBOutlet UILabel *categoryLabel; // 類別
@property IBOutlet UILabel *closeTicketLabel; // 指定平倉單號

@property IBOutlet UILabel *valueTimeTypeLabel; // 有效日期类型
@property IBOutlet UILabel *valueTimeEndLabel; // 有效期至
@property IBOutlet UILabel *confirmTimeLabel; // 确认时间
@property IBOutlet UILabel *inputTimeLabel; // 输入时间

@end
