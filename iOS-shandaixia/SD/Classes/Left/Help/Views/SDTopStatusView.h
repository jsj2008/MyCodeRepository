//
//  SDTopStatusView.h
//  SD
//
//  Created by LayZhang on 2017/5/31.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SDQuestionType) {
    SDQuestionTypeNormal = 0,
    SDQuestionTypeApply,
    SDQuestionTypeRefundAndOverdue,
    SDQuestionTypeUserPrivacy,
    SDQuestionTypeUserFeedBack
};

@protocol TopStatusDelegate <NSObject>

- (void)didSelectAtIndex:(SDQuestionType)questionType;

@end

@interface SDTopStatusView : UIView

@property (nonatomic, weak) id<TopStatusDelegate> delegate;

@end
