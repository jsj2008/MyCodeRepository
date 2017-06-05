//
//  SDProvinceView.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDProvinceViewDelegate <NSObject>

- (void)provinceButtonDidClicked:(NSString *)provinceName;

@end

@interface SDProvinceView : UIView

@property (nonatomic, weak) id<SDProvinceViewDelegate> delagate;

@end
