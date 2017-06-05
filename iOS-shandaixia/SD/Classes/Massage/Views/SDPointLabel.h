//
//  SDPointLabel.h
//  SD
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PointLabelStatus) {
    PointLabelTrue = 1,
    PointLabelFalse = 2,
};

@interface SDPointLabel : UIView

@property (nonatomic, weak) UIImageView *pointImageView;
@property (nonatomic, weak) UILabel     *contentLabel;

- (void)setPointLabelStyle:(PointLabelStatus)pointStatus;

@end
