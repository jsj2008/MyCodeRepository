//
//  CateSearchViewController.h
//  HongBao
//
//  Created by marco on 5/10/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseWallViewController.h"
#import "SortPanelView.h"


@interface CateSearchViewController : BaseWallViewController<SortPanelViewDelegate>

@property (nonatomic, strong) NSString *cateId;

@end
