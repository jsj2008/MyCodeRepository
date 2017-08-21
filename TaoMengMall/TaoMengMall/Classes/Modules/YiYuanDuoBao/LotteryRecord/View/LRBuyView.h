//
//  ItemBuyView.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum LRBuyViewType{
    ItemBuyViewTypeNone,
    ItemBuyViewTypeProcess
}LRBuyViewType;

@protocol LRBuyViewDelegate <NSObject>

- (void)handleBuyButtonWithAmount:(int)amount;
- (void)hanleCloseButton;

@end

@interface LRBuyView : UIView
@property (nonatomic, assign) LRBuyViewType type;
@property (nonatomic, assign) id<LRBuyViewDelegate> delegate;
@property (nonatomic, assign) float price;
@end
