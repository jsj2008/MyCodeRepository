//
//  SinglePageView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListenerProtocol.h"

@interface SinglePageView : UIView<ListenerProtocol>

@property (nonatomic) NSString *title;
@property NSUInteger pageIndex;

@property UIButton *titleButton;

#pragma abstractFunc
//- (void)addListener;
//- (void)removeListener;

- (void)updateView;

- (void)reloadPageData;
- (void)pageUnSelect;
- (void)pageSelect;

@end
