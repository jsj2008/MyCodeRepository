//
//  ODLOperateCell.m
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODLOperateCell.h"

@interface ODLOperateCell ()
@property (nonatomic, strong) UIView *bkgView;

@property (nonatomic, strong) UIButton *payButton; //付款
@property (nonatomic, strong) UIButton *receiptButton; // 收货
@property (nonatomic, strong) UIButton *rateButton; // 评价
@property (nonatomic, strong) UIButton *deleteButton; // 删除
@property (nonatomic, strong) UIButton *cancelButton; // 取消

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSString *payId;
@property (nonatomic, strong) NSString *payLink;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSDictionary *buttons;
@property (nonatomic, strong) NSString *reviewLink;
@property (nonatomic, strong) UIView *pipe1View;
@property (nonatomic, strong) UIView *pipe2View;
@end

@implementation ODLOperateCell

- (void)drawCell
{
    [self cellAddSubView:self.bkgView];
    [self cellAddSubView:self.payButton];
    [self cellAddSubView:self.receiptButton];
    [self cellAddSubView:self.rateButton];
    
    [self cellAddSubView:self.deleteButton];
    [self cellAddSubView:self.cancelButton];
    
    [self cellAddSubView:self.lineView];
    [self cellAddSubView:self.pipe1View];
    [self cellAddSubView:self.pipe2View];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *data = (NSDictionary *)self.cellData;
        //NSString *status = data[@"status"];
        self.payId = data[@"payId"];
        self.orderId = data[@"orderId"];
        self.payLink = data[@"payLink"];
        self.buttons = data[@"buttons"];
        //self.buttons = @{@"showCanceling": @"",@"showEvaluating": @"xiaoma://cashier?orders=[789]&from=orderList",@"showDeleting":@"",@"showReceiving":@"",@"showPaying": @"xiaoma://cashier?orders=[789]&from=orderList"};
        self.payButton.hidden = YES;
        self.receiptButton.hidden = YES;
        self.rateButton.hidden = YES;
        
        self.deleteButton.hidden = YES;
        self.cancelButton.hidden = YES;
        
        NSArray *keys = [self.buttons allKeys];
        NSInteger index = 0;
        NSArray *allKeys = @[@"showPaying",@"showEvaluating",@"showReceiving",@"showDeleting",@"showCanceling"];
        for (int i = 0; i < allKeys.count; i++) {
            
            for (NSString *key in keys) {
                
                if ([key isEqualToString:[allKeys safeObjectAtIndex:i]]) {
                    
                    if ([key isEqualToString:@"showCanceling"]) {
                        self.cancelButton.hidden = NO;
                        self.cancelButton.right = SCREEN_WIDTH - 20 - (86+10)*index;
                        index ++;
                    }else if ([key isEqualToString:@"showPaying"]) {
                        self.payButton.hidden = NO;
                        self.payLink = [self.buttons objectForKey:@"showPaying"];
                        self.payButton.right = SCREEN_WIDTH - 20 - (86+10)*index;
                        index ++;
                    }else if ([key isEqualToString:@"showReceiving"]) {
                        self.receiptButton.hidden = NO;
                        self.receiptButton.right = SCREEN_WIDTH - 20 - (86+10)*index;
                        index ++;
                    }else if ([key isEqualToString:@"showEvaluating"]) {
                        self.rateButton.hidden = NO;
                        self.reviewLink = [self.buttons objectForKey:@"showEvaluating"];
                        self.rateButton.right = SCREEN_WIDTH - 20 - (86+10)*index;
                        index ++;
                    }else if ([key isEqualToString:@"showDeleting"]) {
                        self.deleteButton.hidden = NO;
                        self.deleteButton.right = SCREEN_WIDTH - 20 - (86+10)*index;
                        index ++;
                    }

                }
                
            }
        }
        
//        for (NSString *key in keys) {
//            
//            if ([key isEqualToString:@"showCanceling"]) {
//                self.cancelButton.hidden = NO;
//            }else if ([key isEqualToString:@"showPaying"]) {
//                self.payButton.hidden = NO;
//                self.payLink = [self.buttons objectForKey:@"showPaying"];
//            }else if ([key isEqualToString:@"showReceiving"]) {
//                self.receiptButton.hidden = NO;
//            }else if ([key isEqualToString:@"showEvaluating"]) {
//                self.rateButton.hidden = NO;
//                self.reviewLink = [self.buttons objectForKey:@"showEvaluating"];
//            }else if ([key isEqualToString:@"showDeleting"]) {
//                self.deleteButton.hidden = NO;
//            }
//        }

        
        
//        if ( [@"1" isEqualToString:status] ) {
//            
//            self.payButton.hidden = NO;
//            self.cancelButton.hidden = NO;
//            
//        } else if ( [@"3" isEqualToString:status] ) {
//            
//            self.receiptButton.hidden = NO;
//            
//        } else if ( [@"4" isEqualToString:status] ) {
//            
//            self.rateButton.hidden = NO;
//            
//        } else if ( [@"5" isEqualToString:status]||
//                   [@"6" isEqualToString:status]) {
//            
//            self.deleteButton.hidden = NO;
//            
//        }
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        
        NSDictionary *data = (NSDictionary *)cellData;
        //NSString *status = [data objectForKey:@"status"];
        NSDictionary *buttons = [data objectForKey:@"buttons"];
        NSArray *keys = [buttons allKeys];
 
        if (keys.count > 0) {
            return 50;
        }
        
//        if ( [@"1" isEqualToString:status] || [@"3" isEqualToString:status] || [@"4" isEqualToString:status] || [@"5" isEqualToString:status] || [@"6" isEqualToString:status]) {
//            return 50;
//        }
    }
    return 0;
}

#pragma mark - Getters And Setters
- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 50)];
        view.backgroundColor = Color_Gray(255);
        _bkgView = view;
    }
    return _bkgView;
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(22, 50-LINE_WIDTH, SCREEN_WIDTH - 22 * 2, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
        
    }
    
    return _lineView;
    
}

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
        _payButton.layer.borderWidth = 1.;
        _payButton.layer.borderColor = Theme_Color.CGColor;
        _payButton.centerY = 25;
        
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
        _receiptButton.layer.borderWidth = 1.;
        _receiptButton.layer.borderColor = Theme_Color.CGColor;
        _receiptButton.centerY = 25;
        _receiptButton.layer.masksToBounds = YES;
        _receiptButton.layer.cornerRadius = 2.0f;
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
        _rateButton.layer.borderWidth = 1.;
        _rateButton.layer.borderColor = Theme_Color.CGColor;
        _rateButton.centerY = 25;
        _rateButton.layer.masksToBounds = YES;
        _rateButton.layer.cornerRadius = 2.0f;        _rateButton.right = SCREEN_WIDTH - 20;
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
        _cancelButton.right = SCREEN_WIDTH - 20 - 70 - 10;
    }
    
    return _cancelButton;
}

- (UIView*)pipe1View
{
    if (!_pipe1View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LINE_WIDTH, 50)];
        view.backgroundColor = Color_Gray238;
        _pipe1View = view;
    }
    return _pipe1View;
}

- (UIView*)pipe2View
{
    if (!_pipe2View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-LINE_WIDTH, 0, LINE_WIDTH, 50)];
        view.backgroundColor = Color_Gray238;
        _pipe2View = view;
    }
    return _pipe2View;
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
    if ( [self.delegate respondsToSelector:@selector(receiptButtonDidTappedWithOrderId:)]) {
        [self.delegate receiptButtonDidTappedWithOrderId:self.orderId];
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
    if ( [self.delegate respondsToSelector:@selector(deleteButtonDidTappedWithOrderId:)]) {
        [self.delegate deleteButtonDidTappedWithOrderId:self.orderId];
    }
}

- (void) handleCancelButton {
    DBG(@"取消");
    if ( [self.delegate respondsToSelector:@selector(cancelButtonDidTappedWithOrderId:)]) {
        [self.delegate cancelButtonDidTappedWithOrderId:self.orderId];
    }
}

@end
