//
//  QuoteView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/26.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "QuoteView.h"
#import "LangCaptain.h"

@interface QuoteView() {
    id<QuoteViewDelegate> _delegate;
}

@end

@implementation QuoteView

@synthesize mainView = _mainView;

@synthesize leftSubview = _leftSubview;
@synthesize rightSubview = _rightSubview;
@synthesize instrumentLabel = _instrumentLabel;

@synthesize isNeedChangeBuySell;

@synthesize currentBuySell;

- (void)setDelegate:(id<QuoteViewDelegate>)delegate {
    _delegate = delegate;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"QuoteView" owner:self options:nil];
    [self addSubview:self.mainView];
    [_instrumentLabel setHidden:true];
    [self setDefaultImage];
    [self setDefault];
    // debug
    //    CGRect mainRect = self.mainView.frame;
    //    CGRect bouds = self.bounds;
    //    [self.mainView setFrame:self.bounds];
    [self addClickListener];
}

- (void)setDefaultImage {
    [self.leftSubview.backgroundButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_red_select"] forState:UIControlStateNormal];
    [self.rightSubview.backgroundButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_blue_select"] forState:UIControlStateNormal];
}

- (void)setBuyStatus {
    if (self.isNeedChangeBuySell) {
        self.currentBuySell = BUY;
        [self.leftSubview.backgroundButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_unselect"] forState:UIControlStateNormal];
        [self.rightSubview.backgroundButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_blue_select"] forState:UIControlStateNormal];
    }
    
    // 不管能不能使用 changeBuySell， delegate 消息还是要传， 回调自由实现
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didClickQuoteViewAtType:)]) {
        [_delegate didClickQuoteViewAtType:BUY];
    }
}

- (void)setSellStatus {
    if (self.isNeedChangeBuySell) {
        self.currentBuySell = SELL;
        [self.leftSubview.backgroundButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_red_select"] forState:UIControlStateNormal];
        [self.rightSubview.backgroundButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_unselect"] forState:UIControlStateNormal];
    }
    
    // 不管能不能使用 changeBuySell， delegate 消息还是要传， 回调自由实现
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didClickQuoteViewAtType:)]) {
        [_delegate didClickQuoteViewAtType:SELL];
    }
}

- (void)setDefault {
    // 默认 能使用 切换 // 因为有些地方并不需要这个事件， 所以 在 引用的地方自定义设置。
    self.isNeedChangeBuySell = true;
    [self.leftSubview   setUserInteractionEnabled:true];
    [self.leftSubview   setBackgroundColor:[UIColor clearColor]];
    [self.leftSubview   setBuySellType:SELL];
    
    [self.rightSubview setUserInteractionEnabled:true];
    [self.rightSubview  setBackgroundColor:[UIColor clearColor]];
    [self.rightSubview  setBuySellType:BUY];
    
    [self.mainView      setBackgroundColor:[UIColor clearColor]];
    [self               setBackgroundColor:[UIColor clearColor]];
    
    [self.leftSubview.buySellLabel setText:[[LangCaptain getInstance] getLangByCode:@"SellPrice"]];
    [self.rightSubview.buySellLabel setText:[[LangCaptain getInstance] getLangByCode:@"BuyPrice"]];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    [self.mainView setFrame:mainRect];
    [self.mainView setFrame:self.bounds];
}


- (void)addClickListener {
    [self.leftSubview.backgroundButton   addTarget:self action:@selector(setSellStatus) forControlEvents:UIControlEventTouchUpInside];
    [self.rightSubview.backgroundButton  addTarget:self action:@selector(setBuyStatus) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setEditAble:(Boolean)editAble {
    [self.leftSubview.backgroundButton setUserInteractionEnabled:editAble];
    [self.rightSubview.backgroundButton setUserInteractionEnabled:editAble];
}

@end
