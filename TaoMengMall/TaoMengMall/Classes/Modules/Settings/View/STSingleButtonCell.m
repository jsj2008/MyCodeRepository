//
//  MISingleButtonCell.m
//  HongBao
//
//  Created by Ivan on 16/3/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "STSingleButtonCell.h"
#import "UserService.h"

@interface STSingleButtonCell ()

@property (nonatomic, strong) UIButton *singleButton;

@end

@implementation STSingleButtonCell

- (void)drawCell
{
    [self addSubview:self.singleButton];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    return 61;
}

#pragma mark - Getters And Setters

- (UIButton *)singleButton {
    
    if ( !_singleButton ) {
        _singleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _singleButton.frame = CGRectMake(0, 17, SCREEN_WIDTH - 0 * 2, 44);
        [_singleButton setTitle:@"退出账号" forState:UIControlStateNormal];
        [_singleButton setTitleColor:Color_Black forState:UIControlStateNormal];
        _singleButton.titleLabel.font = FONT(16);
        _singleButton.backgroundColor = Color_White;
        [_singleButton addTarget:self action:@selector(handleSingleButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _singleButton;
}

#pragma mark - Event Response

- (void) handleSingleButton {
    
    [[UserService sharedService] logout];
    
}

@end
