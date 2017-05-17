//
//  CheckWarningNode.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckWarningNode : NSObject {
    Boolean _isSucceed;
    NSString *_errorMsg;
}

- (id)initWithIsSucceed:(Boolean)isSucceed errorMsg:(NSString *)errorMsg;

@property Boolean isSucceed;
@property NSString *errorMsg;

@end
