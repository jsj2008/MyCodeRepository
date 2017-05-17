//
//  ShowChooseView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/10.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol chooseProtocol <NSObject>

- (void)didSelectAtIndex:(int)index type:(int)type;

@end

@interface ShowChooseView : UIView

@property int type;
@property ShowChooseView *subChooseView;

- (void)setDelegate:(id)delegate;
- (void)setChooseArray:(NSArray *)array;

- (void)reloadData;

@end
