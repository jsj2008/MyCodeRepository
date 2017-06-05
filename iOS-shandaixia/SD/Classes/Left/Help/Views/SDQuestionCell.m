//
//  SDQuestionCell.m
//  SD
//
//  Created by LayZhang on 2017/5/31.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDQuestionCell.h"

@interface SDQuestionCell()

@property (nonatomic, weak) UIImageView *topLineImageView;
@property (nonatomic, weak) UILabel *questionLabel;
@property (nonatomic, weak) UILabel *answerLabel;

@end

@implementation SDQuestionCell

//+ (instancetype)cellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *ID = @"SDQuestionCell";
//    SDQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[SDQuestionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        
//        cell.backgroundColor = FDColor(243, 245, 249);
//        
//        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(243, 245, 249)]];
//    }
//    return cell;
//}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    CGFloat contentViewWidth = SCREENWIDTH;
//    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
//    [self.contentView addConstraint:widthFenceConstraint];
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = FDColor(243, 245, 249);
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(243, 245, 249)]];
        self.contentView.clipsToBounds = YES;
        
        UIImageView *topLineImageView = [[UIImageView alloc] init];
        topLineImageView.backgroundColor = FDColor(200, 200, 200);
        self.topLineImageView = topLineImageView;
        [self addSubview:topLineImageView];
        [topLineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(@(0.5));
        }];
        
        // question
        UILabel *questionLabel = [[UILabel alloc] init];
        self.questionLabel = questionLabel;
//        questionLabel.clipsToBounds = YES;
//        questionLabel.backgroundColor = FDColor(100, 100, 100);
        questionLabel.numberOfLines = 0;
        questionLabel.font = ZLBoldFont(38 * SCALE);
        [self.contentView addSubview:questionLabel];
        [questionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10 * SCALE);
//            make.right.equalTo(self.contentView.mas_right).offset(-30 * SCALE);
            make.width.mas_equalTo(SCREENWIDTH - 30 * SCALE);
            make.top.equalTo(self.contentView.mas_top).offset(20 * SCALE);
        }];
        
        UILabel *answerLabel = [[UILabel alloc] init];
        self.answerLabel = answerLabel;
        answerLabel.clipsToBounds = YES;
//        answerLabel.backgroundColor = FDColor(200, 200, 200);
        answerLabel.numberOfLines = 0;
        answerLabel.font = ZLNormalFont(30 * SCALE);
        [self.questionLabel addSubview:answerLabel];
        [answerLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.questionLabel.mas_bottom).offset(20 * SCALE);
            make.left.equalTo(self.contentView.mas_left).offset(10 * SCALE);
//            make.right.equalTo(self.contentView.mas_right).offset(-30 * SCALE);
            make.width.mas_equalTo(SCREENWIDTH - 30 *SCALE);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(- 20 * SCALE);
        }];
    }
    
    return self;
}

- (void)setQuestion:(NSString *)question andAnswer:(NSString *)answer{
    self.questionLabel.text = question;
    self.answerLabel.text = answer;
    if ([answer isEqualToString:@""]) {
        self.answerLabel.hidden = YES;
    } else {
        self.answerLabel.hidden = NO;
    }
}

@end
