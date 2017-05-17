//
//  MessageViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/20.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewCell : UITableViewCell

@property IBOutlet UILabel *timeLabel;
@property IBOutlet UILabel *titleLabel;
@property IBOutlet UIImageView *backImageView;

- (void)setRead:(Boolean)isRead;

@end
