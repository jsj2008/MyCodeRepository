//
//  HMView.h
//  02-手势解锁
//
//  Created by heima on 16/2/26.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMView;

@protocol HMViewDelegate <NSObject>

@optional
- (void)viewTranslateDataWithView:(HMView * )view  andString:(NSString *)pwd;

@end

@interface HMView : UIView
@property(nonatomic,weak)id<HMViewDelegate>delegate;

@end
