//
//  DiscoveryViewController.m
//  BabyDaily
//
//  Created by marco on 8/16/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseHeadWallViewController.h"

@interface BaseHeadWallViewController ()

@end

@implementation BaseHeadWallViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hasHeader = YES;
    
}

#pragma mark - Custom Methods

- (void)addCollectionView
{
    WallViewLayout *layout = [[WallViewLayout alloc] init];
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.hideNavigationBar ? 0 : NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (self.hideNavigationBar ? 0 : NAVBAR_HEIGHT)) collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self registCell];
    
    [self.view addSubview:self.collectionView];
}


#pragma mark - Private Methods

- (void)registCell
{
    [self.collectionView registerClass:[DefaultWallCell class] forCellWithReuseIdentifier:[DefaultWallCell cellIdentifier]];
    [self.collectionView registerClass:[DefaultWallHeaderCell class] forCellWithReuseIdentifier:[DefaultWallHeaderCell cellIdentifier]];
}

- (NSInteger)itemCount
{
    return 30;
}

- (NSInteger)headerCount
{
    return 3;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    DefaultWallHeaderCell *headerCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[DefaultWallHeaderCell cellIdentifier] forIndexPath:indexPath];
    
    [headerCell setCellData:@200];
    
    [headerCell reloadData];
    
    return headerCell;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DefaultWallCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[DefaultWallCell cellIdentifier] forIndexPath:indexPath];
    
    cell.cellData = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    
    [cell reloadData];
    
    return cell;
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DBG(@"didSelectItemAtIndexPath: %@", indexPath);
}

- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath*)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, [DefaultWallHeaderCell heightForCell:@200]);
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CELL_WIDTH, [DefaultWallCell heightForCell:[NSString stringWithFormat:@"%ld", (long)indexPath.item]]);
}

#pragma mark - WallViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(WallViewLayout *)layout numberOfColumnsInSection:(NSInteger)section{
    
    if ( self.hasHeader && [self headerCount] > section ) {
        return 1;
    }
    
    return 2;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ( self.hasHeader && [self headerCount] > section ) {
        return 1;
    }
    
    return [self itemCount];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.hasHeader) {
        return [self headerCount]+1;
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( self.hasHeader && [self headerCount] > indexPath.section ) {
        
        return [self cellForHeaderAtIndexPath:indexPath];
        
    } else {
        
        return [self cellForItemAtIndexPath:indexPath];
        
    }
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= [self headerCount]) {
        [self didSelectItemAtIndexPath:indexPath];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WallViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if ( self.hasHeader && [self headerCount] > section ) {
        return 0;
    }
    
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WallViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    if ( self.hasHeader && [self headerCount] > section ) {
        return 0;
    }
    
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(WallViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if ( self.hasHeader && [self headerCount] > section ) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    return UIEdgeInsetsMake(0, 5, 10, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(WallViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.hasHeader && [self headerCount] > indexPath.section ) {
        return [self sizeForHeaderAtIndexPath:indexPath];
    }
    
    return [self sizeForItemAtIndexPath:indexPath];
}


@end
