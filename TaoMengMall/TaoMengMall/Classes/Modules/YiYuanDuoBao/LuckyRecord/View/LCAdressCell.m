//
//  LCAdressCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LCAdressCell.h"
#import "LuckyConfirmConsigneeModel.h"

@interface LCAdressCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *adreesLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation LCAdressCell

- (void)drawCell{
    self.backgroundColor = Color_White;
    
    [self cellAddSubView:self.nameLabel];
    [self cellAddSubView:self.phoneLabel];
    [self cellAddSubView:self.adreesLabel];
    [self cellAddSubView:self.line];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData ) {
        LuckyConfirmConsigneeModel *model = cellData;
        height = 56 + [model.address sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 24].height;
        //height = 80;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        LuckyConfirmConsigneeModel *model = self.cellData;
        
        self.nameLabel.text = model.uname;
        [self.nameLabel sizeToFit];
        self.nameLabel.left = self.nameLabel.top = 12;
        
        self.phoneLabel.text = model.phone;
        [self.phoneLabel sizeToFit];
        self.phoneLabel.centerY = self.nameLabel.centerY;
        self.phoneLabel.right = SCREEN_WIDTH - 12;
        
        self.adreesLabel.text = model.address;
        self.adreesLabel.left = self.nameLabel.left;
        self.adreesLabel.top = self.nameLabel.bottom + 12;
        self.adreesLabel.width = SCREEN_WIDTH - 24;
        self.adreesLabel.height = [self.adreesLabel.text sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 24].height;

        //[self.adreesLabel sizeToFit];

        
        self.line.bottom = [[self class] heightForCell:self.cellData];
    }
}


- (UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)adreesLabel{
    if (!_adreesLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        label.numberOfLines = 0;
        _adreesLabel = label;
    }
    return _adreesLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray42;
        label.font = FONT(14);
        _phoneLabel = label;

    }
    return _phoneLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        _line = view;
    }
    return _line;
}
@end
