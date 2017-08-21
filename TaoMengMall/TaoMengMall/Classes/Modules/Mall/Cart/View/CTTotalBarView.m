//
//  CTTotalBarView.m
//  HongBao
//
//  Created by Ivan on 16/2/17.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CTTotalBarView.h"
#import "CTSkuInfoCell.h"
#import "TTCheckButton.h"

@interface CTTotalBarView ()

@property (nonatomic, strong) TTCheckButton *checkButton;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *saveLabel;
@property (nonatomic, strong) UIButton *okButton;

@end

@implementation CTTotalBarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = Color_White;
        
        [self addSubview:self.checkButton];
        [self addSubview:self.allLabel];
        //[self addSubview:self.totalPriceLabel];
        [self addSubview:self.priceLabel];
        //[self addSubview:self.saveLabel];
        [self addSubview:self.okButton];
        
        self.checkButton.centerY = self.height / 2;
        
        self.okButton.centerY = self.height / 2;
        
        self.allLabel.centerY = self.height / 2;
        self.allLabel.left = self.checkButton.right + 5;
        
        //self.totalPriceLabel.top = 17;
        //self.totalPriceLabel.left = self.allLabel.right + 7;
        
        [self reloadData:@{}];
        
    }
    
    return self;
}

- (void)reloadData:(NSDictionary *)totalData {
    
    NSString *totalPrice = @"";
    
    if ( [totalData objectForKey:@"totalPrice"] ) {
        
        totalPrice = [totalData objectForKey:@"totalPrice"];
        
    } else {
        
        totalPrice = @"￥0.00";
        
    }
    
    NSString *savePrice = @"";
    
//    if ( [totalData objectForKey:@"savePrice"] ) {
//        
//        savePrice = [totalData objectForKey:@"savePrice"];
//        
//    } else {
//        
//        savePrice = @"￥0.00";
//        
//    }
    
    NSString *skuCount = @"";
    
    if ( [totalData objectForKey:@"skuCount"] ) {
        
        skuCount = [NSString stringWithFormat:@"(%@)", [totalData objectForKey:@"skuCount"]];
        
    } else {
        
        skuCount = @"";
        
    }
    
    self.priceLabel.text = totalPrice;
    [self.priceLabel sizeToFit];
    self.priceLabel.right = self.okButton.left - 12;
    self.priceLabel.centerY = self.height/2;
    //self.priceLabel.left = self.totalPriceLabel.right;
    //self.priceLabel.top = self.totalPriceLabel.top - 2;
    
//    self.saveLabel.text = [NSString stringWithFormat:@"为您节省%@", savePrice];
//    [self.saveLabel sizeToFit];
//    self.saveLabel.left = self.totalPriceLabel.left;
//    self.saveLabel.top = self.priceLabel.bottom;
    
    self.allLabel.text = [NSString stringWithFormat:@"全选%@",skuCount];
    [self.allLabel sizeToFit];
    
    //[self.okButton setTitle:[NSString stringWithFormat:@"去结算%@",skuCount] forState:UIControlStateNormal];
    //[self.okButton sizeToFit];
    //self.okButton.right = SCREEN_WIDTH - 12;
    
    
}

#pragma mark - Getters And Setters
- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.checkButton.selected = _selected;
}

- (void)setXxEditing:(BOOL)xxEditing
{
    _xxEditing = xxEditing;
    if (xxEditing) {
        self.priceLabel.hidden = YES;
        [self.okButton setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        self.priceLabel.hidden = NO;
        [self.okButton setTitle:@"结算" forState:UIControlStateNormal];
    }
}

- (TTCheckButton *)checkButton {
    
    if ( !_checkButton ) {
        _checkButton = [[TTCheckButton alloc] init];
        
        _checkButton.left = 13;
        [_checkButton addTarget:self action:@selector(handleCheckButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _checkButton;
}

- (UILabel *)allLabel {
    
    if ( !_allLabel ) {
        _allLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _allLabel.textColor = Color_Gray66;
        _allLabel.font = FONT(16);
        _allLabel.text = @"全选";
        _allLabel.numberOfLines = 1;
        [_allLabel sizeToFit];
    }
    
    return _allLabel;
}

- (UILabel *)totalPriceLabel {
    
    if ( !_totalPriceLabel ) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _totalPriceLabel.textColor = Color_Gray66;
        _totalPriceLabel.font = FONT(13);
        _totalPriceLabel.text = @"总价：";
        _totalPriceLabel.numberOfLines = 1;
        [_totalPriceLabel sizeToFit];
    }
    
    return _totalPriceLabel;
}

- (UILabel *)priceLabel {
    
    if ( !_priceLabel ) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _priceLabel.textColor = Color_Black;
        _priceLabel.font = FONT(16);
        _priceLabel.numberOfLines = 1;
    }
    
    return _priceLabel;
}

- (UILabel *)saveLabel {
    
    if ( !_saveLabel ) {
        _saveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _saveLabel.textColor = Color_Gray153;
        _saveLabel.font = FONT(10);
        _saveLabel.numberOfLines = 1;
    }
    
    return _saveLabel;
}

- (UIButton *)okButton {
    
    if ( !_okButton ) {
        _okButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 96, 38)];
        _okButton.titleLabel.font = FONT(16);
        _okButton.backgroundColor = Theme_Color;
        [_okButton addTarget:self action:@selector(handleOKButton) forControlEvents:UIControlEventTouchUpInside];
        [_okButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_okButton setTitle:@"结算" forState:UIControlStateNormal];
        //_okButton.contentEdgeInsets = UIEdgeInsetsMake(8.f, 8.f, 8.f, 8.f);
//        _okButton.layer.borderColor = Color_Gray(44).CGColor;
//        _okButton.layer.borderWidth = 1.;
        _okButton.height = 37;
        _okButton.right = SCREEN_WIDTH - 12;
        _okButton.layer.masksToBounds = YES;
        _okButton.layer.cornerRadius = 2.0f;
    }
    
    return _okButton;
}

#pragma mark - Event Response

- (void)handleCheckButton {
    
    self.checkButton.selected = !self.checkButton.selected;
    
    NSDictionary *userInfo = @{@"type":@"all", @"selected":self.checkButton.selected?@YES:@NO};
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_SELECT_CHANGE object:nil userInfo:userInfo];
    
}

- (void)handleOKButton {
    
    if ( [self.delegate respondsToSelector:@selector(okButtonDidClick)]) {
        [self.delegate okButtonDidClick];
    }

}

@end
