//
//  MessageCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCellView : UIView {
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_timeLabel;
    IBOutlet UIImageView *_backgroundImageView;
}

@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *timeLabel;
@property (nonatomic, retain)UIImageView *backgroundImageView;

+ (MessageCellView *)newInstance;

@end
