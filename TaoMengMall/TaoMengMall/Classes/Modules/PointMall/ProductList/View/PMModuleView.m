//
//  MHModule20View.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/20.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "PMModuleView.h"

#define PADDING 10.f
#define ICON_WIDTH ((SCREEN_WIDTH - PADDING * 3) / 2)

@interface PMModuleView()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UIView *bottomline;

@property (nonatomic, strong) PMItemModel *wallItem;

@end

@implementation PMModuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        [self addSubview:self.bkgView];
//        [self addSubview:self.headButton];
        [self.bkgView addSubview:self.itemImageView];
        [self.bkgView addSubview:self.titleLable];
        [self.bkgView addSubview:self.priceLable];
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

- (void)reloadData:(PMItemModel *)wallItem
{
    if (wallItem) {
        self.itemImageView.hidden = NO;
        self.titleLable.hidden = NO;
        self.priceLable.hidden = NO;
        
        self.wallItem = wallItem;

        self.bkgView.height = self.width / wallItem.ar + 50;
        
        [self.itemImageView setOnlineImage:wallItem.image placeHolderImage:[UIImage imageNamed:@"placeholder_h"]];
        self.itemImageView.height = self.width / wallItem.ar;
     
        
        self.titleLable.text = wallItem.title;
        [self.titleLable sizeToFit];
        self.titleLable.width = self.bkgView.width;
        self.titleLable.left = self.itemImageView.left+5;
        self.titleLable.top = self.itemImageView.bottom + 4;
        
        self.priceLable.text = wallItem.desc;
        [self.priceLable sizeToFit];
        self.priceLable.width = self.width;
        self.priceLable.left = self.itemImageView.left+5;
        self.priceLable.top = self.titleLable.bottom + 5;
        
    }else {
        self.bkgView.backgroundColor = [UIColor clearColor];
        self.wallItem = nil;
        
        self.itemImageView.image = nil;
        self.itemImageView.hidden = YES;
        
        self.titleLable.text = @"";
        self.titleLable.hidden = YES;
        
        self.priceLable.text = @"";
        self.titleLable.hidden = YES;
    }
}

#pragma mark - Getters And Setters

- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width +60)];
        view.backgroundColor = Color_White;
        view.layer.cornerRadius = 3;
        view.layer.masksToBounds = YES;
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

- (UILabel *)titleLable {
    
    if ( !_titleLable ) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLable.textColor = Color_Gray(100);
        _titleLable.font = FONT(12);
    }
    
    return _titleLable;
    
}

- (UILabel *)priceLable {
    
    if ( !_priceLable ) {
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _priceLable.textColor = Theme_Color;
        _priceLable.font = BOLD_FONT(14);
    }
    
    return _priceLable;
    
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
