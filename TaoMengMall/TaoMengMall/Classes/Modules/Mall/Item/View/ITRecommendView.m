//
//  ITRecommendView.m
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ITRecommendView.h"

@interface ITRecommendView ()

@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *priceLable;

@property (nonatomic, strong) ITRecommendModel *wallItem;
@end

@implementation ITRecommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        [self addSubview:self.bkgView];

        [self.bkgView addSubview:self.itemImageView];
        [self.bkgView addSubview:self.titleLable];
        [self.bkgView addSubview:self.priceLable];

        self.userInteractionEnabled = YES;
        
        self.layer.cornerRadius = 3.;
        self.layer.masksToBounds = YES;
        
        weakify(self);
        [self bk_whenTapped:^{
            strongify(self);
            [self handleTap];
        }];
    }
    
    return self;
}

- (void)reloadData:(ITRecommendModel *)wallItem
{
    if (wallItem) {
        self.itemImageView.hidden = NO;
        self.titleLable.hidden = NO;
        self.priceLable.hidden = NO;
        
        self.wallItem = wallItem;
        
        self.bkgView.height = self.width / wallItem.ar + 60;
        
        [self.itemImageView setOnlineImage:wallItem.image placeHolderImage:[UIImage imageNamed:@"placeholder_h"]];
        self.itemImageView.height = self.width / wallItem.ar;
        
        
        self.titleLable.text = wallItem.title;
        [self.titleLable sizeToFit];
        self.titleLable.width = self.bkgView.width-10;
        self.titleLable.left = self.itemImageView.left+5;
        self.titleLable.top = self.itemImageView.bottom + 4;
        
        self.priceLable.text = wallItem.price;
        [self.priceLable sizeToFit];
        self.priceLable.width = self.width-10;
        self.priceLable.left = self.itemImageView.left+5;
        self.priceLable.top = self.titleLable.bottom + 2;
        
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
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        view.backgroundColor = Color_White;
        _bkgView = view;
    }
    return _bkgView;
}

- (UIImageView *)itemImageView {
    
    if ( !_itemImageView ) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bkgView.width , self.bkgView.width)];
    }
    
    return _itemImageView;
}

- (UILabel *)titleLable {
    
    if ( !_titleLable ) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 0, 0)];
        _titleLable.textColor = Color_Gray(45);
        _titleLable.font = FONT(14);
    }
    
    return _titleLable;
    
}

- (UILabel *)priceLable {
    
    if ( !_priceLable ) {
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 0, 0)];
        _priceLable.textColor = Color_Gray(45);
        _priceLable.font = BOLD_FONT(16);
    }
    
    return _priceLable;
    
}

#pragma mark - Event Response

- (void)handleTap {
    
    if ( self.wallItem ) {
        [[TTNavigationService sharedService] openUrl:self.wallItem.link];
    }
    
}
@end
