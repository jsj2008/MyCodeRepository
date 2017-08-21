//
//  EquidistantLayout.h
//  HongBao
//
//  Created by marco on 5/12/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EquidistantLayout;

@protocol EquidistantLayoutDelegate <UICollectionViewDelegate>


@optional
/**
 返回每个item的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(EquidistantLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
/**
 section的边距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(EquidistantLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
/**
 item的行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(EquidistantLayout*)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section;
/**
 item的横向间隔
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(EquidistantLayout*)collectionViewLayout itemSpacingForSectionAtIndex:(NSInteger)section;
/**
 section head size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(EquidistantLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
/**
 section foot size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(EquidistantLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end

@interface EquidistantLayout : UICollectionViewLayout

@property(nonatomic,weak)id<EquidistantLayoutDelegate,UICollectionViewDataSource> delegate;

@end
