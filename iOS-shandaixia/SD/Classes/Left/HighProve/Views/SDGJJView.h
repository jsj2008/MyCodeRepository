//
//  SDGJJView.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDGJJ;
@class SDCity;

@protocol SDGJJViewDelegate <NSObject>

@optional
- (void)gjjViewVerifyStatus:(NSString *)status;

@end

@interface SDGJJView : UIView

@property (nonatomic, strong) SDGJJ *gjj;

@property (nonatomic, strong) SDCity *city;

@property (nonatomic, copy) NSString *channelType;
@property (nonatomic, copy) NSString *taskId;

@property (nonatomic, weak) id<SDGJJViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame gjj:(SDGJJ *)gjj;

@end
