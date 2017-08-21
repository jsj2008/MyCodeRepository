//
//  TencentApiManager.m
//  BabyDaily
//
//  Created by marco on 8/19/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "QQApiManager.h"
#import "UIImage+TT.h"

@interface QQApiManager ()

@end

@implementation QQApiManager

#pragma mark - LifeCycle

+(instancetype)sharedManager {
    static QQApiManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QQApiManager alloc] init];
    });

    return instance;
}

+ (BOOL)isQQInstalled
{
    return [QQApiInterface isQQInstalled];
}


- (void)delegateDealloc {
    self.delegate = nil;
}

+ (BOOL)sharedMessageToQQ:(NSString*)title
                  message:(NSString *) message
                detailUrl:(NSString *)detailUrl
                    image:(UIImage *)image
                shareType:(QQShareType) sharedType
{
    UIImage *compressedImage = [image imageWithFileSize:32*1024 scaledToSize:CGSizeMake(300, 300)];
    NSData *imageData = UIImageJPEGRepresentation(compressedImage,1.0);
    NSString *description = message;
    QQApiNewsObject *object = [QQApiNewsObject
                               objectWithURL:[NSURL URLWithString:detailUrl]
                               title:title?title:@""
                               description:description
                               previewImageData:imageData];
    //    QQApiURLObject *object = [[QQApiURLObject alloc] initWithURL:[NSURL URLWithString:detailUrl]
    //                                                           title:title
    //                                                     description:description
    //                                                previewImageData:imageData
    //                                               targetContentType:QQApiURLTargetTypeNotSpecified];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:object];
    
    QQApiSendResultCode sent;
    if (sharedType == QQShareMessage)
    {
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
    }
    else {
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    }
    if (sent == EQQAPISENDSUCESS) {
        return YES;
    }
    else {
        return NO;
    }
    return NO;
}


#pragma mark -QQApiInterfaceDelegate
/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req
{
    if ([req isKindOfClass:GetMessageFromQQReq.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)]) {
            GetMessageFromQQReq* getMessageFromQQReq = (GetMessageFromQQReq*)req;
            [_delegate managerDidRecvGetMessageReq:getMessageFromQQReq];
        }
    }
    else if ([req isKindOfClass:SendMessageToQQReq.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvSendMessageReq:)]) {
            SendMessageToQQReq *sendMessageToQQReq = (SendMessageToQQReq *)req;
            [_delegate managerDidRecvSendMessageReq:sendMessageToQQReq];
        }
    }
    else if ([req isKindOfClass:ShowMessageFromQQReq.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
            ShowMessageFromQQReq *showMessageFromQQReq = (ShowMessageFromQQReq *)req;
            [_delegate managerDidRecvShowMessageReq:showMessageFromQQReq];
        }
    }
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp
{
    if ([resp isKindOfClass:GetMessageFromQQResp.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
            GetMessageFromQQResp* getMessageFromQQResponse = (GetMessageFromQQResp*)resp;
            [_delegate managerDidRecvMessageResponse:getMessageFromQQResponse];
        }
    }
    else if ([resp isKindOfClass:SendMessageToQQResp.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvSendMessageResponse:)]) {
            SendMessageToQQResp *sendMessageToQQResponse = (SendMessageToQQResp *)resp;
            [_delegate managerDidRecvSendMessageResponse:sendMessageToQQResponse];
        }
    }
    else if ([resp isKindOfClass:ShowMessageFromQQResp.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageResponse:)]) {
            ShowMessageFromQQResp *sendMessageFromQQResponse = (ShowMessageFromQQResp *)resp;
            [_delegate managerDidRecvShowMessageResponse:sendMessageFromQQResponse];
        }
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response
{
    if (_delegate
        && [_delegate respondsToSelector:@selector(managerIsOnlineResponse:)]) {
        [_delegate managerIsOnlineResponse:response];
    }
}
@end
