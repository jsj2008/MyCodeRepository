//
//  SDWebProveController.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#define theApiKey @"e4e5cb47616942828e6020a06607bee9"

#ifdef DEBUG

#else


#define theApiKey @"a6333559993d4da38f610e970baac530"

#endif

#import "YPCustomNavBarController.h"

// 户ID,您APP中 以识别的 户ID
//#define theUserID @"moxietest_iosdemo"



@interface SDWebProveController : YPCustomNavBarController

@property (nonatomic, weak) UIWebView *webView;


- (void)addWebViewWithUrlString:(NSString *)urlString;
- (void)startType:(NSString *)type;

@end
