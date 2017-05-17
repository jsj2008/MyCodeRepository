//
//  ForexNewsCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForexNewsCellView : UIView {
    IBOutlet UILabel *_newsTypeLabel;
    IBOutlet UILabel *_timeLabel;
    IBOutlet UILabel *_titleLabel;
    
    IBOutlet UIImageView *_backgroundView;
}

@property (nonatomic, retain)UILabel *newsTypeLabel;
@property (nonatomic, retain)UILabel *timeLabel;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UIImageView *backgroundView;

+ (ForexNewsCellView *)newInstance;

@end
