//
//  ForexNewsPopView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDNFeedParser.h"

@interface ForexNewsPopView : UIView {
    IDNFeedItem *_info;
}

- (void)setInf:(IDNFeedItem *)info;

@end
