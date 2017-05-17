//
//  CustomSegmentContrl.h
//  ScrollView
//
//  Created by Allone on 16/3/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SegmentTradeType) {
    TradeTypeLimitView  = 0,
    TradeTypeStopView   = 1,
    TradeTypeOCOView    = 2,
    TradeTypeAllView    = 3,
    TradeTypeUnknowView = 4
};

@protocol CustomSegmentProtocol <NSObject>

- (NSArray *)getSegmentNameArray;

- (CGFloat)getCornerRadius;
- (CGFloat)getCornerWidth;
- (CGFloat)getButtobMiddleAdge;

- (void)didClickButtonAtIndex:(NSUInteger)index;



@end

@interface CustomSegmentControl : UIView

@property (nonatomic)id<CustomSegmentProtocol> delegate;

@property (nonatomic) NSUInteger currentSelectIndex;

@end
