//
//  MHModule06Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule06Cell.h"
#import "MHModuleModel.h"
#import "MHSingleImageView.h"

#define PADDING 12
#define ICON_WIDTH 334

@interface MHModule06Cell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MHModule06Cell


- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        
        [self cellAddSubview:self.scrollView];
        [self cellAddSubview:self.titleLabel];
        [self cellAddSubview:self.descLabel];
        [self cellAddSubview:self.moreImageView];
        [self.scrollView removeAllSubviews];
        
        MHModuleModel *model = self.cellData;
        
        MHHeaderModel *header = model.header;
        self.titleLabel.text = header.title.text;
        [self.titleLabel sizeToFit];
        self.titleLabel.left = self.titleLabel.top = 12;
        
        self.moreImageView.centerY = self.titleLabel.centerY;
        
        self.descLabel.text = header.more.text;
        [self.descLabel sizeToFit];
        self.descLabel.centerY = self.titleLabel.centerY;
        self.descLabel.right = self.moreImageView.left - 4;
        
        self.scrollView.top = self.descLabel.bottom + 12;
        
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            self.scrollView.height = ICON_WIDTH / item.ar;
        }

        for (int i = 0; i<model.items.count; i++) {
            
            MHItemModel *item = [model.items safeObjectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";
            
            MHSingleImageView *imageView = [[MHSingleImageView alloc] initWithFrame:CGRectMake(PADDING+i * (PADDING + ICON_WIDTH), 0, ICON_WIDTH, ICON_WIDTH / item.ar)];
            
            [imageView reloadData:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_w"}];
            
            [self.scrollView addSubview:imageView];
            
        }
        self.scrollView.contentSize = CGSizeMake((ICON_WIDTH+PADDING) * model.items.count + PADDING, self.scrollView.height);
    }
}



+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            height = ICON_WIDTH / item.ar +  2 * PADDING + 32;
        }
    }
    return height;
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

- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
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

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.right = SCREEN_WIDTH - 15;
    }
    
    return _moreImageView;
}

- (UIScrollView*)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 196)];
        scrollView.backgroundColor = Color_White;
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}
@end
