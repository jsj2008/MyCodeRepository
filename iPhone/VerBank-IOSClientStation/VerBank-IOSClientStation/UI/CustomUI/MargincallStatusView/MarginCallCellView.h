//
//  MarginCallCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/26.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarginCallCellView : UIView{
    IBOutlet UILabel *_keyName;
    IBOutlet UILabel *_value;
}

@property (nonatomic, retain) UILabel *keyName;
@property (nonatomic, retain) UILabel *value;

+ (id)newInstance;

@end
