//
//  SDSlider.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SliderX (90 * SCALE)
#define numBlank ((SCREENWIDTH - SliderX * 2)/5)

@interface SDSlider : UIView



@property (nonatomic,assign) NSInteger receivedMoney;
@property (nonatomic,assign) NSInteger movedX;


@end
