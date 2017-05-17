//
//  LayoutContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"
#import "ListenerProtocol.h"

@interface LayoutContentView : UIView<ListenerProtocol>

- (void)resetContentView;

@end
