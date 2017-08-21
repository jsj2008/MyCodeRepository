//
//  MHModule18Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule18Cell.h"
#import "XMAppThemeHelper.h"
#import "MHModuleModel.h"
#import "MHSingleImageView.h"

#define PADDING 12

@interface MHModule18Cell ()

@property (nonatomic, strong) MHSingleImageView *coverView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation MHModule18Cell


- (void)reloadData{
    if (self.cellData) {
        self.backgroundColor = Color_White;
        [self cellAddSubview:self.coverView];
        [self cellAddSubview:self.titleLabel];
        [self cellAddSubview:self.priceLabel];
        
        MHModuleModel *model = self.cellData;
        self.coverView.height = (SCREEN_WIDTH - 12 * 2) / model.banner.ar;
        [self.coverView reloadData:@{@"link":model.banner.link,@"icon":model.banner.cover,@"placeholder":@"placeholder_w"}];
        
        self.titleLabel.text = model.banner.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.left = PADDING;
        self.titleLabel.top = self.coverView.bottom + 12;
        
        self.priceLabel.text = model.banner.desc;
        self.priceLabel.textColor = [XMAppThemeHelper defaultTheme].mainThemeColor;
        [self.priceLabel sizeToFit];
        self.priceLabel.left = PADDING;
        self.priceLabel.top = self.titleLabel.bottom + 4;
    }
}

+ (CGFloat)heightForCell:(id)cellData{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        
        height = (SCREEN_WIDTH - 2 * PADDING) / model.banner.ar + 80;
    }
    return height;
}

- (MHSingleImageView *)coverView{
    if (!_coverView) {
        MHSingleImageView *imageView = [[MHSingleImageView alloc] initWithFrame:CGRectMake(12, 12, SCREEN_WIDTH - 2 * PADDING, 0)];
        _coverView = imageView;
    }
    return _coverView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(20);
        label.textColor = Color_Gray42;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray42;
        _priceLabel = label;
    }
    return _priceLabel;
}

@end
