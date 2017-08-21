//
//  MISettingCell.m
//  HongBao
//
//  Created by Ivan on 16/3/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "STSettingCell.h"
#import "UserService.h"

@interface STSettingCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation STSettingCell


- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.moreImageView];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *itemData = (NSDictionary *)self.cellData;
        
        if ( [itemData[@"arrow"] boolValue] ) {
            self.moreImageView.hidden = NO;
            self.moreImageView.centerY = [STSettingCell heightForCell:itemData] / 2;
            
        } else {
            self.moreImageView.hidden = YES;
        }
        
        if ( [@"avatar" isEqualToString:itemData[@"type"]] ) {
            self.avatarImageView.hidden = NO;
            self.valueLabel.hidden = YES;
            if (!IsEmptyString([UserService sharedService].avatar)) {
                [self.avatarImageView setOnlineImage:[UserService sharedService].avatar placeHolderImage:[UIImage imageNamed:@"mine_default_avatar"]];
            }else{
                self.avatarImageView.image = [UIImage imageNamed:@"mine_default_avatar"];
            }
        } else {
            self.avatarImageView.hidden = YES;
            self.valueLabel.hidden = NO;
            
            NSString *value = @"";
            
            if ( [@"name" isEqualToString:itemData[@"type"]] ) {
                value = [UserService sharedService].name;
            } else if ( [@"phone" isEqualToString:itemData[@"type"]] ) {
                value = [UserService sharedService].phone;
            } else if ( [@"gender" isEqualToString:itemData[@"type"]] ) {
                
                if ( [@"1" isEqualToString:[UserService sharedService].gender] ) {
                    value = @"男";
                } else {
                    value = @"女";
                }
            }
            
            self.valueLabel.text = value;
            
            [self.valueLabel sizeToFit];
            
            if ( [itemData[@"arrow"] boolValue] ) {
                self.valueLabel.right = SCREEN_WIDTH - 40;
                
            } else {
                self.valueLabel.right = SCREEN_WIDTH - 20;
            }
            
            self.valueLabel.centerY = [STSettingCell heightForCell:itemData] / 2;
        }
        
        self.titleLabel.text = itemData[@"title"];
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 20;
        self.titleLabel.centerY = [STSettingCell heightForCell:itemData] / 2;
        
        self.lineView.bottom = [STSettingCell heightForCell:itemData];
        self.lineView.hidden = ![itemData[@"line"] boolValue];
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if ( cellData ) {
        
        NSDictionary *itemData = (NSDictionary *)cellData;
        
        if ( [@"empty" isEqualToString:itemData[@"type"]] ) {
            return 20;
        } else if ( [@"avatar" isEqualToString:itemData[@"type"]] ) {
            return 120;
        }  else {
            return 50;
        }
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)avatarImageView {
    
    if ( !_avatarImageView ) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 70, 70)];
        _avatarImageView.centerY = 60;
        _avatarImageView.right = SCREEN_WIDTH - 20 - 20;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 35;
    }
    
    return _avatarImageView;
}

- (UILabel *)titleLabel {
    
    if ( !_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.textColor = Color_Gray42;
        _titleLabel.font = FONT(16);
    }
    
    return _titleLabel;
    
}

- (UILabel *)valueLabel {
    
    if ( !_valueLabel ) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _valueLabel.textColor = Color_Gray148;
        _valueLabel.font = FONT(16);
    }
    
    return _valueLabel;
    
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15 * 2, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
    }
    
    return _lineView;
    
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = 22.5;
        _moreImageView.right = SCREEN_WIDTH - 15;
    }
    
    return _moreImageView;
}

@end
