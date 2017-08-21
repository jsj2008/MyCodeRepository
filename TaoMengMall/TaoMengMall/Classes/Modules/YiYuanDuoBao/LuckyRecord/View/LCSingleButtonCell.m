//
//  LCSingleButtonCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LCSingleButtonCell.h"

@interface LCSingleButtonCell ()

@property (nonatomic, strong) UIButton *singleButton;

@end

@implementation LCSingleButtonCell

- (void)drawCell{
    [self cellAddSubView:self.singleButton];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 52;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        [self.singleButton setTitle:@"修改" forState:UIControlStateNormal];
    }else{
        [self.singleButton setTitle:@"添加地址" forState:UIControlStateNormal];
    }
}

- (UIButton *)singleButton{
    if (!_singleButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = SCREEN_WIDTH;
        button.height = 52;
        button.left = button.right = 0;
        [button addTarget:self action:@selector(handleSingleButton) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = FONT(18);
        _singleButton = button;
    }
    return _singleButton;
}

- (void)setType:(LCSingleButtonCellStyle)type{
    if (type == LCSingleButtonCellStyleAlter) {
        self.singleButton.backgroundColor = Color_White;
        [self.singleButton setTitle:@"修改" forState:UIControlStateNormal];
        [self.singleButton setTitleColor:Color_Gray153 forState:UIControlStateNormal];
    }else if (type == LCSingleButtonCellStyleConfirm){
        self.singleButton.backgroundColor = RGB(249, 218, 109);
        [self.singleButton setTitle:@"确认" forState:UIControlStateNormal];
        [self.singleButton setTitleColor:Color_Gray42 forState:UIControlStateNormal];
    }
}

- (void)handleSingleButton{
    [[TTNavigationService sharedService] openUrl:@"xiaoma://consigneeSelect"];
}





@end
