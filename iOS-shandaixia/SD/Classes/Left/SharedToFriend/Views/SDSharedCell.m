//
//  SDSharedCell.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/22.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDSharedCell.h"
#import "SDShared.h"

@interface SDSharedCell ()

//排名
@property (nonatomic, weak) UILabel *rankLabel;

//账户名
@property (nonatomic, weak) UILabel *nameLabel;

//免息金额
@property (nonatomic, weak) UILabel *sumLabel;


@end

@implementation SDSharedCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"SDSharedCell";
    SDSharedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SDSharedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:[UIColor whiteColor]]];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //排名
        UILabel *rankLabel = [UILabel labelWithText:@"2017.3.22" textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        self.rankLabel = rankLabel;
        [self addSubview:rankLabel];
        
        //账户名
        UILabel *nameLabel = [UILabel labelWithText:@"183****5570" textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        //免息金额
        UILabel *sumLabel = [UILabel labelWithText:@"已放款" textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:NSTextAlignmentRight];
        self.sumLabel = sumLabel;
        [self addSubview:sumLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat rankX = 44 * SCALE;
    CGFloat rankW = 150;
    CGFloat rankH = 48 * SCALE;
    CGFloat rankY = (self.height - rankH)/2;
    
    self.nameLabel.frame = self.sumLabel.frame = self.rankLabel.frame = CGRectMake(rankX, rankY, rankW, rankH);
    
    self.nameLabel.centerX = SCREENWIDTH/2;
    self.sumLabel.x = SCREENWIDTH - rankW - 40 * SCALE;

}

- (void)setShared:(SDShared *)shared{

    _shared = shared;
    
    self.rankLabel.text = [FDDateFormatter interceptTimeStampFromStr:shared.gmtCreate];
    self.nameLabel.text = shared.phone;
    self.sumLabel.text = shared.name;
    
}

@end
