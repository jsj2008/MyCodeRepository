//
//  SearchTabController.h
//  HongBao
//
//  Created by marco on 5/12/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "EquidistantLayout.h"

@interface SearchTabController : BaseCollectionViewController<EquidistantLayoutDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *shopId;

@property (nonatomic,strong) NSString *cateId;
@property (nonatomic,strong) NSString *searchType;
@end
