//
//  ShopTopicItemCell.m
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopTopicItemCell.h"
#import "ShopItemContentModel.h"
#import "TTGalleryViewController.h"

#define IMAGE_WIDTH  (SCREEN_WIDTH-2*12-2*5)/3

@interface ShopTopicItemCell ()
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) UIView *line;
@end

@implementation ShopTopicItemCell

- (void)reloadData
{
    if (self.cellData) {
        ShopItemContentModel *wallItem = (ShopItemContentModel*)self.cellData;
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.line];
        
        self.titleLabel.text = wallItem.name;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.top = 10;
        self.titleLabel.left = 5;
        self.titleLabel.width = SCREEN_WIDTH-20;
        [self.titleLabel sizeToFit];
        
        int i = 0;
        for (; i < wallItem.images.count; i++) {
            UIImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.hidden = NO;
            imageView.height = IMAGE_WIDTH/wallItem.ar;
            [imageView setOnlineImage:[wallItem.images safeObjectAtIndex:i]];
        }
        for (; i < 3; i++) {
            UIImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.hidden = YES;
        }
        
        self.line.bottom = [[self class]heightForCell:self.cellData];
        
        self.priceLabel.text = wallItem.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.left = 5;
        self.priceLabel.width = SCREEN_WIDTH-60;
        self.priceLabel.bottom = self.line.bottom - 10;
        
        self.favButton.selected = wallItem.isFav;

        self.backgroundColor = Color_White;

    }else{
        [self removeAllSubviews];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        ShopItemContentModel *wallItem = (ShopItemContentModel*)cellData;
        CGFloat imageHeight = 10;
        if (wallItem.images.count > 0) {
            imageHeight = IMAGE_WIDTH/wallItem.ar;
        }
        return 100+imageHeight;
    }
    return 0;
}

- (NSMutableArray*)imageViews
{
    if (!_imageViews) {
        NSMutableArray *imageViews = [NSMutableArray arrayWithCapacity:3];
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5+(12+IMAGE_WIDTH)*i, 56, IMAGE_WIDTH, IMAGE_WIDTH)];
            imageView.tag = i;
            [imageViews addObject:imageView];
            [self cellAddSubview:imageView];
            
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
            [imageView addGestureRecognizer:tapGesturRecognizer];

        }
        
        _imageViews = imageViews;
    }
    return _imageViews;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        _line = view;
    }
    return _line;
}

#pragma mark - Event Response

- (void) tapImage:(UITapGestureRecognizer *) tapGestureRecognizer {
    
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    TTGalleryViewController *vc = [[TTGalleryViewController alloc] init];
    
    ShopItemContentModel *wallItem = (ShopItemContentModel*)self.cellData;
    
    NSArray *images = wallItem.images;
    
    vc.images = images;
    vc.index = tapGestureRecognizer.view.tag;
    
    [navigationController pushViewController:vc animated:YES];
    
}
@end
