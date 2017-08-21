//
//  VersionCheckService.h
//  ZhenBaoHui
//
//  Created by marco on 8/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionCheckService : NSObject

+ (instancetype)sharedService;

- (void)check;

@end
