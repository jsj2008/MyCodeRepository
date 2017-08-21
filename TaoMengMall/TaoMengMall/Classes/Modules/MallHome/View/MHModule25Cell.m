//
//  MHModule25Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/24.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule25Cell.h"
#import "MHModuleModel.h"

@interface MHModule25Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation MHModule25Cell

- (void)reloadData
{
    
    if (self.cellData) {
        
        
        [self cellAddSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.descLabel];
        
        MHModuleModel *model = self.cellData;
        
        self.titleLabel.text = model.header.title.text;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = 26;
        self.titleLabel.left = 12;
        
        self.descLabel.text = model.header.title.desc;
        [self.descLabel sizeToFit];
        self.descLabel.centerY = self.titleLabel.centerY;
        self.descLabel.left = self.titleLabel.right + 4;
        
    }
}

- (UIView *)bgView
{
    if (!_bgView ) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52)];
        view.backgroundColor = Color_White;
        _bgView = view;
    }
    return _bgView;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray100;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(14);
        label.textColor = Color_Gray204;
        label.userInteractionEnabled = YES;
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            MHModuleModel *model = self.cellData;
            MHHeaderModel *header = model.header;
            [[TTNavigationService sharedService] openUrl:header.more.link];
        }];
        _descLabel = label;
    }
    return _descLabel;
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 62;
        
    }
    return height;
}

@end

