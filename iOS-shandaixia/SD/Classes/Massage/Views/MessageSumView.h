//
//  MessageSumView.h
//  SD
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPointLabel.h"

typedef NS_ENUM(NSUInteger, MessageType) {
    MessageTypeAnnounce         = 1,
    MessageTypeNoticeMessage    = 2,
};

@interface MessageSumModel : NSObject

@property (nonatomic, assign) BOOL readStatus;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) MessageType messageType;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) int messageNum;

@end

@interface MessageSumView : UIView

@property (nonatomic, weak) UIImageView     *lendImageView;
@property (nonatomic, weak) UILabel         *messageTypeLabel;
@property (nonatomic, weak) SDPointLabel    *pointLabel;
@property (nonatomic, weak) UILabel         *timelabel;
@property (nonatomic, weak) UILabel         *contentLabel;
@property (nonatomic, weak) UIImageView     *topLineView;
@property (nonatomic, weak) UIImageView     *bottomLineView;

@property (nonatomic, strong) MessageSumModel *messageModel;

@end
