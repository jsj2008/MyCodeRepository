//
//  ItemBuyView.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum CIBuyViewType{
    ItemBuyViewTypeNone,
    ItemBuyViewTypeProcess
}CIBuyViewType;

@protocol CIBuyViewDelegate <NSObject>

- (void)handleBuyButtonWithAmount:(int)amount;

@end

@interface CIBuyView : UIView
@property (nonatomic, assign) CIBuyViewType type;
@property (nonatomic, assign) id<CIBuyViewDelegate> delegate;
@property (nonatomic, assign) float price;
- (void)close;
@end
