//
//  MHMidule07Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule07Cell.h"
#import "MHModuleModel.h"
#import "MHSingleImageView.h"

#define PADDING 12
#define ICON_WIDTH 334

@interface MHModule07Cell ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MHModule07Cell


- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        
        [self cellAddSubview:self.scrollView];
        [self.scrollView removeAllSubviews];
        
        MHModuleModel *model = self.cellData;
        
        self.scrollView.top =  12;
        
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            self.scrollView.height = ICON_WIDTH / item.ar;
        }

        for (int i = 0; i<model.items.count; i++) {
            
            MHItemModel *item = [model.items safeObjectAtIndex:i];
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";
            
            
            MHSingleImageView *imageView = [[MHSingleImageView alloc] initWithFrame:CGRectMake(PADDING + i * (PADDING + ICON_WIDTH), 0, ICON_WIDTH, ICON_WIDTH / item.ar)];
            
            [imageView reloadData:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_w"}];
            
            [self.scrollView addSubview:imageView];
           
        }
        
        self.scrollView.contentSize = CGSizeMake((ICON_WIDTH + PADDING) * model.items.count+PADDING, self.scrollView.height);
    }
}



+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        if (item) {
            height = ICON_WIDTH / item.ar +  2 * PADDING;
        }
        
    }
    return height;
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
