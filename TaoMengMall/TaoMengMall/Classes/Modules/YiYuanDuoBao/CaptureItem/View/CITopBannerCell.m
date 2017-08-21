//
//  CPTopBannerCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CITopBannerCell.h"
#import "CIPayResultModel.h"

@interface CITopBannerCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation CITopBannerCell

- (void)drawCell{
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.line];
    self.backgroundColor = Color_White;
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 30;
    }
    return height;
}

- (void)reloadData{
    
    if (self.cellData) {
        CIPayResultModel *model = self.cellData;
        NSString *npTimesStr = [NSString stringWithFormat:@"成功参与%@件商品，共%@人次",model.itemCount, model.times];
        NSMutableAttributedString *nattributedStr = [[NSMutableAttributedString alloc] initWithString:npTimesStr];
        [nattributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(4, model.itemCount.length)];
        [nattributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(4 + model.itemCount.length + 5, model.times.length)];
        self.titleLabel.attributedText = nattributedStr;
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 8;
        self.titleLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
    }
    
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(16);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        view.bottom = 30;
        _line = view;
    }
    return _line;
}

@end
