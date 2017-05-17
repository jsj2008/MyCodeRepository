//
//  QuoteView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TradeEvent <NSObject>

- (void)touchedTradeEvent:(NSString *)instrument buySell:(int)buySell;

@end

@interface QuoteView : UIView{
    id<TradeEvent> _delegate;
}

@property (nonatomic, retain) NSString *instrument;
@property int isBuySell;
@property (nonatomic, retain) id<TradeEvent> delegate;

- (void)setPrice:(NSString *)price extraDigit:(int)extraDigit;
- (void)setColor:(UIColor *)color;

@end
