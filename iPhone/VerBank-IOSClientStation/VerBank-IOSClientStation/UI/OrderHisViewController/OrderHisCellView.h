//
//  OrderHisCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHisCellView : UIView{
    IBOutlet UILabel *_ticketLabel;
    IBOutlet UILabel *_orderTimeLabel;
    IBOutlet UILabel *_closeTypeLabel;
    IBOutlet UILabel *_closePriceLabel;
    IBOutlet UILabel *_designTicketLabel;
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_tradeDirLabel;
    IBOutlet UILabel *_tradeAmountLabel;
}

@property (nonatomic, retain)UILabel *ticketLabel;
@property (nonatomic, retain)UILabel *orderTimeLabel;
@property (nonatomic, retain)UILabel *closeTypeLabel;
@property (nonatomic, retain)UILabel *closePriceLabel;
@property (nonatomic, retain)UILabel *designTicketLabel;
@property (nonatomic, retain)UILabel *instrumentLabel;
@property (nonatomic, retain)UILabel *tradeDirLabel;
@property (nonatomic, retain)UILabel *tradeAmountLabel;

+ (OrderHisCellView *)newInstance;

@end
