//
//  ClosePositionPopCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/6.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClosePositionPopCellView : UIView

@property (nonatomic, retain)UIView *popCellView;
@property (nonatomic, retain)UILabel *openPriceName;
@property (nonatomic, retain)UILabel *openPriceValueName;
@property (nonatomic, retain)UILabel *closeTime;
@property (nonatomic, retain)UIView *bottomLineView;

- (void)setIsNeedBottomLine:(Boolean)need;

@end
