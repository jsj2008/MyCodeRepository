//
//  SDEleSignatureCell.m
//  SD
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//


#import "SDEleSignatureCell.h"

#define FONT (28 * SCALE)

@interface SDEleSignatureCell ()

@property (nonatomic, weak) UIImageView *bottomLine;
//子标题
@property (nonatomic, weak) UILabel *subTitleLabel;

@end


@implementation SDEleSignatureCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"SDEleSignatureCell";
    
    SDEleSignatureCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[SDEleSignatureCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:[UIColor whiteColor]]];
        
        cell.textLabel.textColor = FDColor(39, 39, 39);
        
        cell.textLabel.font = [UIFont systemFontOfSize:FONT];
        
        
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        //头像
        UIImageView *titleIconImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:titleIconImageView];
        
        self.titleIconImageView = titleIconImageView;
        
        //        titleIconImageView.backgroundColor = FDRandomColor;
        
        //子标题
        UILabel *subTitleLabel = [[UILabel alloc]  init];
        
        self.subTitleLabel = subTitleLabel;
        
        subTitleLabel.textColor = FDColor(39, 39, 39);
        
        subTitleLabel.font = [UIFont systemFontOfSize:FONT];
        
        [self.contentView addSubview:subTitleLabel];
        
        //内容
        UILabel *contentLabel = [[UILabel alloc]  init];
        
        self.contentLabel = contentLabel;
        
        contentLabel.textColor = FDColor(39, 39, 39);
        
        contentLabel.font = [UIFont systemFontOfSize:FONT];
        
        contentLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:contentLabel];
        
        //底部虚线
        UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(240, 240, 240)]];
        [self.contentView addSubview:bottomLine];
        self.bottomLine = bottomLine;
        
    }
    
    return self;
}



#pragma mark - 设置数据
- (void)setItem:(NSDictionary *)item{
    
    _item = item;
    
    //设置子标题
    if (item[@"STitle"]) {
        
        self.contentLabel.font = [UIFont systemFontOfSize:36 * SCALE];
        self.contentLabel.alpha = 0.5;
        self.contentLabel.text = item[@"STitle"];
    }
    
    self.textLabel.text = item[@"Title"];
    
    
    
    //箭头样式
    id obj = [[NSClassFromString(item[@"AccessoryType"]) alloc] init];
    if ([obj isKindOfClass:[UIImageView class]]) {
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item[@"AccessoryName"]]];
        
    }
    
    
    //开关样式
    if ([obj isKindOfClass:[UISwitch class]]) {
        
        self.accessoryView = [[UISwitch alloc] init];
        
        UISwitch *switchView = (UISwitch *)self.accessoryView;
//        switchView.onTintColor = FDDRedColor;
        [switchView addTarget:self action:@selector(switchDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([item[@"Value"] isEqualToString:@"TRUE"]) {
            switchView.on = YES;
        } else {
            switchView.on = NO;
        }
        
    }
    
}

- (void)switchDidClicked:(UISwitch *)sender{
    if ([self.delegate respondsToSelector:@selector(eleSignatureCellGestureSwitch:)]) {
        [self.delegate eleSignatureCellGestureSwitch:sender];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.bottomLine.frame = CGRectMake(10, self.height, self.width - 20, 1 * SCALE);
    
    self.contentLabel.width = SCREENWIDTH/2;
    self.contentLabel.height = self.height;
    self.contentLabel.y = 0;
    self.contentLabel.x = 200 * SCALE;
    
}

@end
