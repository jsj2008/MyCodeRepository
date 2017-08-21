//
//  CategoryHeaderCell.m
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CategoryHeaderCell.h"
#import "CategoryModel.h"

#define PADDING 10

@interface CategoryHeaderCell ()

@property (nonatomic, strong) UIView *wrapView;

@end

@implementation CategoryHeaderCell

- (void)reloadData
{
    if ( self.cellData ) {
        
        NSArray<CategoryModel> *categories = (NSArray<CategoryModel> *)self.cellData;
        
        [self cellAddSubview:self.wrapView];
        [self.wrapView removeAllSubviews];
        
        self.wrapView.height = [CategoryHeaderCell heightForCell:categories];
        
        CGFloat offsetY = 0;
        CGFloat offsetX = 0;
        CGFloat width = [CategoryHeaderCell widthForIcon];
        CGFloat height = width + 20;
        int index = 0;
        
        for (CategoryModel *category in categories) {
            
            UIView *iconView = [self buildIconView:category];
        
            if( 0 == index ) {
                offsetY = PADDING;
                offsetX = PADDING;
            } else if ( 0 == index % 4 && 0 != index ) {
                offsetX = PADDING;
                offsetY += height + PADDING;
            } else {
                offsetX += width + PADDING;
            }
            
            iconView.top = offsetY;
            iconView.left = offsetX;
            
            iconView.userInteractionEnabled = YES;
            weakify(category);
            [iconView bk_whenTapped:^{
                strongify(category);
                DBG(@"%@", category.name);
                [[TTNavigationService sharedService] openUrl:category.link];
            }];
            
            [self.wrapView addSubview:iconView];
            
            index++;
        }
        
    }
    
}

+ (CGFloat)widthForIcon {
    
    return ( SCREEN_WIDTH - PADDING * 5 ) / 4;
    
}

+ (CGFloat)heightForCell:(id)cellData
{
    if ( cellData ) {
        
        NSArray<CategoryModel> *categories = (NSArray<CategoryModel> *)cellData;
        
        CGFloat height = [CategoryHeaderCell widthForIcon];
        
        return ( height + 20 + 10 ) * ceilf(categories.count / 4.f) + 10;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIView *)wrapView {
    
    if ( !_wrapView ) {
        _wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    
    return _wrapView;
}

#pragma mark - Private Methods

- (UIView *)buildIconView:(CategoryModel *)category {
    
    CGFloat width = [CategoryHeaderCell widthForIcon];
    
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width + 20)];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, width, width)];
    [iconImageView setOnlineImage:category.imageSrc];
    [iconView addSubview:iconImageView];
    
    UILabel *iconNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    iconNameLabel.textColor = Color_Gray66;
    iconNameLabel.font = FONT(12);
    iconNameLabel.text = category.name;
    iconNameLabel.textAlignment = NSTextAlignmentCenter;
    [iconNameLabel sizeToFit];
    iconNameLabel.width = width;
    iconNameLabel.top = iconImageView.bottom + 4;
    [iconView addSubview:iconNameLabel];
    
    return iconView;
    
}

@end
