//
//  SDSignatureCheckView.h
//  SD
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDSignatureCheckView : UIView

@property (nonatomic, weak) UILabel *checkLabel;
@property (nonatomic, weak) UIButton *checkBox;

- (void)setIsSelect:(Boolean)isSelect;

@end
