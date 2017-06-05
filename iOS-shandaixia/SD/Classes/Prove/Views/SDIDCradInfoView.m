 //
//  SDIDCradInfoView.m
//  SD
//
//  Created by 余艾星 on 17/3/1.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDIDCradInfoView.h"
#import "SDUserInfo.h"


@interface SDIDCradInfoView ()


@property (nonatomic, weak) UILabel *nameLabel;


@property (nonatomic, weak) UILabel *genderLabel;


@property (nonatomic, weak) UILabel *birthLabel;


@property (nonatomic, weak) UILabel *addressLabel;


@property (nonatomic, weak) UILabel *idCardLabel;

@end

@implementation SDIDCradInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat font = 24 * SCALE;
        
        UILabel *nameLabel = [UILabel labelWithText:@"姓名" textColor:FDColor(34, 34, 34) font:font textAliment:0];
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        
        UILabel *genderLabel = [UILabel labelWithText:@"性别" textColor:FDColor(34, 34, 34) font:font textAliment:0];
        self.genderLabel = genderLabel;
        [self addSubview:genderLabel];
        
        
        
        UILabel *birthLabel = [UILabel labelWithText:@"出生日期" textColor:FDColor(34, 34, 34) font:font textAliment:0];
        self.birthLabel = birthLabel;
        [self addSubview:birthLabel];
        
        
        
        UILabel *addressLabel = [UILabel labelWithText:@"地址" textColor:FDColor(34, 34, 34) font:font textAliment:0];
        self.addressLabel = addressLabel;
        [self addSubview:addressLabel];
        
        
        
        UILabel *idCardLabel = [UILabel labelWithText:@"公民身份证" textColor:FDColor(34, 34, 34) font:font textAliment:0];
        self.idCardLabel = idCardLabel;
        [self addSubview:idCardLabel];
        

        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat font = 24 * SCALE;
    CGFloat nameH = [@"姓" sizeOfMaxScreenSizeInFont:font].height;
    CGFloat nameX = 95 * SCALE;
    CGFloat nameY = 54 * SCALE;
    CGFloat nameW = SCREENWIDTH - nameX;
    CGFloat blank = 32 * SCALE;
    
    _nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    _genderLabel.frame = CGRectMake(nameX, nameY + (nameH + blank) * 1, nameW, nameH);
    
    
    _birthLabel.frame = CGRectMake(nameX, nameY + (nameH + blank) * 2, nameW, nameH);
    
    
    _addressLabel.frame = CGRectMake(nameX, nameY + (nameH + blank) * 3, nameW, nameH);
    
    
    _idCardLabel.frame = CGRectMake(nameX, nameY + (nameH + blank) * 4, nameW, nameH);
}

- (void)setUserInfo:(SDUserInfo *)userInfo{

    _userInfo = userInfo;
    
    _nameLabel.text = [NSString stringWithFormat:@"姓名    %@",userInfo.name];
    _genderLabel.text = [NSString stringWithFormat:@"性别    %@",userInfo.sex];
    _birthLabel.text = [NSString stringWithFormat:@"出生日期    %@",userInfo.dateBirth];
    _addressLabel.text = [NSString stringWithFormat:@"住址    %@",userInfo.address];
    _idCardLabel.text = [NSString stringWithFormat:@"公民身份证    %@",userInfo.idCard];
}

@end
