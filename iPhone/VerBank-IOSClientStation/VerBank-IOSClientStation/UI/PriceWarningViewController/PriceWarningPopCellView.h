//
//  PriceWarningPopCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceWarningPopCellView : UIView {
    UIButton *_modifyButton;
    UIButton *_deleteButton;
}

@property (nonatomic, retain)UIButton *modifyButton;
@property (nonatomic, retain)UIButton *deleteButton;

@end
