//
//  SDQuestionCell.h
//  SD
//
//  Created by LayZhang on 2017/5/31.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDQuestionCell : UITableViewCell

//+ (instancetype)cellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

//- (void)setItem:(SDQuestionModel *)item;
//@property (nonatomic, strong) SDQuestionModel *item;
- (void)setQuestion:(NSString *)question andAnswer:(NSString *)answer;

@end
