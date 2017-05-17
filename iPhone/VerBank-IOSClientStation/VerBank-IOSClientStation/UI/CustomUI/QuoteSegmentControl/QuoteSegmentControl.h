//
//  QuoteSegmentControl.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IndexSell 0
#define IndexBuy 1

#define STYLE_RED 0
#define STYLE_BLUE 1
#define STYLE_MIX 2
#define STYLE_NORMAL 3

@protocol QuoteSegmentControlDelegate <NSObject>

- (void)buttonClicked;

@end

@interface QuoteSegmentControl : UIView{
    int _selectIndex;
    int _extradigit;
    
    int _style;
    id <QuoteSegmentControlDelegate> _delegate;
}

//@property int style;
//@property (readwrite)int selectIndex;
@property int extradigit;

@property id<QuoteSegmentControlDelegate> delegate;

//- (id)initWithFrame:(CGRect)frame andStyle:(int)style;

- (void)refreshSegmentAsk:(NSString *)askPrice bidPrice:(NSString *)bidPrice;

- (void)setStyle:(int)style;
- (void)setSelectIndex:(int)index;
- (int)selectIndex;

@end
