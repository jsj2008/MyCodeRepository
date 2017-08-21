//
//  SearchTabController.h
//  HongBao
//
//  Created by marco on 5/12/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSUInteger, XMSearchResultType) {
    XMSearchResultTypeList  =   0,
    XMSearchResultTypeWall  =   1
};

@interface SearchViewController : BaseTableViewController<UITextFieldDelegate>

@property (nonatomic, assign) XMSearchResultType type;

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *tabTitle;

@property (nonatomic, strong) NSString *placeHolder;



@end
