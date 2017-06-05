//
//  SDLoanProcedureBankCardCell.m
//  SD
//
//  Created by 余艾星 on 17/3/7.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDLoanProcedureBankCardCell.h"
#import "SDBankCard.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SDLoanProcedureBankCardCell ()


@property (nonatomic, weak) UILabel *cardNameLabel;



@property (nonatomic, weak) UILabel *cardNumberLabel;






@end

@implementation SDLoanProcedureBankCardCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    
    
    static NSString *ID = @"SDLoanProcedureBankCardCell";
    SDLoanProcedureBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        
        cell = [[SDLoanProcedureBankCardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.backgroundColor = SDWhiteColor;
        //
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:SDWhiteColor]];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel *cardNameLabel = [UILabel labelWithText:@"" textColor:FDColor(34, 34, 34) font:(30 * SCALE) textAliment:NSTextAlignmentLeft];
        self.cardNameLabel = cardNameLabel;
        [self.contentView addSubview:cardNameLabel];
        
        
        UIImageView *bankIconImageView = [[UIImageView alloc] init];
        self.bankIconImageView = bankIconImageView;
        [self.contentView addSubview:bankIconImageView];
        
        UILabel *cardNumberLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:(24 * SCALE) textAliment:NSTextAlignmentLeft];
        self.cardNumberLabel = cardNumberLabel;
        [self.contentView addSubview:cardNumberLabel];
        
        UIButton *chooseButton = [UIButton buttonWithImage:@"icon_cancel" backImageNamed:nil];
        [chooseButton sizeToFit];
        self.chooseButton = chooseButton;
        [self.contentView addSubview:chooseButton];
        chooseButton.hidden = YES;
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(220, 220, 220)]];
        self.lineImageView = lineImageView;
        [self.contentView addSubview:lineImageView];
        
    }
    
    return self;
}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat iconX = 30 * SCALE;
    CGFloat iconW = 80 * SCALE;
    CGFloat iconH = iconW;
    CGFloat iconY = 25 * SCALE;
    self.bankIconImageView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(self.bankIconImageView.frame) + 24 * SCALE;
    CGFloat nameW = 200;
    CGFloat nameY = iconY;
    CGFloat nameH = [@"招" sizeOfMaxScreenSizeInFont:30 * SCALE].height;
    self.cardNameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    
    CGFloat numberH = [@"招" sizeOfMaxScreenSizeInFont:24 * SCALE].height;
    CGFloat numberY = CGRectGetMaxY(self.bankIconImageView.frame) - numberH;
    CGFloat numberX = nameX;
    CGFloat numberW = nameW;
    self.cardNumberLabel.frame = CGRectMake(numberX, numberY, numberW, numberH);
    
    self.chooseButton.centerY = self.height/2;
    self.chooseButton.x = self.width - iconX - self.chooseButton.width;
    
    self.lineImageView.frame = CGRectMake(iconX, self.height - 1, self.width - 2 * iconX, 1 * SCALE);
}

- (void)setBankCard:(SDBankCard *)bankCard{
    
    _bankCard = bankCard;
    
    self.cardNameLabel.text = bankCard.bankName;
    
    NSString *cardType;
    
    if ([bankCard.cardType isEqualToString:@"DC"]) {
        
        cardType = @"储蓄卡";
    }else{
        
        cardType = @"储蓄卡";
        
    }
    
    self.cardNumberLabel.text = [NSString stringWithFormat:@"尾号%@%@",[bankCard.cardNumber substringFromIndex:bankCard.cardNumber.length - 4],cardType];
    
    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankCard.logoUrl]];
    
    self.chooseButton.hidden = !bankCard.isDefault;
    
    
}


@end
