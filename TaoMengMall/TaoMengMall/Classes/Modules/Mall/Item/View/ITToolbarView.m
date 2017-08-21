//
//  ITToolbarView.m
//  HongBao
//
//  Created by Ivan on 16/2/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITToolbarView.h"

@interface ITToolbarView ()

@property (nonatomic, strong) UIButton *chatButton;
@property (nonatomic, strong) UILabel *chatLabel;
@property (nonatomic, strong) UIImageView *chatImageView;

@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIImageView *likeImageView;

@property (nonatomic, strong) UIButton *shopButton;
@property (nonatomic, strong) UILabel *shopLabel;
@property (nonatomic, strong) UIImageView *shopImageView;

@property (nonatomic, strong) UIButton *addToCartButton;
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) UIView *vLineView1;
@property (nonatomic, strong) UIView *vLineView2;

@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation ITToolbarView

- (ITToolbarView *) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = Color_White;
    
    [self addSubview:self.hLineView];
    
//    [self addSubview:self.chatLabel];
//    [self addSubview:self.chatImageView];
//    [self addSubview:self.chatButton];
//    
//    [self addSubview:self.vLineView1];
    
    [self addSubview:self.likeLabel];
    [self addSubview:self.likeImageView];
    [self addSubview:self.likeButton];
    
    [self addSubview:self.vLineView2];
    
    [self addSubview:self.shopLabel];
    [self addSubview:self.shopImageView];
    [self addSubview:self.shopButton];
    
    [self addSubview:self.addToCartButton];
    [self addSubview:self.buyButton];
    [self addSubview:self.statusLabel];
    
    return self;
}

#pragma mark - Custom Methods

- (void) render {
    
//    self.chatImageView.top = 8;
//    self.chatImageView.centerX = self.chatButton.centerX;
//    
//    self.chatLabel.top = 25;
//    self.chatLabel.centerX = self.chatButton.centerX;
    
    self.likeImageView.top = 8;
    self.likeImageView.centerX = self.likeButton.centerX;
    
    self.likeLabel.top = 25;
    self.likeLabel.centerX = self.likeButton.centerX;
    
    self.shopImageView.top = 8;
    self.shopImageView.centerX = self.shopButton.centerX;
    
    self.shopLabel.top = 25;
    self.shopLabel.centerX = self.shopButton.centerX;
    
    self.buyButton.right = SCREEN_WIDTH - 10;
    self.buyButton.top = ( self.height - self.buyButton.height ) / 2;
    self.addToCartButton.right = self.buyButton.left - 10;
    self.addToCartButton.centerY = self.buyButton.centerY;
    
    if ( self.isFav ) {
        self.likeImageView.image = [UIImage imageNamed:@"icon_liked"];
    } else {
        self.likeImageView.image = [UIImage imageNamed:@"icon_like"];
    }
    //self.status = @"2";
    if ( [self.status isEqualToString:@"0"]) {
        self.buyButton.enabled = YES;
        self.addToCartButton.enabled = YES;
        self.addToCartButton.alpha = 1;
        self.buyButton.alpha = 1;
        self.statusLabel.hidden = YES;
        //self.addToCartButton.layer.borderColor = [Color_Gray(189) CGColor];
        //[self.buyButton setBackgroundColor:Theme_Color];
        //self.buyButton.layer.borderColor = [Color_Gray(44) CGColor];
    } else {
        self.buyButton.enabled = NO;
        self.addToCartButton.enabled = NO;
        self.addToCartButton.alpha = 0.38;
        self.buyButton.alpha = 0.38;
        //self.addToCartButton.layer.borderColor = [Color_Gray187 CGColor];
        //[self.buyButton setBackgroundColor:Color_Gray140];
        //self.buyButton.layer.borderColor = [Color_Gray140 CGColor];
        
//        if ( [@"1" isEqualToString:self.status] ) {
//            [self.buyButton setTitle:@"已售罄" forState:UIControlStateDisabled];
//        } else if ( [@"2" isEqualToString:self.status] ) {
//            [self.buyButton setTitle:@"已下架" forState:UIControlStateDisabled];
//        }
        if ( [@"1" isEqualToString:self.status] ) {
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"已售罄";
        } else if ( [@"2" isEqualToString:self.status] ) {
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"已下架";
        }

    }
    
}

#pragma mark - Getters And Setters

- (UIView *)hLineView {
    
    if ( !_hLineView ) {
        _hLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _hLineView.backgroundColor = Color_Gray224;
    }
    
    return _hLineView;
}

- (UIButton *)chatButton {
    
    if ( !_chatButton ) {
        _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chatButton.frame = CGRectMake(0, 0, 52, 45);
        [_chatButton addTarget:self action:@selector(handleChatButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _chatButton;
}

- (UILabel *)chatLabel {
    
    if ( !_chatLabel ) {
        _chatLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _chatLabel.textColor = Color_Gray130;
        _chatLabel.font = FONT(10);
        _chatLabel.text = @"客服";
        [_chatLabel sizeToFit];
    }
    
    return _chatLabel;
}

- (UIImageView *)chatImageView {
    
    if ( !_chatImageView ) {
        _chatImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 16, 15)];
        _chatImageView.image = [UIImage imageNamed:@"icon_support"];
    }
    
    return _chatImageView;
}

- (UIView *)vLineView1 {
    
    if ( !_vLineView1 ) {
        _vLineView1 = [[UIView alloc] initWithFrame:CGRectMake(52, 0, 1, self.height)];
        _vLineView1.backgroundColor = Color_Gray224;
    }
    
    return _vLineView1;
}

- (UIButton *)likeButton {
    
    if ( !_likeButton ) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _likeButton.frame = CGRectMake(53, 0, 52, 45);
        _likeButton.frame = CGRectMake(0, 0, 77, 45);
        [_likeButton addTarget:self action:@selector(handleLikeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _likeButton;
}

- (UILabel *)likeLabel {
    
    if ( !_likeLabel ) {
        _likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _likeLabel.textColor = Color_Gray130;
        _likeLabel.font = FONT(10);
        _likeLabel.text = @"收藏";
        [_likeLabel sizeToFit];
    }
    
    return _likeLabel;
}

- (UIImageView *)likeImageView {
    
    if ( !_likeImageView ) {
        _likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 16, 15)];
        _likeImageView.image = [UIImage imageNamed:@"icon_like"];
    }
    
    return _likeImageView;
}

- (UIView *)vLineView2 {
    
    if ( !_vLineView2 ) {
//        _vLineView2 = [[UIView alloc] initWithFrame:CGRectMake(105, 0, 1, self.height)];
        _vLineView2 = [[UIView alloc] initWithFrame:CGRectMake(78, 0, 1, self.height)];
        _vLineView2.backgroundColor = Color_Gray224;
    }
    
    return _vLineView2;
}

- (UIButton *)shopButton {
    
    if ( !_shopButton ) {
        _shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _shopButton.frame = CGRectMake(106, 0, 52, 45);
        _shopButton.frame = CGRectMake(79, 0, 78, 45);
        [_shopButton addTarget:self action:@selector(handleShopButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _shopButton;
}

- (UILabel *)shopLabel {
    
    if ( !_shopLabel ) {
        _shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shopLabel.textColor = Color_Gray130;
        _shopLabel.font = FONT(10);
        _shopLabel.text = @"店铺";
        [_shopLabel sizeToFit];
    }
    
    return _shopLabel;
}

- (UIImageView *)shopImageView {
    
    if ( !_shopImageView ) {
        _shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 17, 15)];
        _shopImageView.image = [UIImage imageNamed:@"icon_shop"];
    }
    
    return _shopImageView;
}

- (UIButton *)addToCartButton {
    
    if ( !_addToCartButton ) {
        _addToCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addToCartButton.frame = CGRectMake(0, 0, ( SCREEN_WIDTH - 158 - 10 * 2) / 2, 32);
        _addToCartButton.titleLabel.font = FONT(16);
        [_addToCartButton addTarget:self action:@selector(handleAddToCartButton) forControlEvents:UIControlEventTouchUpInside];
        [_addToCartButton setTitleColor:Color_Gray(255) forState:UIControlStateNormal];
        [_addToCartButton setTitleColor:Color_Gray(255) forState:UIControlStateDisabled];
        [_addToCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addToCartButton setBackgroundColor:Color_Gray(85)];
        if (IS_IPHONE5) {
            _addToCartButton.titleLabel.font = FONT(12);

        }
//        _addToCartButton.layer.borderColor = [Color_Gray(189) CGColor];
//        _addToCartButton.layer.borderWidth = 1.0f;
        _addToCartButton.layer.cornerRadius = 2.;
        _addToCartButton.layer.masksToBounds = YES;
    }
    
    return _addToCartButton;
}

- (UIButton *)buyButton {
    
    if ( !_buyButton ) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.frame = CGRectMake(0, 0, ( SCREEN_WIDTH - 158 - 10 * 2) / 2, 32);
        _buyButton.titleLabel.font = FONT(16);
        [_buyButton addTarget:self action:@selector(handleBuyButton) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton setBackgroundColor:Theme_Color];
        if (IS_IPHONE5) {
            _buyButton.titleLabel.font = FONT(12);
        }
//        _buyButton.layer.borderColor = [Color_Gray42 CGColor];
//        _buyButton.layer.borderWidth = 1.0f;
        _buyButton.layer.cornerRadius = 2.;
        _buyButton.layer.masksToBounds = YES;
    }
    
    return _buyButton;
}

- (UILabel*)statusLabel
{
    if (!_statusLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, -44, SCREEN_WIDTH, 44)];
        label.font = FONT(16);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = Color_White;
        label.backgroundColor = RGBA(0, 0, 0, 0.8);
        label.hidden = YES;
        _statusLabel = label;
    }
    return _statusLabel;
}

#pragma mark - Event Response

- (void) handleChatButton {
    
    if ([self.delegate respondsToSelector:@selector(chatButtonDidClick)]) {
        [self.delegate chatButtonDidClick];
    }
}

- (void) handleLikeButton {
    
    if ([self.delegate respondsToSelector:@selector(likeButtonDidClick)]) {
        [self.delegate likeButtonDidClick];
    }
    
}

- (void) handleShopButton {
    
    if ([self.delegate respondsToSelector:@selector(shopButtonDidClick)]) {
        [self.delegate shopButtonDidClick];
    }
    
}

- (void) handleAddToCartButton {
    
    if ([self.delegate respondsToSelector:@selector(addToCartButtonDidClick)]) {
        [self.delegate addToCartButtonDidClick];
    }
    
}

- (void) handleBuyButton {
    
    if ([self.delegate respondsToSelector:@selector(buyButtonDidClick)]) {
        [self.delegate buyButtonDidClick];
    }
    
}

@end
