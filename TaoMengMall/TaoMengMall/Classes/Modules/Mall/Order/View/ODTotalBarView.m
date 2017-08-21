//
//  ODTotalBarView.m
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODTotalBarView.h"


@interface ODTotalBarView ()

@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UIButton *payButton; //付款 2
@property (nonatomic, strong) UIButton *receiptButton; // 收货 3
@property (nonatomic, strong) UIButton *rateButton; // 评价 4
@property (nonatomic, strong) UIButton *deleteButton; // 删除
@property (nonatomic, strong) UIButton *cancelButton; // 取消

@property (nonatomic, strong) NSString *payId;
@property (nonatomic, strong) NSString *payLink;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSDictionary *buttons;
@property (nonatomic, strong) NSString *reviewLink;
@end

@implementation ODTotalBarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = Color_White;
        
        [self addSubview:self.totalPriceLabel];
        [self addSubview:self.payButton];
        [self addSubview:self.receiptButton];
        [self addSubview:self.rateButton];
        [self addSubview:self.deleteButton];
        [self addSubview:self.cancelButton];

        
        self.totalPriceLabel.text = @"合计：";//[NSString stringWithFormat:@"合计：%@", totalPrice];
        [self.totalPriceLabel sizeToFit];
        self.totalPriceLabel.centerY = self.height / 2;
        
        self.payButton.centerY = self.totalPriceLabel.centerY;
        self.receiptButton.centerY = self.totalPriceLabel.centerY;
        self.rateButton.centerY = self.totalPriceLabel.centerY;
        self.cancelButton.centerY = self.totalPriceLabel.centerY;
        self.deleteButton.centerY = self.totalPriceLabel.centerY;
    }
    
    return self;
}

#pragma mark - Getters And Setters

- (UILabel *)totalPriceLabel {
    
    if ( !_totalPriceLabel ) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 0, 0)];
        _totalPriceLabel.textColor = Color_Black;
        _totalPriceLabel.font = FONT(16);
        _totalPriceLabel.text = @"合计：";
        
        _totalPriceLabel.numberOfLines = 1;
        [_totalPriceLabel sizeToFit];
    }
    
    return _totalPriceLabel;
}

//- (UIButton *)payButton {
//    
//    if ( !_payButton ) {
//        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _payButton.frame = CGRectMake(0, 0, 101, 37);
//        _payButton.titleLabel.font = FONT(16);
//        _payButton.backgroundColor = Color_Red6;
//        [_payButton addTarget:self action:@selector(handlePayButton) forControlEvents:UIControlEventTouchUpInside];
//        [_payButton setTitleColor:Color_White forState:UIControlStateNormal];
//        [_payButton setTitle:@"付款" forState:UIControlStateNormal];
//        _payButton.layer.masksToBounds = YES;
//        _payButton.layer.cornerRadius = 2.0f;
//        _payButton.right = SCREEN_WIDTH - 12;
//        _payButton.hidden = YES;
//    }
//    
//    return _payButton;
//}
//
//- (UIButton *)receiptButton {
//    
//    if ( !_receiptButton ) {
//        _receiptButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _receiptButton.frame = CGRectMake(0, 0, 101, 37);
//        _receiptButton.titleLabel.font = FONT(16);
//        _receiptButton.backgroundColor = Color_Red6;
//        [_receiptButton addTarget:self action:@selector(handleReceiptButton) forControlEvents:UIControlEventTouchUpInside];
//        [_receiptButton setTitleColor:Color_White forState:UIControlStateNormal];
//        [_receiptButton setTitle:@"收货" forState:UIControlStateNormal];
//        _receiptButton.layer.masksToBounds = YES;
//        _receiptButton.layer.cornerRadius = 2.0f;
//        _receiptButton.right = SCREEN_WIDTH - 12;
//        _receiptButton.hidden = YES;
//    }
//    
//    return _receiptButton;
//}
//
//- (UIButton *)rateButton {
//    
//    if ( !_rateButton ) {
//        _rateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _rateButton.frame = CGRectMake(0, 0, 101, 37);
//        _rateButton.titleLabel.font = FONT(16);
//        _rateButton.backgroundColor = Color_Red6;
//        [_rateButton addTarget:self action:@selector(handleRateButton) forControlEvents:UIControlEventTouchUpInside];
//        [_rateButton setTitleColor:Color_White forState:UIControlStateNormal];
//        [_rateButton setTitle:@"评价" forState:UIControlStateNormal];
//        _rateButton.layer.masksToBounds = YES;
//        _rateButton.layer.cornerRadius = 2.0f;
//        _rateButton.right = SCREEN_WIDTH - 12;
//        _rateButton.hidden = YES;
//    }
//    
//    return _rateButton;
//}

- (UIButton *)payButton {
    
    if ( !_payButton ) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.frame = CGRectMake(0, 0, 86, 33);
        _payButton.titleLabel.font = FONT(14);
        _payButton.backgroundColor = Theme_Color;
        [_payButton addTarget:self action:@selector(handlePayButton) forControlEvents:UIControlEventTouchUpInside];
        [_payButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_payButton setTitle:@"付款" forState:UIControlStateNormal];
        _payButton.layer.masksToBounds = YES;
        _payButton.layer.cornerRadius = 2.0f;
        _payButton.layer.borderColor = Theme_Color.CGColor;
        _payButton.layer.borderWidth = 1.;
        _payButton.centerY = 25;
        if (IS_IPHONE5) {
            _payButton.width = 70;
            _payButton.height = 27;
        }
        _payButton.right = SCREEN_WIDTH - 20;
    }
    
    return _payButton;
}

- (UIButton *)receiptButton {
    
    if ( !_receiptButton ) {
        _receiptButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _receiptButton.frame = CGRectMake(0, 0, 86, 33);
        _receiptButton.titleLabel.font = FONT(14);
        _receiptButton.backgroundColor = Theme_Color;
        [_receiptButton addTarget:self action:@selector(handleReceiptButton) forControlEvents:UIControlEventTouchUpInside];
        [_receiptButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_receiptButton setTitle:@"收货" forState:UIControlStateNormal];
        _receiptButton.layer.masksToBounds = YES;
        _receiptButton.layer.cornerRadius = 2.0f;
        _receiptButton.layer.borderColor = Theme_Color.CGColor;
        _receiptButton.layer.borderWidth = 1.;
        _receiptButton.centerY = 25;
        if (IS_IPHONE5) {
            _receiptButton.width = 70;
            _receiptButton.height = 27;

        }
        _receiptButton.right = SCREEN_WIDTH - 20;
    }
    
    return _receiptButton;
}

- (UIButton *)rateButton {
    
    if ( !_rateButton ) {
        _rateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rateButton.frame = CGRectMake(0, 0, 86, 33);
        _rateButton.titleLabel.font = FONT(14);
        _rateButton.backgroundColor = Theme_Color;
        [_rateButton addTarget:self action:@selector(handleRateButton) forControlEvents:UIControlEventTouchUpInside];
        [_rateButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_rateButton setTitle:@"评价" forState:UIControlStateNormal];
        _rateButton.layer.masksToBounds = YES;
        _rateButton.layer.cornerRadius = 2.0f;
        _rateButton.layer.borderColor = Theme_Color.CGColor;
        _rateButton.layer.borderWidth = 1.;
        _rateButton.centerY = 25;
        if (IS_IPHONE5) {
            _rateButton.width = 70;
            _rateButton.height = 27;

        }
        _rateButton.right = SCREEN_WIDTH - 20;
    }
    
    return _rateButton;
}

- (UIButton *)deleteButton {
    
    if ( !_deleteButton ) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(0, 0, 86, 33);
        _deleteButton.titleLabel.font = FONT(14);
        _deleteButton.backgroundColor = Color_White;
        [_deleteButton addTarget:self action:@selector(handleDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setTitleColor:Color_Gray187 forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.cornerRadius = 2.0f;
        _deleteButton.layer.borderColor = Color_Gray187.CGColor;
        _deleteButton.layer.borderWidth = LINE_WIDTH;
        _deleteButton.centerY = 25;
        if (IS_IPHONE5) {
            _deleteButton.width = 70;
            _deleteButton.height = 27;

        }
        _deleteButton.right = SCREEN_WIDTH - 20;
        
    }
    
    return _deleteButton;
}

- (UIButton *)cancelButton {
    
    if ( !_cancelButton ) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 0, 86, 33);
        _cancelButton.titleLabel.font = FONT(14);
        _cancelButton.backgroundColor = Color_White;
        [_cancelButton addTarget:self action:@selector(handleCancelButton) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitleColor:Color_Gray187 forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 2.0f;
        _cancelButton.layer.borderColor = Color_Gray187.CGColor;
        _cancelButton.layer.borderWidth = LINE_WIDTH;
        _cancelButton.centerY = 25;
        if (IS_IPHONE5) {
            _cancelButton.width = 70;
            _cancelButton.right = SCREEN_WIDTH - 20 - 70 - 10;
            _cancelButton.height = 27;

        }else {
            _cancelButton.right = SCREEN_WIDTH - 20 - 86 - 10;
        }
    }
    
    return _cancelButton;
}



- (void)setTotalPrice:(NSString *)totalPrice {
    _totalPrice = totalPrice;
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：%@", totalPrice];
    [self.totalPriceLabel sizeToFit];
}

//- (void)setStatus:(NSString *)status {
//    _status = status;
//    
//    self.payButton.hidden = YES;
//    self.receiptButton.hidden = YES;
//    self.rateButton.hidden = YES;
//    
//    if ( [@"1" isEqualToString:status] ) {
//        
//        self.payButton.hidden = NO;
//        
//    } else if ( [@"3" isEqualToString:status] ) {
//        
//        self.receiptButton.hidden = NO;
//        
//    } else if ( [@"4" isEqualToString:status] ) {
//        
//        self.rateButton.hidden = NO;
//        
//    }
//}

- (void)reloadData
{
    self.payButton.hidden = YES;
    self.receiptButton.hidden = YES;
    self.rateButton.hidden = YES;
    
    self.deleteButton.hidden = YES;
    self.cancelButton.hidden = YES;
    CGFloat buttonWith;
    if (IS_IPHONE5) {
        buttonWith = 70;
    }else {
        buttonWith = 86;
    }
    if (self.viewData) {
        
        self.buttons = (NSDictionary *)self.viewData;
        //self.buttons = @{@"showCanceling": @"",@"showEvaluating": @"xiaoma://cashier?orders=[789]&from=orderList",@"showDeleting":@"",@"showReceiving":@"",@"showPaying": @"xiaoma://cashier?orders=[789]&from=orderList",};
        NSArray *keys = [self.buttons allKeys];
        NSInteger index = 0;
        NSArray *allKeys = @[@"showPaying",@"showEvaluating",@"showReceiving",@"showDeleting",@"showCanceling"];
        for (int i = 0; i < allKeys.count; i++) {
            
            for (NSString *key in keys) {
                
                if ([key isEqualToString:[allKeys safeObjectAtIndex:i]]) {
                    
                    if ([key isEqualToString:@"showCanceling"]) {
                        self.cancelButton.hidden = NO;
                        self.cancelButton.right = SCREEN_WIDTH - 20 - (buttonWith+10)*index;
                        index ++;
                    }else if ([key isEqualToString:@"showPaying"]) {
                        self.payButton.hidden = NO;
                        self.payLink = [self.buttons objectForKey:@"showPaying"];
                        self.payButton.right = SCREEN_WIDTH - 20 - (buttonWith+10)*index;
                        index ++;
                    }else if ([key isEqualToString:@"showReceiving"]) {
                        self.receiptButton.hidden = NO;
                        self.receiptButton.right = SCREEN_WIDTH - 20 - (buttonWith+10)*index;
                        index ++;
                    }else if ([key isEqualToString:@"showEvaluating"]) {
                        self.rateButton.hidden = NO;
                        self.reviewLink = [self.buttons objectForKey:@"showEvaluating"];
                        self.rateButton.right = SCREEN_WIDTH - 20 - (buttonWith+10)*index;
                        index ++;
                    }else if ([key isEqualToString:@"showDeleting"]) {
                        self.deleteButton.hidden = NO;
                        self.deleteButton.right = SCREEN_WIDTH - 20 - (buttonWith+10)*index;
                        index ++;
                    }
                    
                }
                
            }
        }
        
    }
}


#pragma mark - Event Response

- (void) handlePayButton {
    
    DBG(@"付款");
    
    if ( [self.delegate respondsToSelector:@selector(payButtonDidTappedWithPayLink:)]) {
        [self.delegate payButtonDidTappedWithPayLink:self.payLink];
    }
    
}

- (void) handleReceiptButton {
    
    DBG(@"收货");
    if ( [self.delegate respondsToSelector:@selector(receiptButtonDidTapped)]) {
        [self.delegate receiptButtonDidTapped];
    }
    
}

- (void) handleRateButton {
    
    DBG(@"评价");
    if ( [self.delegate respondsToSelector:@selector(rateButtonDidTappedWithRateLink:)]) {
        [self.delegate rateButtonDidTappedWithRateLink:self.reviewLink];
    }
}

- (void) handleDeleteButton {
    DBG(@"删除");
    if ( [self.delegate respondsToSelector:@selector(deleteButtonDidTapped)]) {
        [self.delegate deleteButtonDidTapped];
    }
}

- (void) handleCancelButton {
    DBG(@"取消");
    if ( [self.delegate respondsToSelector:@selector(cancelButtonDidTapped)]) {
        [self.delegate cancelButtonDidTapped];
    }
}

@end
