//
//  LeftTableViewCell.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftTableViewCell : UITableViewCell{
    IBOutlet UIImageView *_iconView;
    IBOutlet UILabel *_nameLabel;
}

@property (nonatomic, retain)UIImageView *iconView;
@property (nonatomic, retain)UILabel *nameLabel;

@end
