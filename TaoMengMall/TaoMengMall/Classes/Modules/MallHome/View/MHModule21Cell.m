//
//  MHModule03Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule21Cell.h"
#import "MHModuleModel.h"
#import "MHSingleImageView.h"

#define PADDING 12
#define ITEM_WIDTH  (SCREEN_WIDTH - PADDING) / 2.0f -PADDING


@interface MHModule21Cell ()
//@property (nonatomic, strong) NSMutableArray *moduleViews;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MHModule21Cell



- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        
        [self removeAllSubviews];
        
        [self cellAddSubview:self.titleLabel];
        
        MHModuleModel *model = self.cellData;
        
        self.titleLabel.text = model.header.title.text;
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 12;
        self.titleLabel.top = 12;
        
        MHItemModel *first = [model.items safeObjectAtIndex:0];
        CGFloat width = (SCREEN_WIDTH - PADDING) / 2.0f -PADDING;
        CGFloat height = width / first.ar;
        int row,column = 0;

        for (int i = 0; i<model.items.count; i++) {
            row = i/2;
            column = i%2;

            MHItemModel *item = [model.items safeObjectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";

            MHSingleImageView *module = [[MHSingleImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
            module.left = PADDING + (width+PADDING)*column;
            module.top = 12 + (12+height)*row + 30;
            [module reloadData:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_w"}];
            [self cellAddSubview:module];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        int row = (int)model.items.count/2;
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            CGFloat width = (SCREEN_WIDTH - PADDING) / 2.0f -PADDING;
            height = 12 + (12 +width / item.ar)* row + 30;
        }
        
    }
    return height;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 210;
        _line = view;
    }
    return _line;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray42;
        _titleLabel = label;
    }
    return _titleLabel;
}
@end
