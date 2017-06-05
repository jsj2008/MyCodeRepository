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

@protocol YAXSettingCellDelegate <NSObject>

@optional
- (void)settingCellGestureSwitchOn;

@end

@interface YAXSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<YAXSettingCellDelegate> delegate;

@property (nonatomic,strong) NSDictionary *item;

//头像
@property (nonatomic, weak) UIImageView *titleIconImageView;

//内容
@property (nonatomic, weak) UILabel *contentLabel;

@end
