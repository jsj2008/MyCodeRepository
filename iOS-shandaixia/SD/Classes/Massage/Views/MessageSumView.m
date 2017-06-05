//
//  MessageSumView.m
//  SD
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "MessageSumView.h"

@implementation MessageSumView

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self initContent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initContent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initContent];
    }
    return self;
}

- (void)initContent {
    
    self.backgroundColor = SDWhiteColor;
    
    UIImageView *lendingImageView = [[UIImageView alloc] init];
    [self addSubview:lendingImageView];
    self.lendImageView = lendingImageView;
    
    UILabel *messageTypeLabel = [[UILabel alloc] init];
    messageTypeLabel.font = ZLNormalFont(36 * SCALE);
    [self addSubview:messageTypeLabel];
    self.messageTypeLabel = messageTypeLabel;
    
    SDPointLabel *pointLabel = [[SDPointLabel alloc] init];
    [self addSubview:pointLabel];
    self.pointLabel = pointLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = ZLNormalFont(28 * SCALE);
    [self addSubview:timeLabel];
    self.timelabel = timeLabel;
    
    UILabel *contenLabel = [[UILabel alloc] init];
    self.contentLabel.font = ZLNormalFont(26 * SCALE);
    contenLabel.textColor = [UIColor grayColor];
    [self addSubview:contenLabel];
    self.contentLabel = contenLabel;
    
    UIImageView *topLineView = [[UIImageView alloc] init];
    topLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:topLineView];
    self.topLineView = topLineView;
    
    UIImageView *bottomLineView = [[UIImageView alloc] init];
    bottomLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:bottomLineView];
    self.bottomLineView = bottomLineView;
}

#pragma mark - update constraints
- (void)updateConstraints {
    [super updateConstraints];
    __weak typeof(self) ws = self;
    [self.lendImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(40 * SCALE));
        make.centerY.mas_equalTo(0);
        make.height.with.mas_equalTo(50 * SCALE);
        make.width.with.mas_equalTo(50 * SCALE);
    }];
    
    [self.messageTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(26 * SCALE));
        make.left.equalTo(self.lendImageView.mas_right).offset(40 * SCALE);
        make.height.equalTo(@(50 * SCALE));
        make.width.equalTo(@(100 * SCALE));
    }];
    
    [self.pointLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageTypeLabel.mas_right);
        make.centerY.equalTo(self.messageTypeLabel.mas_centerY);
        make.height.equalTo(self.messageTypeLabel.mas_height);
        make.width.equalTo(@(300 * SCALE));
    }];
    
    [self.timelabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(30 * SCALE));
        make.right.equalTo(@(- 30 *SCALE));
        make.width.equalTo(@(100 *SCALE));
        make.height.equalTo(@(40 * SCALE));
    }];
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageTypeLabel.mas_bottom).offset(5 * SCALE);
        make.width.mas_equalTo(ws.mas_width).offset(- 160 * SCALE);
        make.height.equalTo(@(40 * SCALE));
        make.left.equalTo(self.lendImageView.mas_right).offset(40 * SCALE);
    }];
    
    [self.topLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);;
        make.width.mas_equalTo(ws.mas_width);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(0);
    }];
    
    [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(1);
        make.width.mas_equalTo(ws.mas_width);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(0);
    }];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - message update
- (void)setMessageModel:(MessageSumModel *)messageModel {
    self.contentLabel.text = messageModel.content;
    self.timelabel.text = messageModel.time;
    self.pointLabel.contentLabel.text = [[NSNumber numberWithInt:messageModel.messageNum] stringValue];
    
    if (messageModel.readStatus) {
        [self.pointLabel setPointLabelStyle:PointLabelTrue];
    } else {
        [self.pointLabel setPointLabelStyle:PointLabelFalse];
    }
    
    switch (messageModel.messageType) {
        case MessageTypeAnnounce:
            self.lendImageView.image = [UIImage imageNamed:@"icon_announce"];
            self.messageTypeLabel.text = @"公告";
            break;
        case MessageTypeNoticeMessage:
            self.lendImageView.image = [UIImage imageNamed:@"icon_notice_message"];
            self.messageTypeLabel.text = @"消息";
            break;
            
        default:
            break;
    }
}

@end

@implementation MessageSumModel

@end
