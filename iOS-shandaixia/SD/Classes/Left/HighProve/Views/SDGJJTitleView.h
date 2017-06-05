//
//  SDGJJTitleView.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDGJJ;

@protocol SDGJJTitleViewDelegate <NSObject>

- (void)gjjTitleViewButtonDidClicked:(NSInteger)tag;

@end

@interface SDGJJTitleView : UIView

@property (nonatomic, weak) id<SDGJJTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame gjjArray:(NSArray *)gjjArray;

@end
