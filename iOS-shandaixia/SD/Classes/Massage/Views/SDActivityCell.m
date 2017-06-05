//
//  SDActivityCell.m
//  SD
//
//  Created by LayZhang on 2017/5/24.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDActivityCell.h"

@interface SDActivityCell()

@property (nonatomic, weak) UIImageView *mainImageView;
@property (nonatomic, weak) UIImageView *statusImageView;

@end

@implementation SDActivityCell


#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"SDActivityCell";
    SDActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SDActivityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = FDColor(243, 245, 249);
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(243, 245, 249)]];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *mainImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(70, 153, 255)]];
        mainImageView.layer.cornerRadius = 10.f;
        self.mainImageView = mainImageView;
        [self addSubview:mainImageView];
        
        UIImageView *statusImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(100, 20, 20)]];
        self.statusImageView = statusImageView;
        [self addSubview:statusImageView];
    }
    
    return self;
}

#pragma mark - update constraints
- (void)updateConstraints {
    [super updateConstraints];
    __weak typeof(self) ws = self;
    [self.mainImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * SCALE);
        make.right.mas_equalTo(- 20 * SCALE);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(- 50 * SCALE);
    }];
    
    [self.statusImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.mainImageView);
        make.centerY.equalTo(self.mainImageView);
        make.height.mas_equalTo(78 * SCALE);
    }];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end
