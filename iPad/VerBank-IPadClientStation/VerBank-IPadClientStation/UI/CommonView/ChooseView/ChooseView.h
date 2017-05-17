//
//  ChooseView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseView : UIView

@property NSArray *contentArray;
@property UITableView *contentTableView;

- (void)setTitle:(NSString *)title;

@end
