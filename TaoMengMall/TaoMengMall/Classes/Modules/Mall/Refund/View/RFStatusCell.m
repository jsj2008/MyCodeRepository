//
//  RFStatusCell.m
//  Refound
//
//  Created by marco on 6/6/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RFStatusCell.h"
#import "RefundInfoModel.h"
#import "TTGalleryViewController.h"

//局部配色
#define BUYER_COLOR     RGB(239, 235, 236)
#define SELLER_COLOR    RGB(225, 225, 225)
#define IMAGE_WIDTH     (SCREEN_WIDTH - 60 -24 -2*5)/3

@interface RFStatusCell ()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UIView *spotView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timelabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSMutableArray *imageViews;
@end

@implementation RFStatusCell

- (void)drawCell
{
    [self cellAddSubView:self.bkgView];
    [self cellAddSubView:self.spotView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.timelabel];
    [self cellAddSubView:self.line];
    [self cellAddSubView:self.contentLabel];
    
    for (UIImageView *imageView  in self.imageViews) {
        [self cellAddSubView:imageView];
    }
}



- (void)reloadData
{
    if (self.cellData) {
        
        RefundInfoModel *model = (RefundInfoModel*)self.cellData;
        self.bkgView.height = [RFStatusCell heightForCell:model];

        //买家 or 卖家？
//        BOOL buyer = [model.type isEqualToString:@"1"];
//        if (buyer) {
//            self.bkgView.backgroundColor = BUYER_COLOR;
//        }else{
//            self.bkgView.backgroundColor = SELLER_COLOR;
//        }
        
        self.titleLabel.text = model.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = 25;
        self.titleLabel.left = 45;
        
        self.timelabel.text = model.time;
        [self.timelabel sizeToFit];
        self.timelabel.centerY = 25;
        self.timelabel.right = self.bkgView.right - 12;
        
        self.titleLabel.width = self.timelabel.left - 4 - 45;

        self.contentLabel.width = self.bkgView.width - 12*2;

        NSString *content = model.desc;
//        if (content.length == 0) {
//            content = model.title;
//        }
        self.contentLabel.text = content;
        self.contentLabel.height = [RFStatusCell heightForContentLabel:content];
        self.contentLabel.top = 54;
        self.contentLabel.left = self.bkgView.left + 12;
        
        self.images = model.images;
        int i = 0;
        for (; i < self.images.count; i++) {
            
            UIImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.hidden = NO;
            imageView.top = i / 3 * ( imageView.width + 5 ) + self.contentLabel.bottom + 5;
            NSString *imageSrc = [self.images safeObjectAtIndex:i];
            
            [imageView setOnlineImage:imageSrc];
        }
        
        for (; i < 3; i++) {
            UIImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.image = nil;
            imageView.hidden = YES;
        }
        
        self.line.bottom = [[self class]heightForCell:self.cellData];
    }
}



+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        RefundInfoModel *model = (RefundInfoModel*)cellData;
        NSString *content = model.desc;
        height = 52 + (content? [self heightForContentLabel:content]+2 : 0);
        NSInteger count = model.images.count;
        NSInteger row = ceilf(count / 3.f);
        height +=  (count == 0 ? 0 : (5 + IMAGE_WIDTH)*row);
        if (content||model.images.count) {
            height += 12;
        }
    }
    return height;
}

+ (CGFloat)heightForContentLabel:(NSString*)text
{
    if (!text) {
        return 0;
    }
    CGSize size = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 12*4, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: FONT(16)} context:nil].size;
    return size.height;
}

#pragma mark - Subviews

- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, LINE_WIDTH)];
        line.backgroundColor = Color_White;
        line.layer.cornerRadius = 2.f;
        line.layer.masksToBounds = YES;
        _bkgView = line;
    }
    return _bkgView;
}

- (UIView*)spotView
{
    if (!_spotView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(28, 0, 7, 7)];
        view.backgroundColor = Color_Gray216;
        view.layer.cornerRadius = 3.5;
        view.layer.masksToBounds = YES;
        view.centerY = 25;
        _spotView = view;
    }
    return _spotView;
}


- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.textColor = Color_Gray(59);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel*)timelabel
{
    if (!_timelabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray(178);
        _timelabel = label;
    }
    return _timelabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(28, 50, SCREEN_WIDTH-28-12, LINE_WIDTH)];
        line.backgroundColor = Color_Gray(229);
        _line = line;
    }
    return _line;
}

- (UILabel*)contentLabel
{
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.textColor = Color_Gray(148);
        label.numberOfLines = 0;
        _contentLabel = label;
    }
    return _contentLabel;
}

- (NSArray<UIImageView *> *)imageViews {
    
    if ( !_imageViews ) {
        
        _imageViews = [[NSMutableArray<UIImageView *> alloc] initWithCapacity:9];
        
        CGFloat imageWidth = (SCREEN_WIDTH - 60 -24 -2*5)/3;
        
        for ( int i = 0; i < 3; i++) {
            
            CGFloat imageX = i % 3 * ( imageWidth + 5 ) + 24;
            CGFloat imageY = i / 3 * ( imageWidth + 5 ) + self.contentLabel.bottom + 5;
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageWidth)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
            [imageView addGestureRecognizer:tapGesturRecognizer];
            
            [_imageViews addObject:imageView];
            
        }
        
    }
    
    return _imageViews;
}

#pragma mark - Event Response

- (void) tapImage:(UITapGestureRecognizer *) tapGestureRecognizer {
    
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    TTGalleryViewController *vc = [[TTGalleryViewController alloc] init];
    
    RefundInfoModel *model = (RefundInfoModel*)self.cellData;
    
    vc.images = model.images;
    vc.index = tapGestureRecognizer.view.tag;
    
    [navigationController pushViewController:vc animated:YES];
    
}
@end
