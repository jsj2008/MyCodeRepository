//
//  TencentApiManager.h
//  BabyDaily
//
//  Created by marco on 8/19/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>

typedef NS_ENUM(NSUInteger, QQShareType) {
    QQShareMessage,
    QQShareZone
};

@protocol QQApiManagerDelegate <NSObject>

@optional
- (void)managerDidRecvGetMessageReq:(GetMessageFromQQReq *)request;
- (void)managerDidRecvSendMessageReq:(SendMessageToQQReq *)request;
- (void)managerDidRecvShowMessageReq:(ShowMessageFromQQReq *)request;

- (void)managerDidRecvMessageResponse:(GetMessageFromQQResp *)response;
- (void)managerDidRecvSendMessageResponse:(SendMessageToQQResp *)response;
- (void)managerDidRecvShowMessageResponse:(ShowMessageFromQQResp *)Response;

- (void)managerIsOnlineResponse:(NSDictionary *)response;
@end


@interface QQApiManager : NSObject <QQApiInterfaceDelegate>

@property (nonatomic, weak) id<QQApiManagerDelegate> delegate;

+ (instancetype)sharedManager;

+ (BOOL)isQQInstalled;

+ (BOOL)sharedMessageToQQ:(NSString*)title
                  message:(NSString *) message
                detailUrl:(NSString *) detailUrl
                    image:(UIImage *)image
                shareType:(QQShareType) sharedType;
@end
