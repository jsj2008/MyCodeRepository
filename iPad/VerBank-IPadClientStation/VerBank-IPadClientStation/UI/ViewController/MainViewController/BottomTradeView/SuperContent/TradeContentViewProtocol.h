//
//  TradeContentViewProtocol.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/1.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TradeContentViewProtocol <NSObject>

@required
- (void)initContentColumNames;
- (void)initLeftColumNames;
- (UITableViewCell *) updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath;
- (UITableViewCell *) updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath;

- (CGFloat)getLeftColumWidth;
- (CGFloat)getContentColumWidth;
- (CGFloat)getScrollContentWidth;

@end
