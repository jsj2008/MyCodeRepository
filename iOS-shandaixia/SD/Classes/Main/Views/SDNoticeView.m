//
//  SDNoticeView.m
//  SD
//
//  Created by 余艾星 on 17/3/11.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDNoticeView.h"
#import "CBAutoScrollLabel.h"

@implementation SDNoticeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = FDColor(255, 241, 185);
        
        UIButton *noticeButton = [UIButton buttonWithImage:@"home_hint_closed" backImageNamed:@""];
        noticeButton.height = self.height;
        noticeButton.width = self.height;
        noticeButton.x = SCREENWIDTH - 30 * SCALE - noticeButton.width;
        noticeButton.y = (self.height - noticeButton.height)/2;
        [self addSubview:noticeButton];
        
        self.noticeButton = noticeButton;
        CGFloat noticeX = 30 * SCALE;
        CGFloat noticeW = SCREENWIDTH - noticeX * 3 - noticeButton.width;
        
    
        CBAutoScrollLabel *autoScrollLabel = [[CBAutoScrollLabel alloc] initWithFrame:CGRectMake(noticeX, 0, noticeW, self.height)];
        
        //滚动文字
        //            autoScrollLabel.backgroundColor = [UIColor whiteColor];
        
        self.autoScrollLabel = autoScrollLabel;
        
        self.autoScrollLabel.textColor = FDColor(166, 108, 23);
        self.autoScrollLabel.font = [UIFont systemFontOfSize:30 * SCALE];
        self.autoScrollLabel.labelSpacing = 30; // distance between start and end labels
        self.autoScrollLabel.pauseInterval = 1.7; // seconds of pause before scrolling starts again
        self.autoScrollLabel.scrollSpeed = 30; // pixels per second
        self.autoScrollLabel.textAlignment = NSTextAlignmentLeft; // centers text when no auto-scrolling is applied
        self.autoScrollLabel.scrollDirection = CBAutoScrollDirectionLeft;
        [self.autoScrollLabel observeApplicationNotifications];
        
        [self addSubview:autoScrollLabel];
        
    }
    return self;
}

@end
