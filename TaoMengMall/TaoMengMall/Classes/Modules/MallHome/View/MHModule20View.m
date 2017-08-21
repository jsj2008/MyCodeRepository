//
//  MHModule20View.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/20.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule20View.h"
#import "XMAppThemeHelper.h"

#define PADDING 10.f
#define ICON_WIDTH ((SCREEN_WIDTH - PADDING * 3) / 2)

@interface MHModule20View()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *bottomline;

@property (nonatomic, strong) MHItemModel *wallItem;

@end

@implementation MHModule20View

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        [self addSubview:self.bkgView];
        //        [self addSubview:self.headButton];
        [self.bkgView addSubview:self.itemImageView];
        [self.bkgView addSubview:self.titleLabel];
        [self.bkgView addSubview:self.priceLabel];
        //        [self.bkgView addSubview:self.bottomline];
        self.userInteractionEnabled = YES;
        weakify(self);
        [self bk_whenTapped:^{
            strongify(self);
            [self handleTap];
        }];
    }
    
    return self;
}

- (void)reloadData:(MHItemModel *)wallItem
{
    if (wallItem) {
        self.itemImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.priceLabel.hidden = NO;
        
        self.wallItem = wallItem;
        
        self.bkgView.height = self.width / wallItem.ar + 50;
        
        [self.itemImageView setOnlineImage:wallItem.image placeHolderImage:[UIImage imageNamed:@"placeholder_h"]];
        self.itemImageView.height = self.width / wallItem.ar;
        
        
        self.titleLabel.text = wallItem.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.width = self.bkgView.width;
        self.titleLabel.left = self.itemImageView.left+5;
        self.titleLabel.top = self.itemImageView.bottom + 4;
        
        self.priceLabel.text = wallItem.desc;
        [self.priceLabel sizeToFit];
        self.priceLabel.width = self.width;
        self.priceLabel.left = self.itemImageView.left+5;
        self.priceLabel.top = self.titleLabel.bottom + 5;
        self.priceLabel.textColor = [XMAppThemeHelper defaultTheme].mainThemeColor;
    }else {
        self.bkgView.backgroundColor = [UIColor clearColor];
        self.wallItem = nil;
        
        self.itemImageView.image = nil;
        self.itemImageView.hidden = YES;
        
        self.titleLabel.text = @"";
        self.titleLabel.hidden = YES;
        
        self.priceLabel.text = @"";
        self.titleLabel.hidden = YES;
    }
}

#pragma mark - Getters And Setters

- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width +60)];
        view.backgroundColor = Color_White;
        _bkgView = view;
    }
    return _bkgView;
}

- (UIButton*)headButton
{
    if (!_headButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 28)];
        [button setTitleColor:Color_Black forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        [button setBackgroundImage:[UIImage imageNamed:@"mall_item_header"] forState:UIControlStateNormal];
        _headButton = button;
    }
    return _headButton;
}

- (UIImageView *)itemImageView {
    
    if ( !_itemImageView ) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bkgView.width , self.bkgView.width - 8*2)];
    }
    
    return _itemImageView;
}

- (UILabel *)titleLabel {
    
    if ( !_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.textColor = Color_Gray(45);
        _titleLabel.font = FONT(14);
    }
    
    return _titleLabel;
    
}

- (UILabel *)priceLabel {
    
    if ( !_priceLabel ) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _priceLabel.textColor = Color_Gray(5);
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _priceLabel.font = font;
    }
    
    return _priceLabel;
    
}

- (UIView*)bottomline
{
    if (!_bottomline) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.bkgView.height-2, self.bkgView.width, 2)];
        view.backgroundColor = Color_Yellow;
        _bottomline = view;
    }
    return _bottomline;
}


#pragma mark - Event Response

- (void)handleTap {
    
    if ( self.wallItem ) {
        [[TTNavigationService sharedService] openUrl:self.wallItem.link];
    }
    
}
@end
