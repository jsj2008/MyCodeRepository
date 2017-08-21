//
//  BabyItemCell.m
//  BabyDaily
//
//  Created by bingo on 16/8/24.
//  Copyright © 2016年 marco. All rights reserved.
//

#import "LuckDrawHomeItemCell.h"
#import "LuckDrawHomeItemModel.h"
#import "M13LiteProgressView.h"

@interface LuckDrawHomeItemCell ()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleDescLabel;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *progressValueLabel;
@property (nonatomic, strong) M13LiteProgressView *progress;

@end

@implementation LuckDrawHomeItemCell

- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;

        LuckDrawHomeItemModel *model = self.cellData;
        
        [self cellAddSubview:self.itemImageView];
        [self cellAddSubview:self.buyButton];
        [self cellAddSubview:self.titleDescLabel];
        [self cellAddSubview:self.progress];
        [self cellAddSubview:self.progressLabel];
        [self cellAddSubview:self.progressValueLabel];
        [self cellAddSubview:self.buyButton];
        
        
        [self.itemImageView setOnlineImage:model.cover];
        
        self.titleDescLabel.text = model.title;
        self.titleDescLabel.width = CELL_WIDTH - 16;
        self.titleDescLabel.height = [model.title sizeWithUIFont:FONT(16) forWidth:CELL_WIDTH - 16].height;
        self.titleDescLabel.top = self.itemImageView.bottom + 12;
        self.titleDescLabel.left = 8;
        
        self.progress.progress = model.progress / 100.f;
        self.progressLabel.left = 8;
        self.progressLabel.top = self.titleDescLabel.bottom + 12;
        
        self.progressValueLabel.text = [NSString stringWithFormat:@"%g%%",model.progress ];
        [self.progressValueLabel sizeToFit];
        self.progressValueLabel.left = self.progressLabel.right + 4;
        self.progressValueLabel.centerY = self.progressLabel.centerY;
        
        self.progress.top = self.progressLabel.bottom + 8;
        
        self.buyButton.bottom = self.progress.bottom;
        self.buyButton.right = CELL_WIDTH - 10;
        
        if (model.showBuy) {
            self.buyButton.hidden = NO;
            self.progress.width = CELL_WIDTH / 2.0f;
        }else{
            self.buyButton.hidden = YES;
            self.progress.width = CELL_WIDTH - 16;
        }
       
    }
}

+ (CGFloat)titleHeight:(NSString*)title
{
    CGFloat contentH = [title  boundingRectWithSize:CGSizeMake(CELL_WIDTH - 16, FONT(16).lineHeight*3) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: FONT(16)} context:nil].size.height;
    return contentH;
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        
        LuckDrawHomeItemModel *wallItem = (LuckDrawHomeItemModel *)cellData;
        
        CGFloat height = CELL_WIDTH ;
        
        CGFloat textHeight = [self titleHeight:wallItem.title];
        
        height += 60 + textHeight;
        
        return height;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)itemImageView {
    
    if ( !_itemImageView ) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 8, 8, CELL_WIDTH - 16, CELL_WIDTH - 16)];
    }
    
    return _itemImageView;
}

- (UILabel *)titleDescLabel{
    if (!_titleDescLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, CELL_WIDTH - 4, 25)];
        label.font = FONT(16);
        label.textColor = Color_Gray42;
        label.numberOfLines = 0;
        _titleDescLabel = label;
    }
    return _titleDescLabel;
}


-(UILabel *)progressLabel{
    if (!_progressLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(12);
        label.textColor = Color_Gray125;
        label.text = @"当前进度：";
        [label sizeToFit];
        _progressLabel = label;
    }
    return _progressLabel;
}

- (UILabel *)progressValueLabel{
    if (!_progressValueLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(12);
        label.textColor = RGB(61, 133, 227);
        _progressValueLabel = label;
    }
    return _progressValueLabel;
}

- (M13LiteProgressView *)progress{
    if (!_progress) {
        M13LiteProgressView *progress = [[M13LiteProgressView alloc] initWithFrame:CGRectMake(8, 0, CELL_WIDTH / 2.0f, 6)];
        progress.progressTintColor = RGB(249, 218, 109);
        progress.trackTintColor = Color_Gray238;
        _progress = progress;
    }
    return _progress;
}

- (UIButton *)buyButton{
    if (!_buyButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 24)];
        [button setTitle:@"立即购买" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        [button setTitleColor:RGB(234, 72, 79) forState:UIControlStateNormal];
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        button.layer.borderColor = RGB(234, 72, 79).CGColor;
        button.userInteractionEnabled = NO;
        _buyButton = button;
    }
    return _buyButton;
}

@end
