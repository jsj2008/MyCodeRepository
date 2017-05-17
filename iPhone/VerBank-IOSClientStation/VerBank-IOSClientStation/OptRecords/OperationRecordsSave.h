//
//  OperationRecordsSave.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/6/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationRecordsSave : NSObject

+ (OperationRecordsSave *)getInstance;

- (void)addOpeRecords:(int)type subType:(int)subType;
- (void)sendToServer;

@end
