//
//  MIHeadCell.m
//  Eagles
//
//  Created by marco on 6/15/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "MIHeadCell.h"
#import "UserService.h"
#import "MineResultModel.h"

@interface MIHeadCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UIButton *topUpButton;
@property (nonatomic, strong) UILabel *balanceLabel;
@end

@implementation MIHeadCell

- (void)drawCell
{
    self.backgroundColor = Theme_Color;
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.moreImageView];
    [self addSubview:self.topUpButton];
    [self addSubview:self.balanceLabel];
    
    self.avatarImageView.centerY = 116 / 2.0f;
   
    self.moreImageView.right = SCREEN_WIDTH - 20;
    self.moreImageView.centerY = 116/2;
    
    [self bk_whenTapped:^{
        [[TTNavigationService sharedService] openUrl:@"xiaoma://setting"];
    }];
}

- (void)reloadData
{
    
    self.avatarImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    
    if ( [UserService sharedService].isLogin ) {
        
        self.avatarImageView.hidden = NO;
        if (!IsEmptyString([UserService sharedService].avatar)) {
            [self.avatarImageView setOnlineImage:[UserService sharedService].avatar placeHolderImage:[UIImage imageNamed:@"mine_default_avatar"]];
        }else{
            self.avatarImageView.image = [UIImage imageNamed:@"mine_default_avatar"];
        }
        
        self.nameLabel.hidden = NO;
        self.nameLabel.text = [UserService sharedService].name;
        [self.nameLabel sizeToFit];
        self.nameLabel.left = self.avatarImageView.right + 17;
        self.nameLabel.bottom = self.avatarImageView.centerY;
        
        if (self.cellData) {
            MineResultModel *model = self.cellData;
            NSString *balance = [NSString stringWithFormat:@"夺宝币：%@",model.coins];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:balance];
            [attr addAttribute:NSForegroundColorAttributeName value:RGB(45, 45, 45) range:NSMakeRange(4, model.coins.length)];
            self.balanceLabel.attributedText = attr;
            [self.balanceLabel sizeToFit];
            self.balanceLabel.left = self.nameLabel.left;
            self.balanceLabel.top = self.nameLabel.bottom + 8;
        }
        
    }
    if (self.showLuck) {
        self.topUpButton.hidden = NO;
        self.balanceLabel.hidden = NO;
    }else{
        self.topUpButton.hidden = YES;
        self.balanceLabel.hidden = YES;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    return 116;
}

#pragma mark - Subviews
- (UIImageView *)avatarImageView {
    
    if ( !_avatarImageView ) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 23, 0, 70, 70)];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 35.0f;
        _avatarImageView.centerY = 50;
        _avatarImageView.userInteractionEnabled = YES;
        [_avatarImageView bk_whenTapped:^{
            [[TTNavigationService sharedService] openUrl:@"xiaoma://setting"];
        }];
    }
    
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    
    if ( !_nameLabel ) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _nameLabel.textColor = Color_White;
        _nameLabel.font = FONT(16);
    }
    
    return _nameLabel;
    
}


- (UIImageView *)moreImageView
{
    if (!_moreImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 7, 14)];
        imageView.image = [UIImage imageNamed:@"more_white"];
        _moreImageView = imageView;
    }
    return _moreImageView;
}

- (UIButton *)topUpButton{
    if (!_topUpButton) {
        UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 24)];
        button.right = SCREEN_WIDTH - 22;
        button.top = 66;
        button.backgroundColor = Theme_Color;
        button.layer.cornerRadius = 1;
        button.layer.masksToBounds = YES;
        [button setTitle:@"充值" forState:UIControlStateNormal];
        [button setTitleColor:Color_White forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        [button bk_whenTapped:^{
            [[TTNavigationService sharedService]openUrl:@"xiaoma://topUp"];
        }];
        _topUpButton = button;
        
    }
    return _topUpButton;
}

- (UILabel *)balanceLabel{
    if (!_balanceLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        _balanceLabel = label;
    }
    return _balanceLabel;
}

#pragma mark -button actions
- (void)settingsButtonTapped
{
    [[TTNavigationService sharedService] openUrl:@"xiaoma://setting"];
}
@end
