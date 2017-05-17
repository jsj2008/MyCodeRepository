//
//  MainViewController.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteListContentView.h"
#import "LeftViewController.h"

@interface QuoteListViewController : LeftViewController

- (QuoteListContentView *)getQuoteListView;

@end
