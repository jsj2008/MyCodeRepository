//
//  RFImagesCell.m
//  YouCai
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "RFImagesCell.h"
#import "RFImageView.h"
#import "RefundApplyModel.h"

#define IMAGE_WIDTH ((SCREEN_WIDTH - 12*3 - 15*2)/4)

@interface RFImagesCell ()
@property (nonatomic, strong) UIImageView *dashBkgView;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UILabel *limitLabel;

@property (nonatomic, strong) NSMutableArray<RFImageView *> *imageViews;
@end

@implementation RFImagesCell

- (void)drawCell
{
    [self addSubview:self.dashBkgView];
    [self.dashBkgView addSubview:self.addImageView];
    [self.dashBkgView addSubview:self.limitLabel];
    
    self.limitLabel.right = self.dashBkgView.width - 6;
    self.limitLabel.centerY = 23;
    
    for (RFImageView *image in self.imageViews) {
        [self.dashBkgView addSubview:image];
    }
}

- (void)reloadData
{
    if (self.cellData) {
        
        RefundApplyModel *model = (RefundApplyModel*)self.cellData;

        if (model.imageObjs.count == 0) {
            self.limitLabel.hidden = NO;
        }else{
            self.limitLabel.hidden = YES;
        }

        
        int i = 0;
        for (; i < model.imageObjs.count; i++) {
            
            RFImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.hidden = NO;
            NSDictionary *imageDict = [model.imageObjs safeObjectAtIndex:i];
            UIImage *image = [imageDict objectForKey:@"imageData"];
            imageView.image = image;
        }
        
        for (; i < 3; i++) {
            RFImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.image = nil;
            imageView.hidden = YES;
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 48;
    }
    return height;
}

#pragma mark - Subviews
- (UIImageView *)dashBkgView
{
    if (!_dashBkgView) {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, 48)];
        view.image = [UIImage imageNamed:@"refund_dash_rectangle"];
        view.userInteractionEnabled = YES;
        _dashBkgView = view;
    }
    return _dashBkgView;
}

- (NSArray<RFImageView *> *)imageViews {
    
    if ( !_imageViews ) {
        
        _imageViews = [[NSMutableArray<RFImageView *> alloc] initWithCapacity:3];
        
        CGFloat imageWidth = 32;
        
        for ( int i = 0; i < 3; i++) {
            
            CGFloat imageX = i * ( imageWidth + 16 ) + SCREEN_WIDTH - 160;
            
            RFImageView *imageView = [[RFImageView alloc] initWithFrame:CGRectMake(imageX, 8, 32, 32)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
            [imageView addGestureRecognizer:tapGesturRecognizer];
            [_imageViews addObject:imageView];
        }
    }
    
    return _imageViews;
}

- (UIImageView *)addImageView {
    
    if ( !_addImageView ) {
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 28, 20)];
        _addImageView.image = [UIImage imageNamed:@"refund_add_image"];
        _addImageView.userInteractionEnabled = YES;
        weakify(self);
        [_addImageView bk_whenTapped:^{
            strongify(self);
            RefundApplyModel *model = (RefundApplyModel*)self.cellData;
            if (model.imageObjs.count == 3) {
                return ;
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(addImageTapped:)]) {
                [self.delegate addImageTapped:self];
            }
        }];
    }
    
    return _addImageView;
}

- (UILabel*)limitLabel
{
    if (!_limitLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray(163);
        label.text = @"上传图片 最多3张";
        [label  sizeToFit];
        _limitLabel = label;
    }
    return _limitLabel;
}

- (void)tapImage:(UITapGestureRecognizer*)gesture
{
    if ([self.delegate respondsToSelector:@selector(deleteImageTappedWithIndex:)]) {
        [self.delegate deleteImageTappedWithIndex:gesture.view.tag];
    }
}
@end
