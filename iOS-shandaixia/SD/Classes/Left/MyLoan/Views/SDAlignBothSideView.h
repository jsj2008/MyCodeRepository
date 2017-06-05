//
//  SDAlignBothSideView.h
//  SD
//
//  Created by LayZhang on 2017/4/19.
//  Copyright © 2017年 LayZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAlignBothSideView : UIView

//propName
@property (nonatomic,weak) UILabel *propLabel;

//Description
@property (nonatomic,weak) UILabel *descriptionLabel;


+ (SDAlignBothSideView *)alignViewWithPropFont:(CGFloat)propFont propColor:(UIColor *)propColor desFont:(CGFloat)desFont desColor:(UIColor *)desColor;

@end
