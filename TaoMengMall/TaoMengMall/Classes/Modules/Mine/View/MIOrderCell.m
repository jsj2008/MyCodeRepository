//
//  MIOrderCell.m
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "MIOrderCell.h"
#import "OrderViewPagerController.h"
#import "AfterSaleListViewController.h"
#import "MineOrderBadgeModel.h"

@interface MIOrderCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *allOrdersLabel;
@property (nonatomic, strong) UIImageView *moreImageView;


@property (nonatomic, strong) UIImageView *waitPayImageView;
@property (nonatomic, strong) UILabel *waitPayLabel;
@property (nonatomic, strong) UILabel *waitPayBadgeLabel;

@property (nonatomic, strong) UIImageView *waitSendImageView;
@property (nonatomic, strong) UILabel *waitSendLabel;
@property (nonatomic, strong) UILabel *waitSendBadgeLabel;

@property (nonatomic, strong) UIImageView *waitReceiptImageView;
@property (nonatomic, strong) UILabel *waitReceiptLabel;
@property (nonatomic, strong) UILabel *waitReceiptBadgeLabel;

@property (nonatomic, strong) UIImageView *waitReviewsImageView;
@property (nonatomic, strong) UILabel *waitReviewsLabel;
@property (nonatomic, strong) UILabel *waitReviewsBadgeLabel;

@property (nonatomic, strong) UIImageView *afterSaleImageView;
@property (nonatomic, strong) UILabel *afterSaleLabel;
@property (nonatomic, strong) UILabel *afterSaleBadgeLabel;
@end

@implementation MIOrderCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    //[self cellAddSubView:self.iconImageView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.lineView];
    [self cellAddSubView:self.allOrdersLabel];
    [self cellAddSubView:self.moreImageView];
    
    [self cellAddSubView:self.waitPayImageView];
    [self cellAddSubView:self.waitPayLabel];
    [self cellAddSubView:self.waitPayBadgeLabel];
    
    [self cellAddSubView:self.waitSendImageView];
    [self cellAddSubView:self.waitSendLabel];
    [self cellAddSubView:self.waitSendBadgeLabel];
    
    [self cellAddSubView:self.waitReceiptImageView];
    [self cellAddSubView:self.waitReceiptLabel];
    [self cellAddSubView:self.waitReceiptBadgeLabel];
    
    [self cellAddSubView:self.waitReviewsImageView];
    [self cellAddSubView:self.waitReviewsLabel];
    [self cellAddSubView:self.waitReviewsBadgeLabel];
    
    [self cellAddSubView:self.afterSaleImageView];
    [self cellAddSubView:self.afterSaleLabel];
    [self cellAddSubView:self.afterSaleBadgeLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orderCellTapped:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)reloadData
{
    if (self.cellData) {
        MineOrderBadgeModel *model = (MineOrderBadgeModel*)self.cellData;

        self.waitPayBadgeLabel.text = model.unpaid;
        self.waitSendBadgeLabel.text = model.unShipping;
        self.waitReceiptBadgeLabel.text = model.unReceived;
        self.waitReviewsBadgeLabel.text = model.unEvaluated;
        self.afterSaleBadgeLabel.text = model.saleAfter;
        
        self.waitPayBadgeLabel.hidden = [model.unpaid isEqualToString:@"0"];
        self.waitSendBadgeLabel.hidden = [model.unShipping isEqualToString:@"0"];
        self.waitReceiptBadgeLabel.hidden = [model.unReceived isEqualToString:@"0"];
        self.waitReviewsBadgeLabel.hidden = [model.unEvaluated isEqualToString:@"0"];
        self.afterSaleBadgeLabel.hidden = [model.saleAfter isEqualToString:@"0"];
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    
    CGFloat height = 0;
    
    height = 45 + 60;
    
    return height;
}

#pragma mark - Getters And Setters

- (UIImageView *)iconImageView {
    
    if ( !_iconImageView ) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 20, 0, 26, 26)];
        _iconImageView.centerY = 22.5;
        _iconImageView.image = [UIImage imageNamed:@"icon_mine_order"];
    }
    
    return _iconImageView;
}

- (UILabel *)titleLabel {
    
    if ( !_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.textColor = Color_Gray42;
        _titleLabel.text = @"我的订单";
        _titleLabel.font = FONT(16);
        [_titleLabel sizeToFit];
        _titleLabel.left = 12;
        _titleLabel.centerY = self.iconImageView.centerY;
    }
    
    return _titleLabel;
    
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
        _lineView.bottom = 45;
    }
    
    return _lineView;
    
}

- (UILabel *)allOrdersLabel
{
    if (!_allOrdersLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray146;
        label.text = @"查看更多订单";
        label.font = FONT(12);
        [label sizeToFit];
        label.right = self.moreImageView.left - 6;
        label.centerY = self.moreImageView.centerY;
        _allOrdersLabel = label;
    }
    return _allOrdersLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = 22.5;
        _moreImageView.right = SCREEN_WIDTH - 15;
    }
    
    return _moreImageView;
}


- (UIImageView *)waitPayImageView {
    
    if ( !_waitPayImageView ) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        imageView.image = [UIImage imageNamed:@"waitPay"];
        imageView.top = self.lineView.bottom + 10;
        imageView.centerX = SCREEN_WIDTH / 10;
        _waitPayImageView = imageView;
    }
    
    return _waitPayImageView;
}

- (UILabel *)waitPayLabel {
    
    if ( !_waitPayLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray42;
        label.font = FONT(12);
        label.text = @"待付款";
        [label sizeToFit];
        label.top = self.waitPayImageView.bottom + 6;
        label.centerX = SCREEN_WIDTH / 10;
        _waitPayLabel = label;
    }
    
    return _waitPayLabel;
}

- (UILabel*)waitPayBadgeLabel
{
    if (!_waitPayBadgeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 15, 15)];
        label.font = FONT(10);
        label.textColor = Color_White;
        label.layer.cornerRadius = 7.5;
        label.layer.masksToBounds = YES;
        label.backgroundColor = RGB(245, 48, 73);
        label.centerX = self.waitPayImageView.right;
        label.centerY = self.waitPayImageView.top;
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        _waitPayBadgeLabel = label;
    }
    return _waitPayBadgeLabel;
}

- (UIImageView *)waitSendImageView {
    
    if ( !_waitSendImageView ) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        imageView.image = [UIImage imageNamed:@"waitSend"];
        imageView.top = self.lineView.bottom + 10;
        imageView.centerX = SCREEN_WIDTH *3/ 10;
        _waitSendImageView = imageView;
    }
    
    return _waitSendImageView;
}

- (UILabel *)waitSendLabel {
    
    if ( !_waitSendLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray42;
        label.font = FONT(12);
        label.text = @"待发货";
        [label sizeToFit];
        label.top = self.waitPayImageView.bottom + 6;
        label.centerX = SCREEN_WIDTH *3/ 10;
        _waitSendLabel = label;
    }
    
    return _waitSendLabel;
}

- (UILabel*)waitSendBadgeLabel
{
    if (!_waitSendBadgeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 15, 15)];
        label.font = FONT(10);
        label.textColor = Color_White;
        label.layer.cornerRadius = 7.5;
        label.layer.masksToBounds = YES;
        label.backgroundColor = RGB(245, 48, 73);
        label.centerX = self.waitSendImageView.right;
        label.centerY = self.waitSendImageView.top;
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        _waitSendBadgeLabel = label;
    }
    return _waitSendBadgeLabel;
}

- (UIImageView *)waitReceiptImageView {
    
    if ( !_waitReceiptImageView ) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        imageView.image = [UIImage imageNamed:@"waitReceipt"];
        imageView.top = self.lineView.bottom + 10;
        imageView.centerX = SCREEN_WIDTH / 2;
        _waitReceiptImageView = imageView;
    }
    
    return _waitReceiptImageView;
}

- (UILabel *)waitReceiptLabel {
    
    if ( !_waitReceiptLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray42;
        label.font = FONT(12);
        label.text = @"待收货";
        [label sizeToFit];
        label.top = self.waitPayImageView.bottom + 6;
        label.centerX = SCREEN_WIDTH / 2;
        _waitReceiptLabel = label;
    }
    
    return _waitReceiptLabel;
}

- (UILabel*)waitReceiptBadgeLabel
{
    if (!_waitReceiptBadgeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 15, 15)];
        label.font = FONT(10);
        label.textColor = Color_White;
        label.layer.cornerRadius = 7.5;
        label.layer.masksToBounds = YES;
        label.backgroundColor = RGB(245, 48, 73);
        label.centerX = self.waitReceiptImageView.right;
        label.centerY = self.waitReceiptImageView.top;
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        _waitReceiptBadgeLabel = label;
    }
    return _waitReceiptBadgeLabel;
}


- (UIImageView *)waitReviewsImageView {
    
    if ( !_waitReviewsImageView ) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        imageView.image = [UIImage imageNamed:@"waitReviews"];
        imageView.top = self.lineView.bottom + 10;
        imageView.centerX = SCREEN_WIDTH *7/ 10;
        _waitReviewsImageView = imageView;
    }
    
    return _waitReviewsImageView;
}

- (UILabel *)waitReviewsLabel {
    
    if ( !_waitReviewsLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray42;
        label.font = FONT(12);
        label.text = @"待评价";
        [label sizeToFit];
        label.top = self.waitPayImageView.bottom + 6;
        label.centerX = SCREEN_WIDTH *7/ 10;
        _waitReviewsLabel = label;
    }
    
    return _waitReviewsLabel;
}

- (UILabel*)waitReviewsBadgeLabel
{
    if (!_waitReviewsBadgeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 15, 15)];
        label.font = FONT(10);
        label.textColor = Color_White;
        label.layer.cornerRadius = 7.5;
        label.layer.masksToBounds = YES;
        label.backgroundColor = RGB(245, 48, 73);
        label.centerX = self.waitReviewsImageView.right;
        label.centerY = self.waitReviewsImageView.top;
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        _waitReviewsBadgeLabel = label;
    }
    return _waitReviewsBadgeLabel;
}

- (UIImageView *)afterSaleImageView {
    
    if ( !_afterSaleImageView ) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        imageView.image = [UIImage imageNamed:@"afterSale"];
        imageView.top = self.lineView.bottom + 10;
        imageView.centerX = SCREEN_WIDTH *9/ 10;
        _afterSaleImageView = imageView;
    }
    
    return _afterSaleImageView;
}

- (UILabel *)afterSaleLabel {
    
    if ( !_afterSaleLabel ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray42;
        label.font = FONT(12);
        label.text = @"售后";
        [label sizeToFit];
        label.top = self.waitPayImageView.bottom + 6;
        label.centerX = SCREEN_WIDTH *9/ 10;
        _afterSaleLabel = label;
    }
    
    return _afterSaleLabel;
}

- (UILabel*)afterSaleBadgeLabel
{
    if (!_afterSaleBadgeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 15, 15)];
        label.font = FONT(10);
        label.textColor = Color_White;
        label.layer.cornerRadius = 7.5;
        label.layer.masksToBounds = YES;
        label.backgroundColor = RGB(245, 48, 73);
        label.centerX = self.afterSaleImageView.right;
        label.centerY = self.afterSaleImageView.top;
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        _afterSaleBadgeLabel = label;
    }
    return _afterSaleBadgeLabel;
}

#pragma mark - tap gesture
- (void)orderCellTapped:(UITapGestureRecognizer*)gesture
{
    NSString *link = nil;

    CGPoint location = [gesture locationInView:self];
    //跳转所有订单
    if (location.y < 45) {
         link = @"xiaoma://mallOrderList";
        [[TTNavigationService sharedService] openUrl:link];
    }else{
        CGFloat x = location.x;
        OrderViewPagerController *orderPageVC = [[OrderViewPagerController alloc]init];
        //跳转待付款
        if (x < SCREEN_WIDTH/5) {
            orderPageVC.selectedIndex = @"1";
             [[[ApplicationEntrance shareEntrance] currentNavigationController] pushViewController:orderPageVC animated:YES onCompletion:^{
             }];
        //跳转待发货
        }else if (x < SCREEN_WIDTH*2/5) {
            orderPageVC.selectedIndex = @"2";
            [[[ApplicationEntrance shareEntrance] currentNavigationController] pushViewController:orderPageVC animated:YES onCompletion:^{
            }];

        //跳转待收货
        }else if (x < SCREEN_WIDTH*3/5) {
            orderPageVC.selectedIndex = @"3";
            [[[ApplicationEntrance shareEntrance] currentNavigationController] pushViewController:orderPageVC animated:YES onCompletion:^{
            }];
        //跳转待评价
        }else if (x < SCREEN_WIDTH *4/5) {
            orderPageVC.selectedIndex = @"4";
            [[[ApplicationEntrance shareEntrance] currentNavigationController] pushViewController:orderPageVC animated:YES onCompletion:^{
            }];
        //跳转售后
        }else {
            AfterSaleListViewController *afterSaleVC = [[AfterSaleListViewController alloc]init];
            [[[ApplicationEntrance shareEntrance] currentNavigationController] pushViewController:afterSaleVC animated:YES onCompletion:^{
            }];
        }
    }

}
@end
