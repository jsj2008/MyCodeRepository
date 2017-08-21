//
//  MHModule15Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule15Cell.h"
#import "XMAppThemeHelper.h"
#import "MHModuleModel.h"
#import "MHomeModule2View.h"

#define PADDING 12
#define ICON_WIDTH 115

@interface MHModule15Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) NSMutableArray *moduleViews;
@property (nonatomic, strong) NSMutableArray *modules;
@end

@implementation MHModule15Cell


- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        
        [self cellAddSubview:self.scrollView];
        [self cellAddSubview:self.lineView];
        [self cellAddSubview:self.titleLabel];
        [self cellAddSubview:self.descLabel];
        [self cellAddSubview:self.moreImageView];
        [self.scrollView removeAllSubviews];
        
        MHModuleModel *model = self.cellData;
        //model.header = nil;
        if (model.header) {
            self.titleLabel.text = model.header.title.text;
            [self.titleLabel sizeToFit];
            self.titleLabel.centerY = self.lineView.centerY;
            self.titleLabel.left = self.lineView.right + 12;
            
            self.lineView.backgroundColor = [UIColor colorWithHexString:model.header.bar.color];
            self.lineView.hidden = NO;
            
            self.moreImageView.centerY = self.titleLabel.centerY;
            self.moreImageView.hidden = NO;
            
            self.descLabel.text = model.header.more.text;
            [self.descLabel sizeToFit];
            self.descLabel.centerY = self.titleLabel.centerY;
            self.descLabel.right = self.moreImageView.left - 4;
            
            self.scrollView.top = 45 + 12;
        }else{
            self.titleLabel.text = @"";
            self.descLabel.text = @"";
            self.lineView.hidden = YES;
            self.moreImageView.hidden = YES;
            
            self.scrollView.top = 12;
        }
        
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            self.scrollView.height = ICON_WIDTH / item.ar + 30;
            
            _modules = [NSMutableArray array];
            for (int i = 0; i<model.items.count; i++) {
                MHItemModel *item = [model.items safeObjectAtIndex:i];
                NSString *link = @"";
                if (item.link) {
                    link = item.link;
                }
                [self.modules addObject:@{@"title":item.title,@"icon":item.image,@"link":link,@"iconWidth":@(ICON_WIDTH),@"iconHeight":@(ICON_WIDTH / item.ar),@"placeholder":@"placeholder_h"}];
                
                CGFloat height = ICON_WIDTH / item.ar + 30;
                
                MHomeModule2View *moduleView = [[MHomeModule2View alloc]initWithFrame:CGRectMake((ICON_WIDTH + PADDING) * i + PADDING, 0, ICON_WIDTH, height)];
                moduleView.font = FONT(16);
                [moduleView reloadData:[self.modules safeObjectAtIndex:i]];
                [self.scrollView addSubview:moduleView];
            }
            self.scrollView.contentSize = CGSizeMake((ICON_WIDTH + PADDING) * model.items.count + PADDING, self.scrollView.height);
            self.scrollView.hidden = NO;
        }else{
            self.scrollView.hidden = YES;
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        //model.header = nil;
        if (model.header) {
            height += 45;
        }
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            height += ICON_WIDTH / item.ar + 30 + PADDING;
        }
        height += PADDING;
    }
    return height;
}

#pragma mark - Subviews
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(20);
        label.textColor = Color_Gray100;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 18, 2, 15)];
        view.backgroundColor = RGB(255, 216, 86);
        _lineView = view;
    }
    return _lineView;
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
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,30 + 12, SCREEN_WIDTH, 196)];
        scrollView.backgroundColor = Color_White;
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}
@end
