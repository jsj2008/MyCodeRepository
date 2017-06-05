//
//  SDCheckView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/3.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDLoan;
@class SDLending;

@interface SDCheckView : UIView

@property (nonatomic, strong) SDLoan *loan;

@property (nonatomic, strong) SDLending *lending;


@end
