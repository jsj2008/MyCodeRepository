//
//  SDEleSignatureCell.h
//  SD
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//


#define YAXTitle              @"YAXTitle"
#define YAXIcon               @"YAXIcon"
#define YAXAccessoryType      @"YAXAccessoryType"
#define YAXAccessoryName      @"YAXAccessoryName"
#define YAXTargetVc           @"YAXTargetVc"
#define YAXPlistName          @"YAXPlistName"
#define YAXSwitchKey          @"YAXSwitchKey"
#define YAXItems              @"YAXItems"
#define YAXStitle             @"YAXStitle"
#define YAXCheckUpdate        @"YAXCheckUpdate"
#define YAXTitleIconImageView @"YAXTitleIconImageView"

#import <UIKit/UIKit.h>

@protocol SDEleSignatureCellDelegate <NSObject>

@optional
- (void)eleSignatureCellGestureSwitch:(UISwitch *)sender;

@end

@interface SDEleSignatureCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<SDEleSignatureCellDelegate> delegate;

@property (nonatomic,strong) NSDictionary *item;

//头像
@property (nonatomic, weak) UIImageView *titleIconImageView;

//内容
@property (nonatomic, weak) UILabel *contentLabel;

@end
