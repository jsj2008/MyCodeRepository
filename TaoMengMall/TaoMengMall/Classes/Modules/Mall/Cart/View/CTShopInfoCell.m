//
//  CTShopInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/2/17.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CTShopInfoCell.h"
#import "TTCheckButton.h"
#import "CTSkuInfoCell.h"
#import "CTShopInfoModel.h"

@interface CTShopInfoCell ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) TTCheckButton *checkButton;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UIButton *editButton;
//@property (nonatomic, strong) UILabel *discountInfoLabel;
//@property (nonatomic, strong) UIView *spotView;

@end

@implementation CTShopInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.lineView];
    [self addSubview:self.checkButton];
    [self addSubview:self.shopNameLabel];
    [self addSubview:self.editButton];
    
    self.userInteractionEnabled = YES;
    weakify(self);
    [self bk_whenTapped:^{
        strongify(self);
        if (self.cellData) {
            CTShopInfoModel *shopInfo = (CTShopInfoModel *)self.cellData;
            [[TTNavigationService sharedService] openUrl:shopInfo.link];
        }
    }];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        CTShopInfoModel *shopInfo = (CTShopInfoModel *)self.cellData;
        
        self.checkButton.selected = self.selected;
        
        self.shopNameLabel.text = shopInfo.shopName;
        [self.shopNameLabel sizeToFit];
        self.shopNameLabel.centerY = 23;
        self.shopNameLabel.left = 52;
        
//        self.discountInfoLabel.text = shopInfo.discountInfo.show;
//        [self.discountInfoLabel sizeToFit];
//        self.discountInfoLabel.top = self.shopNameLabel.bottom + 11;
//        self.discountInfoLabel.left = self.spotView.right + 4;
        
        self.editButton.hidden = self.xxEditing||IsEmptyString(shopInfo.shopId);
        self.checkButton.hidden = IsEmptyString(shopInfo.shopId);
        
        if (self.isShopEditing) {
            [self.editButton setTitle:@"完成" forState:UIControlStateNormal];
        }else{
            [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 46;
    }
    return 0;
}

#pragma mark - Getters And Setters

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _lineView.bottom = 46;
        _lineView.backgroundColor = Color_Gray238;
    }
    
    return _lineView;
}

- (TTCheckButton *)checkButton {
    
    if ( !_checkButton ) {
        _checkButton = [[TTCheckButton alloc] init];
        _checkButton.centerY = 23;
        _checkButton.left = 4;
        [_checkButton addTarget:self action:@selector(handleCheckButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _checkButton;
}

- (UILabel *)shopNameLabel {
    
    if ( !_shopNameLabel ) {
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shopNameLabel.textColor = Color_Gray66;
        _shopNameLabel.font = FONT(16);
        _shopNameLabel.numberOfLines = 1;
    }
    
    return _shopNameLabel;
}

- (UIButton*)editButton
{
    if (!_editButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 52, 52)];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        [button setTitleColor:Color_Gray(62) forState:UIControlStateNormal];
        button.right = SCREEN_WIDTH;
        button.centerY = 23;
        [button addTarget:self action:@selector(handleEditButton) forControlEvents:UIControlEventTouchUpInside];
        _editButton = button;
    }
    return _editButton;
}

//- (UILabel *)discountInfoLabel {
//    
//    if ( !_discountInfoLabel ) {
//        _discountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        _discountInfoLabel.textColor = Color_Gray66;
//        _discountInfoLabel.font = FONT(12);
//        _discountInfoLabel.numberOfLines = 1;
//    }
//    
//    return _discountInfoLabel;
//}
//
//- (UIView *)spotView {
//    
//    if ( !_spotView ) {
//        _spotView = [[UIView alloc] initWithFrame:CGRectMake(40, 48, 2, 2)];
//        _spotView.layer.masksToBounds = YES;
//        _spotView.layer.cornerRadius = 1;
//        _spotView.backgroundColor = Color_Red12;
//    }
//    
//    return _spotView;
//}

#pragma mark - Event Response

- (void)handleEditButton
{
    if ([self.delegate respondsToSelector:@selector(editTappedWithModel:)]) {
        [self.delegate editTappedWithModel:self.cellData];
    }
}

- (void) handleCheckButton {
    
    self.checkButton.selected = !self.checkButton.isSelected;
    
    CTShopInfoModel *shopInfo = (CTShopInfoModel *)self.cellData;
    
    NSDictionary *userInfo = @{@"type":@"shop", @"selected":self.checkButton.selected?@YES:@NO, @"id":shopInfo.shopId};
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_SELECT_CHANGE object:nil userInfo:userInfo];

}

@end
