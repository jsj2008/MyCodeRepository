//
//  QuoteView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/26.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "QuoteSubButton.h"

//typedef NS_ENUM(NSUInteger, QuoteBuySellType) {
//    QuoteViewTypeBuy    = 0,
//    QuoteViewTypeSell   = 1,
//    QuoteViewTypeUnknow = 2
//};

@protocol QuoteViewDelegate <NSObject>

- (void)didClickQuoteViewAtType:(int)buySellType;

@end

@interface QuoteView : UIView {
    IBOutlet UIView *_mainView;
    IBOutlet QuoteSubButton *_leftSubview;
    IBOutlet QuoteSubButton *_rightSubview;
    IBOutlet UILabel *_instrumentLabel;
}

@property (nonatomic, retain) UIView *mainView;

@property (nonatomic, retain) QuoteSubButton *leftSubview;
@property (nonatomic, retain) QuoteSubButton *rightSubview;
@property (nonatomic, retain) UILabel *instrumentLabel;

// 是否需要切换 买卖属性
@property Boolean isNeedChangeBuySell;

@property int currentBuySell;

- (void)setBuyStatus;
- (void)setSellStatus;

- (void)addClickListener;

- (void)setDelegate:(id<QuoteViewDelegate>)delegate;

- (void)setEditAble:(Boolean)editAble;

@end
