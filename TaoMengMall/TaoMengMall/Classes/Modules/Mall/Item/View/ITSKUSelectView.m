//
//  skuSelectView.m
//  HongBao
//
//  Created by Ivan on 16/2/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITSKUSelectView.h"
#import "TTAmountView.h"
#import "ITStockInfoModel.h"
#import "ITPropertyModel.h"
#import "ITPropertyKVModel.h"
#import "ITPropertyButton.h"
#import "ITPhotoBrowserView.h"
//#import "TTSliderView.h"
//#import "ITZoomingScrollView.h"

#define CONTAINER_HEIGHT (SCREEN_HEIGHT*3/4. - 20)//365

#define PADDING                  10
#define SKU_INFO_LEFT            120

NSString * const kNOTIFY_SKU_PANEL_SELECT_CHANGED = @"kNOTIFY_SKU_PANEL_SELECT_CHANGED";

@interface ITSKUSelectView () <TTAmountDelegate,ITPhotoBrowserViewDelegate>

@property (nonatomic, strong) ITSkuInfoModel *skuInfo;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, assign) NSInteger selectedMainSkuIndex;

@property (nonatomic, strong) NSMutableArray *selectedButtons;

@property (nonatomic, strong) NSMutableArray *propertyButtons;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *skuImageView;
@property (nonatomic, strong) UILabel *skuTitleLabel;//废弃
@property (nonatomic, strong) UILabel *skuPriceLabel;
//@property (nonatomic, strong) UILabel *skuInfoLabel;

@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UILabel *selectedValueLabel;
@property (nonatomic, strong) UILabel *unselectedLabel;
@property (nonatomic, strong) UILabel *unselectedValueLabel;

@property (nonatomic, strong) UILabel *skuStockLabel;//新增

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIView *lineView1;

@property (nonatomic, strong) UIScrollView *propertyView;

@property (nonatomic, strong) UIView *lineView2;

@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) TTAmountView *amountView;

@property (nonatomic, strong) UIView *lineView3;

@property (nonatomic, strong) UIView *okBackgroundView;
@property (nonatomic, strong) UIButton *okButton;

//@property (nonatomic, strong) TTSliderView *sliderView;
@property (nonatomic, strong) ITPhotoBrowserView *browserView;
@property (nonatomic, strong) UILabel *skuIndexLabel;
@property (nonatomic, strong) UILabel *skuNameLabel;

@end


@implementation ITSKUSelectView

@dynamic selectedProperties,amount;

- (ITSKUSelectView *) initWithSkuInfo: (ITSkuInfoModel *)skuInfo itemTitle:(NSString *)itemTitle {
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.skuInfo = skuInfo;
        self.itemTitle = itemTitle;
        
        //确保没有选中SKU的时候,显示封面
        self.selectedMainSkuIndex = -1;
        self.photos = [NSMutableArray array];
        ITPhoto *photo;
        for (ITSkuCoverModel *cover in skuInfo.covers) {
            photo = [[ITPhoto alloc]initWithURL:[NSURL URLWithString:cover.cover]];
            photo.caption = cover.name;
            [self.photos addSafeObject:photo];
        }
        
        self.selectedButtons = [NSMutableArray array];
        
        self.propertyButtons = [NSMutableArray arrayWithCapacity:skuInfo.properties.count];
        
        for (int i = 0; i < skuInfo.properties.count; i++) {
            
            [self.propertyButtons addSafeObject:[NSMutableDictionary dictionary]];
            
        }
        
        [self render];
    }
    return self;
    
}

#pragma mark - Private Methods

- (void) render {
    
    self.userInteractionEnabled = YES;
    
    [self addSubview:self.maskView];
    [self addSubview:self.browserView];
    [self addSubview:self.containerView];
    [self addSubview:self.skuIndexLabel];
    [self addSubview:self.skuNameLabel];
    
    [self.browserView reloadData];
    
    ITDefaultSkuInfoModel *defaultStockInfo = self.skuInfo.defaultInfo;
    ITSkuCoverModel *defaultSkuCover = [self.skuInfo.covers safeObjectAtIndex:0];
    
    //占位图、修复clipsToBounds,修复contentMode
    weakify(self);
    [self.skuImageView setOnlineImage:defaultSkuCover.cover placeHolderImage:[UIImage imageNamed:@"sku_cover_placeholder"] complete:^(UIImage *image) {
        strongify(self);
        self.skuImageView.clipsToBounds = NO;
        self.skuImageView.contentMode = UIViewContentModeScaleToFill;
    }];
    
    self.skuPriceLabel.text = defaultStockInfo.price;
    [self.skuPriceLabel sizeToFit];
    
    self.skuStockLabel.text = [NSString stringWithFormat:@"(库存：%ld件)",defaultStockInfo.quantity];
    [self.skuStockLabel sizeToFit];
    
    self.lineView1.top = self.skuImageView.bottom + 16;
    
    self.propertyView.top = self.lineView1.bottom;
    self.propertyView.height = CONTAINER_HEIGHT - self.propertyView.top - self.okBackgroundView.height;
    
    self.amountView.maxAmount = defaultStockInfo.quantity;
    self.amountView.minAmount = 1;
    
    self.lineView3.bottom = self.okBackgroundView.top;
    
}

- (void) refreshSKUInfo {
    
    // TODO 未选全的情况
    
    if ( self.selectedButtons.count == self.propertyButtons.count ) {
        
        NSMutableArray *propertyKs = [NSMutableArray arrayWithCapacity:self.selectedButtons.count];
    
        NSMutableArray *propertyVs = [NSMutableArray arrayWithCapacity:self.selectedButtons.count];
    
        for (int i = 0; i < self.selectedButtons.count; i++) {
            [propertyKs addSafeObject:@0];
            [propertyVs addSafeObject:@""];
        }
        
        for (ITPropertyButton *selectedButton in self.selectedButtons) {
            [propertyKs replaceObjectAtIndex:selectedButton.tag withObject:selectedButton.propertyKV.k];
            [propertyVs replaceObjectAtIndex:selectedButton.tag withObject:selectedButton.propertyKV.v];
        }
    
        NSString *skuKey = [propertyKs componentsJoinedByString:@"-"];
        
        ITStockInfoModel *stockInfo = [self.skuInfo.stockInfo objectForKey:skuKey];
        
        //FIX single property by marco 20170516
        self.selectedMainSkuIndex  = -1;
        ITPropertyButton *propertyButton = [self.selectedButtons safeObjectAtIndex:0];
        //main property
        if (propertyButton.tag == 0) {
            ITPropertyKVModel *property = propertyButton.propertyKV;
            ITPropertyModel *mainProperty = [self.skuInfo.properties safeObjectAtIndex:0];
            NSInteger index = [mainProperty.propertyValueList indexOfObject:property];
            if (index != NSNotFound) {
                self.selectedMainSkuIndex = index;
            }
        }
        
        weakify(self);
        [self.skuImageView setOnlineImage:stockInfo.image placeHolderImage:[UIImage imageNamed:@"sku_cover_placeholder"] complete:^(UIImage *image) {
            strongify(self);
            self.skuImageView.clipsToBounds = NO;
            self.skuImageView.contentMode = UIViewContentModeScaleToFill;

        }];
        
        self.skuPriceLabel.text = stockInfo.price;
        [self.skuPriceLabel sizeToFit];
    
        self.skuStockLabel.text = [NSString stringWithFormat:@"(库存：%ld件)",stockInfo.quantity];
        [self.skuStockLabel sizeToFit];
        
        //self.skuInfoLabel.text = [propertyVs componentsJoinedByString:@" "];
        [self refreshSkuSelection];
    
        self.amountView.maxAmount = stockInfo.quantity;
    
    } else {
        
        ITDefaultSkuInfoModel *defaultStockInfo = self.skuInfo.defaultInfo;
        ITSkuCoverModel *skuCover = [self.skuInfo.covers safeObjectAtIndex:0];
        self.selectedMainSkuIndex  = -1;
        
        if (self.selectedButtons.count != 0) {
            ITPropertyButton *propertyButton = [self.selectedButtons safeObjectAtIndex:0];
            //main property
            if (propertyButton.tag == 0) {
                ITPropertyKVModel *property = propertyButton.propertyKV;
                ITPropertyModel *mainProperty = [self.skuInfo.properties safeObjectAtIndex:0];
                NSInteger index = [mainProperty.propertyValueList indexOfObject:property];
                if (index != NSNotFound) {
                    self.selectedMainSkuIndex = index;
                    skuCover = [self.skuInfo.covers safeObjectAtIndex:index+1];
                }
            }
        }
        
        weakify(self);
        [self.skuImageView setOnlineImage:skuCover.cover placeHolderImage:[UIImage imageNamed:@"sku_cover_placeholder"] complete:^(UIImage *image) {
            strongify(self);
            self.skuImageView.clipsToBounds = NO;
            self.skuImageView.contentMode = UIViewContentModeScaleToFill;
            //self.skuImageView.frame = CGRectMake(14, -46, 96, 144);
        }];
        
        self.skuPriceLabel.text = defaultStockInfo.price;
        [self.skuPriceLabel sizeToFit];
        
        self.skuStockLabel.text = [NSString stringWithFormat:@"(库存：%ld件)",defaultStockInfo.quantity];
        [self.skuStockLabel sizeToFit];

        [self refreshSkuSelection];
        self.amountView.maxAmount = defaultStockInfo.quantity;
    }
}

- (void) refreshPropertyButtons {
    
    NSMutableDictionary * propertyButtonKeys = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < self.propertyButtons.count; i++) {
        
        [propertyButtonKeys setObject:@NO forKey:[NSString stringWithFormat:@"%d", i]];
        
    }

    for (int i = 0; i < self.selectedButtons.count; i++) {
        
        ITPropertyButton *selectedButton = self.selectedButtons[i];
        
        if ( [self.propertyButtons safeObjectAtIndex:selectedButton.tag] ) {
            
            [propertyButtonKeys setObject:@YES forKey:[NSString stringWithFormat:@"%ld", (long)selectedButton.tag]];
            
            for (NSString *key in self.propertyButtons[selectedButton.tag]) {
                
                ITPropertyButton *propertyButton = [self.propertyButtons[selectedButton.tag] objectForKey:key];
                
                if ( propertyButton == selectedButton ) {
                    propertyButton.selected = YES;
                } else {
                    propertyButton.selected = NO;
                }
            }
        }
    }
    
    for (NSString *key in propertyButtonKeys) {
        
        BOOL isProcessed = [[propertyButtonKeys objectForKey:key] boolValue];
        
        if ( !isProcessed ) {
            
            if ( [self.propertyButtons safeObjectAtIndex:[key integerValue]] ) {
                
                for (NSString *propertyKey in self.propertyButtons[[key integerValue]]) {
                    
                    ITPropertyButton *propertyButton = [self.propertyButtons[[key integerValue]] objectForKey:propertyKey];
                    
                    propertyButton.selected = NO;
                    
                }
            }
            
        }
        
    }
    
    // 暂时只做一层和两层属性做关联disable;
    
    if ( self.propertyButtons.count == 1 ) {
        
        for ( NSString *key in [self.propertyButtons safeObjectAtIndex:0] ) {
            
            ITPropertyButton *propertyButton = [self.propertyButtons[0] objectForKey:key];
            
            ITStockInfoModel *stockInfo = [self.skuInfo.stockInfo objectForKey:propertyButton.propertyKV.k];
            
            if ( stockInfo.quantity > 0 ) {
                propertyButton.enabled = YES;
            } else {
                propertyButton.enabled = NO;
            }
            
        }
        
    } else if ( self.propertyButtons.count == 2 ) {
        
        for ( NSString *key in [self.propertyButtons safeObjectAtIndex:0] ) {
            
            ITPropertyButton *propertyButton = [self.propertyButtons[0] objectForKey:key];
            
            if ( propertyButton.selected ) {
                
                for ( NSString *inKey in [self.propertyButtons safeObjectAtIndex:1] ) {
                    
                    ITPropertyButton *inPropertyButton = [self.propertyButtons[1] objectForKey:inKey];
                    
                    ITStockInfoModel *stockInfo = [self.skuInfo.stockInfo objectForKey:[NSString stringWithFormat:@"%@-%@", key, inKey]];
                    
                    if ( stockInfo.quantity > 0 ) {
                        inPropertyButton.enabled = YES;
                    } else {
                        inPropertyButton.enabled = NO;
                    }
                    
                }
                
            }
            
        }
        
        for ( NSString *key in [self.propertyButtons safeObjectAtIndex:1] ) {
            
            ITPropertyButton *propertyButton = [self.propertyButtons[1] objectForKey:key];
            
            if ( propertyButton.selected ) {
                
                for ( NSString *inKey in [self.propertyButtons safeObjectAtIndex:0] ) {
                    
                    ITPropertyButton *inPropertyButton = [self.propertyButtons[0] objectForKey:inKey];
                    
                    ITStockInfoModel *stockInfo = [self.skuInfo.stockInfo objectForKey:[NSString stringWithFormat:@"%@-%@", inKey, key]];
                    
                    if ( stockInfo.quantity > 0 ) {
                        inPropertyButton.enabled = YES;
                    } else {
                        inPropertyButton.enabled = NO;
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

#pragma mark - Custom Methods

- (void)show
{
    [self refreshSKUInfo];
    [self refreshPropertyButtons];
    
    [[ApplicationEntrance shareEntrance].window addSubview:self];
    
    weakify(self);
    
//    [UIView animateWithDuration:0.3 animations:^{
//        strongify(self);
//        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT - CONTAINER_HEIGHT, SCREEN_WIDTH, CONTAINER_HEIGHT);
//    }];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        strongify(self);
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT - CONTAINER_HEIGHT, SCREEN_WIDTH, CONTAINER_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(willHideSKUSelectView)]) {
        [self.delegate willHideSKUSelectView];
    }

    weakify(self);
    
    [UIView animateWithDuration:0.4 animations:^{
        
        strongify(self);
        
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT+50, SCREEN_WIDTH, 0);
        
    } completion:^(BOOL finished) {
        
        strongify(self);
        [self removeFromSuperview];
        
    }];
}

- (void)setSelectedProperties:(NSArray *)selectedProperties
{
    [self.selectedButtons removeAllObjects];
    for (NSDictionary *buttonDict in self.propertyButtons) {
        for (ITPropertyKVModel *key in selectedProperties) {
            for (ITPropertyButton *button in [buttonDict allValues]) {
                button.selected = NO;
                if ([button.propertyKV.k isEqualToString:key.k]) {
                    [self handlePropertyButton:button];
                }
            }
        }
    }
}

- (NSArray*)selectedProperties
{
    NSMutableArray *properties = [NSMutableArray array];
    for (ITPropertyButton *button in self.selectedButtons) {
        [properties addSafeObject:button.propertyKV];
    }
    return properties;
}

- (void)setAmount:(NSInteger)amount
{
    self.amountView.amount = amount;
}

- (NSInteger)amount
{
    return self.amountView.amount;
}

#pragma mark - Getters And Setters

- (UIView *)maskView {
    
    if ( !_maskView ) {
        _maskView = [[UIView alloc] initWithFrame:self.frame];
        _maskView.backgroundColor = RGBA(0, 0, 0, 0.5);
        _maskView.userInteractionEnabled = YES;
        
        weakify(self);
        [_maskView bk_whenTapped:^{
            strongify(self);
            [self dismiss];
        }];
    }
    
    return _maskView;
}

- (UIView *)containerView {
    
    if ( !_containerView ) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT+50, SCREEN_WIDTH, CONTAINER_HEIGHT)];
        _containerView.backgroundColor = Color_White;
        _containerView.userInteractionEnabled = YES;

        [_containerView addSubview:self.skuImageView];
        //[_containerView addSubview:self.skuTitleLabel];
        [_containerView addSubview:self.skuPriceLabel];
        [_containerView addSubview:self.skuStockLabel];
        
        //[_containerView addSubview:self.skuInfoLabel];
        [_containerView addSubview:self.selectedLabel];
        [_containerView addSubview:self.selectedValueLabel];
        [_containerView addSubview:self.unselectedLabel];
        [_containerView addSubview:self.unselectedValueLabel];
        
        [_containerView addSubview:self.closeButton];
        [_containerView addSubview:self.lineView1];
        [_containerView addSubview:self.propertyView];
        //[_containerView addSubview:self.lineView2];
        //[_containerView addSubview:self.amountLabel];
        //[_containerView addSubview:self.amountView];
        [_containerView addSubview:self.lineView3];
        [_containerView addSubview:self.okBackgroundView];
        [_containerView addSubview:self.okButton];
        
    }
    
    return _containerView;
}

- (UIImageView *)skuImageView {
    
    if ( !_skuImageView ) {
        _skuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, -32, 90, 135)];
        _skuImageView.contentMode = UIViewContentModeScaleToFill;
        _skuImageView.userInteractionEnabled = YES;
        _skuImageView.layer.shadowOffset = CGSizeMake(0,-2);
        _skuImageView.layer.shadowOpacity = 0.4;
        _skuImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _skuImageView.layer.shadowRadius = 2;
        _skuImageView.clipsToBounds = NO;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapSkuCover:)];
        [_skuImageView addGestureRecognizer:gesture];
    }
    
    return _skuImageView;
}

- (UILabel *)skuTitleLabel {
    
    if ( !_skuTitleLabel ) {
        _skuTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 8, 0, 0)];
        _skuTitleLabel.textColor = Color_Gray66;
        _skuTitleLabel.font = FONT(12);
        _skuTitleLabel.text = self.itemTitle;
        [_skuTitleLabel sizeToFit];
        _skuTitleLabel.width = SCREEN_WIDTH - 94 - 40;
    }
    
    return _skuTitleLabel;
}

- (UILabel *)skuPriceLabel {
    
    if ( !_skuPriceLabel ) {
        _skuPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SKU_INFO_LEFT, 8, 0, 0)];
        _skuPriceLabel.textColor =Theme_Color;
        _skuPriceLabel.font = FONT(22);
        _skuPriceLabel.numberOfLines = 1;
    }
    
    return _skuPriceLabel;
}

- (UILabel*)skuStockLabel
{
    if (!_skuStockLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SKU_INFO_LEFT, 40, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray(62);
        _skuStockLabel = label;
    }
    return _skuStockLabel;
}


//- (UILabel *)skuInfoLabel {
//    
//    if ( !_skuInfoLabel ) {
//        _skuInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 62, 0, 0)];
//        _skuInfoLabel.textColor = Color_Gray153;
//        _skuInfoLabel.font = FONT(12);
//        _skuInfoLabel.numberOfLines = 1;
//        _skuInfoLabel.text = @"请选择";
//        [_skuInfoLabel sizeToFit];
//        _skuInfoLabel.width = SCREEN_WIDTH - 94 - 40;
//    }
//    
//    return _skuInfoLabel;
//}

- (UILabel *)selectedLabel
{
    if (!_selectedLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SKU_INFO_LEFT, 62, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray(178);
        _selectedLabel = label;
    }
    return _selectedLabel;
}

- (UILabel *)selectedValueLabel
{
    if (!_selectedValueLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SKU_INFO_LEFT, 62, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Black;
        _selectedValueLabel = label;
    }
    return _selectedValueLabel;
}

- (UILabel *)unselectedLabel
{
    if (!_unselectedLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SKU_INFO_LEFT, 62, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray(62);
        _unselectedLabel = label;
    }
    return _unselectedLabel;
}

- (UILabel *)unselectedValueLabel
{
    if (!_unselectedValueLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SKU_INFO_LEFT, 62, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray(62);
        _unselectedValueLabel = label;
    }
    return _unselectedValueLabel;
}

- (UIButton *)closeButton {
    
    if ( !_closeButton ) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(0, 10, 32, 34);
        [_closeButton addTarget:self action:@selector(handleCloseButton) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setImage:[UIImage imageNamed:@"icon_cancel"] forState:UIControlStateNormal];
        _closeButton.right = SCREEN_WIDTH - 14;
    }
    
    return _closeButton;
}

- (UIView *)lineView1 {
    
    if ( !_lineView1 ) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _lineView1.backgroundColor = Color_Gray230;
    }
    
    return _lineView1;
}

- (UIScrollView *)propertyView {
    
    if ( !_propertyView ) {
        _propertyView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145)];
        
        int propertyIndex = 0;
        int maxHeight = 0;
        int maxWidth = 5;
        CGFloat buttonHeight = 0;
        
        for (ITPropertyModel *property in self.skuInfo.properties) {
            
            UILabel *propertyNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, maxHeight + 10, 0, 0)];
            propertyNameLabel.textColor = Color_Gray(178);
            propertyNameLabel.font = FONT(12);
            propertyNameLabel.text = [NSString stringWithFormat:@"%@",property.propertyName];
            [propertyNameLabel sizeToFit];
            propertyNameLabel.tag = propertyIndex;
            
            [_propertyView addSubview:propertyNameLabel];
            
            maxHeight += 10 + propertyNameLabel.height;
            
            for (ITPropertyKVModel *propertyKV in property.propertyValueList) {
                
                ITPropertyButton *propertyButton = [ITPropertyButton buttonWithPropertyKV:propertyKV];
                propertyButton.tag = propertyIndex;
                
                [((NSMutableDictionary *)self.propertyButtons[propertyIndex]) setSafeObject:propertyButton forKey:propertyKV.k];
                
                if ( 0 == buttonHeight ) {
                    buttonHeight = propertyButton.height;
                }
                
                if ( maxWidth + 9 + propertyButton.width > SCREEN_WIDTH - 14) {
                    maxHeight += buttonHeight + 5;
                    maxWidth = 5;
                }
                
                propertyButton.top = maxHeight + 9;
                propertyButton.left = maxWidth + 9;
                
                maxWidth += propertyButton.width + 9;
                
                [propertyButton addTarget:self action:@selector(handlePropertyButton:) forControlEvents:UIControlEventTouchUpInside];
                
                [_propertyView addSubview:propertyButton];
                
            }
            
            maxHeight += buttonHeight + 9 + 16;
            if (propertyIndex + 2 <= self.skuInfo.properties.count) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(14, maxHeight, SCREEN_WIDTH -14, LINE_WIDTH)];
                line.backgroundColor = Color_Gray230;
                [_propertyView addSubview:line];
            }
            
            maxWidth = 5;
            //maxHeight += 9 + buttonHeight;
            maxHeight += 6;
            propertyIndex++;
        }
        
        self.lineView2.top = maxHeight;
        self.amountLabel.top = self.lineView2.bottom + 16;
        self.amountView.top = self.amountLabel.bottom + 10;
        
        [_propertyView addSubview:self.lineView2];
        [_propertyView addSubview:self.amountLabel];
        [_propertyView addSubview:self.amountView];
        
        maxHeight = self.amountView.bottom;
        _propertyView.contentSize = CGSizeMake(SCREEN_WIDTH, maxHeight + 10);
    }
    
    return _propertyView;
    
}

- (UIView *)lineView2 {
    
    if ( !_lineView2 ) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH - 14 * 2, LINE_WIDTH)];
        _lineView2.backgroundColor = Color_Gray230;
    }
    
    return _lineView2;
}

- (UILabel *)amountLabel {
    
    if ( !_amountLabel ) {
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 0, 0)];
        _amountLabel.textColor = Color_Gray(178);
        _amountLabel.font = FONT(12);
        _amountLabel.text = @"数量";
        [_amountLabel sizeToFit];
    }
    
    return _amountLabel;
}

- (TTAmountView *)amountView {
    
    if ( !_amountView ) {
        _amountView = [[TTAmountView alloc] initWithFrame:CGRectMake(15, 0, SKU_INFO_LEFT, 28)];
        _amountView.buttonWidth = 32;
    }
    
    return _amountView;
}

- (UIView *)lineView3 {
    
    if ( !_lineView3 ) {
        _lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _lineView3.backgroundColor = Color_Gray209;
    }
    
    return _lineView3;
}

- (UIView *)okBackgroundView {
    
    if ( !_okBackgroundView ) {
        _okBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, CONTAINER_HEIGHT - 50, SCREEN_WIDTH, 50)];
        _okBackgroundView.backgroundColor = Theme_Color;
    }
    
    return _okBackgroundView;
}

- (UIButton *)okButton {
    
    if ( !_okButton ) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        _okButton.titleLabel.font = FONT(18);
        [_okButton addTarget:self action:@selector(handleOKButton) forControlEvents:UIControlEventTouchUpInside];
        [_okButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        
        _okButton.layer.masksToBounds = YES;
        _okButton.layer.cornerRadius = 2.0f;
       
        _okButton.bottom = CONTAINER_HEIGHT;
    }
    
    return _okButton;
}

//- (TTSliderView *)sliderView {
//    
//    if ( !_sliderView ) {
//        _sliderView = [[TTSliderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:SliderViewPageControlStyleDot alignment:SliderViewPageControlAlignmentCenter];
//        _sliderView.delegate  = self;
//        _sliderView.dataSource = self;
//        _sliderView.autoScroll = NO;
//        _sliderView.wrapEnabled = NO;
//        _sliderView.currentPageColor = Color_Red12;
//        _sliderView.hidden = YES;
//    }
//    
//    return _sliderView;
//}

- (ITPhotoBrowserView*)browserView
{
    if (!_browserView) {
        _browserView = [[ITPhotoBrowserView alloc]initWithDelegate:self];
        _browserView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _browserView.zoomPhotosToFill = NO;
        _browserView.alpha = 0;
        _browserView.hideCaption = YES;
        [_browserView setCurrentPhotoIndex:0];

    }
    return _browserView;
}

- (UILabel*)skuIndexLabel
{
    if (!_skuIndexLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 20)];
        label.font = FONT(12);
        label.backgroundColor = RGBA(0, 0, 0, 0.4);
        label.textColor = Color_White;
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 0;
        _skuIndexLabel = label;
    }
    return _skuIndexLabel;
}

- (UILabel*)skuNameLabel
{
    if (!_skuNameLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 30)];
        label.font = FONT(16);
        label.backgroundColor = RGBA(0, 0, 0, 0.4);
        label.textColor = Color_White;
        label.layer.cornerRadius = 15;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 0;
        _skuNameLabel = label;
    }
    return _skuNameLabel;
}


#pragma mark - Event Response

- (void) handleCloseButton {
 
    [self dismiss];
}

- (void) handleOKButton {
    
    
    if ( self.selectedButtons.count == self.propertyButtons.count ) {
        
        NSMutableArray *propertyKs = [NSMutableArray arrayWithCapacity:self.selectedButtons.count];
        
//        NSMutableArray *propertyVs = [NSMutableArray arrayWithCapacity:self.selectedButtons.count];
        
        for (int i = 0; i < self.selectedButtons.count; i++) {
            [propertyKs addSafeObject:@0];
//            [propertyVs addSafeObject:@""];
        }
        
        for (ITPropertyButton *selectedButton in self.selectedButtons) {
            [propertyKs replaceObjectAtIndex:selectedButton.tag withObject:selectedButton.propertyKV.k];
//            [propertyVs replaceObjectAtIndex:selectedButton.tag withObject:selectedButton.propertyKV.v];
            
        }
        
        NSString *skuKey = [propertyKs componentsJoinedByString:@"-"];
        
        ITStockInfoModel *stockInfo = [self.skuInfo.stockInfo objectForKey:skuKey];
        
        if ( [self.delegate respondsToSelector:@selector(addWithSkuId:amount:type:)]) {
            [self.delegate addWithSkuId:stockInfo.skuId amount:self.amountView.amount type:self.type];
        }else if ([self.delegate respondsToSelector:@selector(addWithSkuInfo:amount:type:)]) {
            [self.delegate addWithSkuInfo:stockInfo amount:self.amountView.amount type:self.type];
        }
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择商品规格" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alertView show];
    }
    
}

- (void) handlePropertyButton:(id)sender {
    
    ITPropertyButton *propertyButton = (ITPropertyButton *)sender;
    
    if ( !propertyButton.enabled ) {
        return;
    }
    
    for (int i = 0; i < self.selectedButtons.count; i++) {
        
        ITPropertyButton *selectedButton = self.selectedButtons[i];
        
        if ( selectedButton.tag == propertyButton.tag ) {
            if ( propertyButton.isSelected ) {
                [self.selectedButtons removeObjectAtIndex:i];
//                propertyButton.selected = NO;
            } else {
                [self.selectedButtons replaceObjectAtIndex:i withObject:propertyButton];
            }
            
            [self refreshSKUInfo];
            [self refreshPropertyButtons];
            return;
        }
    }
    
    [self.selectedButtons addSafeObject:propertyButton];
    [self refreshSKUInfo];
    [self refreshPropertyButtons];
    DBG(@"%@", propertyButton.propertyKV);
}

- (void)refreshSkuSelection
{
    NSMutableArray *skus = [NSMutableArray array];
    NSString *propertyName = @"";
    NSString *propertyValue = @"";
    for (int i = 0; i < self.skuInfo.properties.count; i++) {
        ITPropertyModel *property = [self.skuInfo.properties safeObjectAtIndex:i];
        ITPropertyButton *propertyButton = nil;
        for (ITPropertyButton *selectedButton in self.selectedButtons) {
            if (selectedButton.tag == i) {
                propertyButton = selectedButton;
            }
        }
        propertyName = property.propertyName?property.propertyName:@"";
        propertyValue =  propertyButton.propertyKV.v?propertyButton.propertyKV.v:@"";
        [skus addObject:@{propertyName:propertyValue}];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_SKU_PANEL_SELECT_CHANGED object:skus];
    
    NSMutableArray *selectedSkus = [NSMutableArray array];
    NSMutableArray *unselectedSkus = [NSMutableArray array];
    for (NSDictionary *dict in skus) {
        NSString *key = [[dict allKeys] safeObjectAtIndex:0];
        NSString *value = [dict objectForKey:key];
        if (IsEmptyString(value)) {
            [unselectedSkus addObject:dict];
        }else{
            [selectedSkus addObject:dict];
        }
    }
    
    NSString *selectedSkuKey = @"";
    for (NSDictionary *dict in selectedSkus) {
        NSString *key = [[dict allKeys] safeObjectAtIndex:0];
        NSString *value = [dict objectForKey:key];
        selectedSkuKey = [selectedSkuKey stringByAppendingFormat:@" \"%@\"",value];
    }
    self.selectedValueLabel.text = selectedSkuKey;
    [self.selectedValueLabel sizeToFit];
    
    NSString *unselectedSkuName = @"";
    for (NSDictionary *dict in unselectedSkus) {
        NSString *key = [[dict allKeys] safeObjectAtIndex:0];
        unselectedSkuName = [unselectedSkuName stringByAppendingFormat:@" %@",key];
    }
    self.unselectedValueLabel.text = unselectedSkuName;
    [self.unselectedValueLabel sizeToFit];
    
    if (unselectedSkus.count == skus.count) {
        self.unselectedLabel.text = @"请选择";
        [self.unselectedLabel sizeToFit];
        
        self.selectedLabel.text = @"";
        
        self.unselectedLabel.left = SKU_INFO_LEFT;
        self.unselectedValueLabel.left = self.unselectedLabel.right + 4;
        
    }else if (selectedSkus.count == skus.count) {
        self.selectedLabel.text = @"已选择";
        [self.selectedLabel sizeToFit];
        
        self.unselectedLabel.text = @"";
        
        self.selectedLabel.left = SKU_INFO_LEFT;
        self.selectedValueLabel.left = self.selectedLabel.right + 4;
        
    }else{
        self.selectedLabel.text = @"已选择";
        [self.selectedLabel sizeToFit];
        
        self.unselectedLabel.text = @"请选择";
        [self.unselectedLabel sizeToFit];
        
        self.selectedLabel.left = SKU_INFO_LEFT;
        
        self.selectedValueLabel.text = [NSString stringWithFormat:@"%@，",selectedSkuKey];
        [self.selectedValueLabel sizeToFit];
        self.selectedValueLabel.left = self.selectedLabel.right + 4;
        
        self.unselectedLabel.left = self.selectedValueLabel.right - 4;
        self.unselectedValueLabel.left = self.unselectedLabel.right + 4;
    }
}

- (void)handleTapSkuCover:(UITapGestureRecognizer*)gesture
{
    [self.browserView reloadData];
    //当前选择的主sku index比对应封面小1
    [self.browserView setCurrentPhotoIndex:self.selectedMainSkuIndex+1];
    
    self.maskView.backgroundColor = Color_Black;
    self.containerView.hidden = YES;

    [UIView animateWithDuration:0.4 animations:^{
        
        self.browserView.alpha = 1;

    } completion:^(BOOL finished) {
        self.skuIndexLabel.alpha = 1;
        self.skuNameLabel.alpha = 1;
    }];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(ITPhotoBrowserView *)photoBrowser {
    return _photos.count;
}

- (id <ITPhoto>)photoBrowser:(ITPhotoBrowserView *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//- (id <ITPhoto>)photoBrowser:(ITPhotoBrowserView *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//        return [_thumbs objectAtIndex:index];
//    return nil;
//}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
    self.skuIndexLabel.text = [NSString stringWithFormat:@"%lu/%lu",index+1,self.skuInfo.covers.count];
    [self.skuIndexLabel sizeToFit];
    self.skuIndexLabel.width += 22;
    self.skuIndexLabel.height += 4;
    self.skuIndexLabel.layer.cornerRadius = self.skuIndexLabel.height/2;
    self.skuIndexLabel.right = SCREEN_WIDTH - 24;
    self.skuIndexLabel.bottom = SCREEN_HEIGHT - 12;
    
    ITSkuCoverModel *cover = [self.skuInfo.covers safeObjectAtIndex:index];
    self.skuNameLabel.text = cover.name;
    [self.skuNameLabel sizeToFit];
    self.skuNameLabel.width += 30;
    self.skuNameLabel.height += 4;
    self.skuNameLabel.layer.cornerRadius = self.skuNameLabel.height/2;
    if (self.skuNameLabel.width > 2*(self.skuIndexLabel.left-10) - SCREEN_WIDTH) {
        self.skuNameLabel.width = 2*(self.skuIndexLabel.left-10) - SCREEN_WIDTH;
    }
    self.skuNameLabel.centerX = SCREEN_WIDTH/2;
    self.skuNameLabel.bottom = SCREEN_HEIGHT - 12;
}

- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser didSingleTapPhotoAtIndex:(NSUInteger)index
{
    self.maskView.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    self.containerView.hidden = NO;
    self.skuIndexLabel.alpha = 0;
    self.skuNameLabel.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.browserView.alpha = 0;
        
    } completion:^(BOOL finished) {
    }];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

#pragma mark - TTAmountDelegate
- (void)increaseButtonDidTap {
    
}

- (void)decreaseButtonDidTap {

}

//重写hitTest方法，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        
        CGPoint subPoint = [self convertPoint:point toView:self.containerView];
        if (CGRectContainsPoint(self.skuImageView.frame, subPoint)) {
            return self.skuImageView;
        }
        
        UIView *view = [super hitTest:point withEvent:event];
        if (view) {
            return view;
        }else {
            for (UIView *subView in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [self convertPoint:point toView:subView];
                view = [subView hitTest:subPoint withEvent:event];
                if (view) {
                    return view;
                }
            }
        }
    }
    return nil;
}
@end
