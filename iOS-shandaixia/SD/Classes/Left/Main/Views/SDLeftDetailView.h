//
//  SDLeftDetailView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/18.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDLeftNavBar;

typedef enum {
    SDLeftDetailViewButtonTypeMyLoan,
    SDLeftDetailViewButtonTypeMyDiscount,
    SDLeftDetailViewButtonTypeShared,
    SDLeftDetailViewButtonTypeHighProve,
    SDLeftDetailViewButtonTypeSetting,
    SDLeftDetailViewButtonTypeHelpAndResponds,
    SDLeftDetailViewButtonTypeHeader
    
}SDLeftDetailViewButtonType;


@interface SDLeftDetailView : UIView

@property (nonatomic, strong) SDLeftNavBar *leftNavBar;


@end
