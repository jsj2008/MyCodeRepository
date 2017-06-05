//
//  SDNoticeMessageCell.m
//  SD
//
//  Created by LayZhang on 2017/5/24.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDNoticeMessageCell.h"
#import "SDMassages.h"

@interface SDNoticeMessageCell ()

//点
@property (nonatomic, weak) UIImageView *pointImageView;

//白色背景
@property (nonatomic, weak) UIImageView *backView;

//系统通知
@property (nonatomic, weak) UILabel *noteLabel;

//时间
@property (nonatomic, weak) UILabel *timeLabel;

//详情
@property (nonatomic, weak) UILabel *contentsLabel;


@end

@implementation SDNoticeMessageCell
#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"SDNoticeMessageCell";
    SDNoticeMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SDNoticeMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = FDColor(243, 245, 249);
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(243, 245, 249)]];
        
        //点
        UIImageView *pointImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(70, 153, 255)]];
        self.pointImageView = pointImageView;
        [self.contentView addSubview:pointImageView];
        [pointImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(30 * SCALE);
            //            make.top.equalTo(self.contentView.mas_top).offset(40 * SCALE);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(10 * SCALE);
            make.height.mas_equalTo(10 * SCALE);
        }];
        
        //白色背景
        UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:[UIColor whiteColor]]];
        self.backView = backView;
        [self.contentView addSubview:backView];
        
        [backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(100 * SCALE);
            make.right.equalTo(self.contentView.mas_right).offset(- 10 *SCALE);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(- 30 * SCALE);
        }];
        
        /** 系统通知 */
        UILabel *noteLabel = [[UILabel alloc] init];
        noteLabel.font = [UIFont systemFontOfSize:40 * SCALE];
        noteLabel.textColor = [UIColor grayColor];
        [backView addSubview:noteLabel];
        self.noteLabel = noteLabel;
        
        [noteLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(20 * SCALE);
            make.right.equalTo(self.backView.mas_right).offset(-20 * SCALE);
            make.top.equalTo(self.backView.mas_top).offset(10 * SCALE);
        }];
        
        /** 时间 */
        UILabel *timeLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        [backView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        [timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.noteLabel.mas_left);
            make.top.equalTo(self.noteLabel.mas_bottom).offset(10 * SCALE);
//            make.bottom.equalTo(self.backView.mas_bottom).offset(-10 * SCALE);
            make.width.mas_equalTo(140 * SCALE);
        }];
        
        /** 内容 */
        UILabel *contentsLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        contentsLabel.numberOfLines = 0;
        [backView addSubview:contentsLabel];
        self.contentsLabel = contentsLabel;
        [contentsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(20 * SCALE);
            make.right.equalTo(self.backView.mas_right).offset(-20 * SCALE);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(10 * SCALE);
            make.bottom.equalTo(self.backView.mas_bottom).offset(-10 * SCALE);
        }];
    }
    
    return self;
}

- (void)setMassages:(SDMassages *)massages{
    
    _massages = massages;
    
    if ([massages.pushType isEqualToString:@"1"]) {
        
        self.noteLabel.text = @"系统消息";
    }else{
        
        self.noteLabel.text = @"活动消息";
    }
    
    self.timeLabel.text = [FDDateFormatter interceptTimeStampFromStr:massages.gmtCreate];
    self.contentsLabel.text = massages.content;
    FDLog(@"massages.content - %@",massages.content);
    
    switch (massages.status) {
        case SDMassageStatusUnRead:
            
            self.pointImageView.image = [UIImage imageWithBgColor:FDColor(70, 153, 255)];
            break;
        case SDMassageStatusRead:
            
            self.pointImageView.image = [UIImage imageWithBgColor:FDColor(168, 168, 168)];
            
            break;
            
        default:
            break;
    }
    
}


- (void)dealDeleteButton{
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            
            subView.backgroundColor = [UIColor blueColor];
            
            for (UIButton *button in subView.subviews) {
                
                if ([button isKindOfClass:[UIButton class]]) {
                    
                    button.backgroundColor = [UIColor blueColor];
                    button.titleLabel.font = [UIFont systemFontOfSize:11.0];
                    
                }
            }
        }
    }
}
@end
