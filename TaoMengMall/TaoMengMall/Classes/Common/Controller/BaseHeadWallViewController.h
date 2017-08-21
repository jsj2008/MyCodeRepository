//
//  DiscoveryViewController.h
//  BabyDaily
//
//  Created by marco on 8/16/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseCollectionViewController.h"

#import "WallViewLayout.h"
#import "DefaultWallCell.h"
#import "DefaultWallHeaderCell.h"

@interface BaseHeadWallViewController : BaseCollectionViewController <WallViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) BOOL hasHeader;

@end
