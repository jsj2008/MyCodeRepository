//
//  SDFeedBackModel.h
//  SD
//
//  Created by LayZhang on 2017/6/1.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDFeedBackModel : NSObject


//- (NSString *)updateQuestionImageArray:(NSArray *)imageArray;

+ (void)commitUserFeedBackWith:(NSArray *)imageArray
               feedBackContent:(NSString *)content
          feedBackcontentTitle:(NSString *)contentTitle;

@end
