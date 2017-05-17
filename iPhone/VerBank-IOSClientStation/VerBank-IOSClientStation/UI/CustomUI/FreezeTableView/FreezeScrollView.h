//
//  FreezeScrollView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreezeTableView.h"

@interface FreezeScrollView : UIScrollView

@property (nonatomic, assign) FreezeTableView *parent;

- (void)reDraw;

@end
