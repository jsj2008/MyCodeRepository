//
//  CommentCell.m
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CommentCell.h"

#import "CommentFeedModel.h"

#import "TTGalleryViewController.h"

@interface CommentCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *skuLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageViews;

@end

@implementation CommentCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.lineView];
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.skuLabel];
    for (UIImageView *imageView  in self.imageViews) {
        [self addSubview:imageView];
    }
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        CommentFeedModel *commentFeed = (CommentFeedModel *)self.cellData;
        //commentFeed.content = @"是多少积分打发时间附加费是开发商开发商开发开放开发开发商开发开放开放开发开放开发开放开发反馈方法方法付付付付付付付付付付付付付付付付付付付付付付付付付付付";
        [self.avatarImageView setOnlineImage:commentFeed.avatar placeHolderImage:[UIImage imageNamed:@"mine_default_avatar"]];
        
        self.nameLabel.text = commentFeed.name;
        [self.nameLabel sizeToFit];
        self.nameLabel.left = self.avatarImageView.right + 10;
        self.nameLabel.centerY = self.avatarImageView.centerY;
        
        self.contentLabel.text = commentFeed.content;
        self.contentLabel.width = SCREEN_WIDTH - 14 * 2;
        [self.contentLabel sizeToFit];
        
        self.timeLabel.text = commentFeed.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.top = self.contentLabel.bottom + 5;
        self.timeLabel.left = 14;
        
        self.skuLabel.text = commentFeed.skuDesc;
        [self.skuLabel sizeToFit];
        self.skuLabel.top = self.timeLabel.top;
        self.skuLabel.left = self.timeLabel.right + 5;
        
        NSArray<NSString *> *images = commentFeed.images;
        int i = 0;
        for (; i < images.count; i++) {
            
            UIImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.hidden = NO;
            imageView.top = i / 3 * ( imageView.width + 2 ) + self.timeLabel.bottom + 5;
            NSString *imageSrc = [images safeObjectAtIndex:i];
            [imageView setOnlineImage:imageSrc];
            
        }
        
        for (; i < 6; i++) {
            UIImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.image = nil;
            imageView.hidden = YES;
        }
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    CGFloat cellHeight = 0;
    
    if ( cellData ) {
        
        CommentFeedModel *commentFeed = (CommentFeedModel *)cellData;
        
        NSString *text = commentFeed.content;
        
        CGFloat textHeight = 0;
        if (!IsEmptyString(text)) {
            textHeight = [text sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 14 * 2].height;
        }
        
        cellHeight = 92 + ceil(textHeight) + 16;//5是底部margin，74是除了图片以及图片上方margin
        
        NSArray<NSString *> *images = commentFeed.images;
        if ( images.count > 0 ) {
            CGFloat imageHeight = (SCREEN_WIDTH - 60 -24 -2*2)/3;
            cellHeight += 5 + imageHeight + ( images.count - 1 ) / 3 * (imageHeight + 2 );
        }

    }
    
    return cellHeight;
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15 - 12, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
    }
    
    return _lineView;
}

- (UIImageView *)avatarImageView {
    
    if ( !_avatarImageView ) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 12, 20, 46, 46)];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 23;
    }
    
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    
    if ( !_nameLabel ) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _nameLabel.textColor = Color_Gray(45);
        _nameLabel.font = FONT(16);
    }
    
    return _nameLabel;
}

- (UILabel *)contentLabel {
    
    if ( !_contentLabel ) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 72, SCREEN_WIDTH - 14 * 2, 0)];
        _contentLabel.textColor = Color_Gray(90);
        _contentLabel.font = FONT(14);
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}

- (UILabel *)timeLabel {
    
    if ( !_timeLabel ) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _timeLabel.textColor = Color_Gray(174);
        _timeLabel.font = FONT(14);
    }
    
    return _timeLabel;
}

- (UILabel *)skuLabel {
    
    if ( !_skuLabel ) {
        _skuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _skuLabel.textColor = Color_Gray(174);
        _skuLabel.font = FONT(14);
    }
    
    return _skuLabel;
}

- (NSArray<UIImageView *> *)imageViews {
    
    if ( !_imageViews ) {
        
        _imageViews = [[NSMutableArray<UIImageView *> alloc] initWithCapacity:6];
        
        CGFloat imageWidth = (SCREEN_WIDTH - 60 -24 -2*2)/3;
        
        for ( int i = 0; i < 6; i++) {
            
            CGFloat imageX = i % 3 * ( imageWidth + 2 ) + 12;
            CGFloat imageY = i / 3 * ( imageWidth + 2 );
            
            
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
    
    CommentFeedModel *commentFeed = (CommentFeedModel *)self.cellData;

    NSArray *images = commentFeed.images;

    vc.images = images;
    vc.index = tapGestureRecognizer.view.tag;
    
    [navigationController pushViewController:vc animated:YES];
    
}

@end
