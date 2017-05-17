//
//  MessageView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LeftTradeContentView.h"

static Boolean isAllRead = false;

@interface MessageView : LeftTradeContentView

@property IBOutlet UITableView *contentTableView;

+ (Boolean)getIsAllRead;

@end
