//
//  YAXSettingCell.m
//  CaiPiao01
//
//  Created by 余艾星 on 16/3/7.
//  Copyright © 2016年 余艾星. All rights reserved.
//

#import "YAXSettingCell.h"
#import "UIImage+FDImage.h"


#define FONT (28 * SCALE)

@interface YAXSettingCell ()


@property (nonatomic, weak) UIImageView *bottomLine;


//子标题
@property (nonatomic, weak) UILabel *subTitleLabel;



@end

@implementation YAXSettingCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{

    static NSString *ID = @"YAXSettingCell";
    
    YAXSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[YAXSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
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
        
        contentLabel.textAlignment = NSTextAlignmentRight;
        
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
    if (item[YAXStitle]) {
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:10];
        self.detailTextLabel.alpha = 0.5;
        self.detailTextLabel.text = item[YAXStitle];
    }
    
    self.textLabel.text = item[YAXTitle];
    
    
    
    //箭头样式
    id obj = [[NSClassFromString(item[YAXAccessoryType]) alloc] init];
    if ([obj isKindOfClass:[UIImageView class]]) {
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item[YAXAccessoryName]]];
        
    }
    
    
    //开关样式
    if ([obj isKindOfClass:[UISwitch class]]) {
        
        self.accessoryView = [[UISwitch alloc] init];

        UISwitch *switchView = (UISwitch *)self.accessoryView;
        [switchView addTarget:self action:@selector(switchDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *gesture = [FDUserDefaults objectForKey:SDGusturePassword];
        
        if (gesture.length) {
            
            switchView.on = YES;
        }else{
        
            switchView.on = NO;
        }
        
    }
    
    
    if ([obj isKindOfClass:[UIImageView class]]) {
        
        self.contentLabel.x = SCREENWIDTH/2 - 30;
    }else{
        
        self.contentLabel.x = SCREENWIDTH/2 - 10;
    }
    
}

- (void)switchDidClicked:(UISwitch *)sender{

    if (sender.on) {
        
//        [FDUserDefaults setObject:@"1" forKey:SDOpenGusturePassword];
        
        if ([self.delegate respondsToSelector:@selector(settingCellGestureSwitchOn)]) {
            
            [self.delegate settingCellGestureSwitchOn];
        }
        
    }else{
    
        [FDUserDefaults setObject:@"0" forKey:SDOpenGusturePassword];
        [FDUserDefaults setObject:nil forKey:SDGusturePassword];
        
    }
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.bottomLine.frame = CGRectMake(10, self.height, self.width - 20, 1 * SCALE);
    
//    self.accessoryView.x += 10;
    
    //设置图片
    if (self.item[YAXTitleIconImageView]) {
        
        CGFloat iconW = 87 * SCALE;
        
        self.titleIconImageView.frame = CGRectMake(SCREENWIDTH - iconW - 30, 0, iconW, iconW);
        self.titleIconImageView.centerY = self.height/2;
        self.titleIconImageView.layer.cornerRadius = iconW/2;
        self.titleIconImageView.clipsToBounds = YES;
        
        
    }
    
    self.contentLabel.width = SCREENWIDTH/2;
    self.contentLabel.height = self.height;
    self.contentLabel.y = 0;
    
    
    id obj = [[NSClassFromString(self.item[YAXAccessoryType]) alloc] init];
    if ([obj isKindOfClass:[UIImageView class]]) {
        
        self.contentLabel.x = SCREENWIDTH/2 - 30;
    }else{
    
        self.contentLabel.x = SCREENWIDTH/2 - 15;
    }
    
}


@end

















