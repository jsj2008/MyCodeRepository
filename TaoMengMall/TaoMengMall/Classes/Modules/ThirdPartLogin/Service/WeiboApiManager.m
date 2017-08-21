//
//  WeiboApiManager.m
//  BabyDaily
//
//  Created by marco on 8/24/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "WeiboApiManager.h"
#import "UIImage+TT.h"

@interface WeiboApiManager ()

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *userID;
@end


@implementation WeiboApiManager

+ (BOOL)registerApp:(NSString *)appId redirectURI:(NSString *)redirectURI
{
    [WeiboApiManager sharedManager].redirectURI = redirectURI;
    [WeiboApiManager sharedManager].appId = appId;
    return [WeiboSDK registerApp:appId];
}

+ (instancetype)sharedManager
{
    static WeiboApiManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WeiboApiManager alloc] init];
    });
    return instance;
}

+ (BOOL)isWeiboInstalled
{
    return [WeiboApiManager isWeiboInstalled];
}


+ (BOOL)sharedMessageToSinaWeibo:(NSString *) message
                       image:(UIImage *)image
{
    UIImage *compressedImage = [image imageWithFileSize:10*1024*1024];
    NSData *imageData = UIImageJPEGRepresentation(compressedImage,1.0);
    WBMessageObject *wbMessageObject = [WBMessageObject message];
    if (wbMessageObject != nil)
    {
        wbMessageObject.text = message;
    }
    
    if ([imageData length] > 0)
    {
        WBImageObject *imageObj = [WBImageObject object];
        imageObj.imageData = imageData;
        wbMessageObject.imageObject = imageObj;
    }
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = [WeiboApiManager sharedManager].redirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:wbMessageObject authInfo:authRequest access_token:[WeiboApiManager sharedManager].accessToken];
    request.userInfo = @{@"ShareMessageFrom": @"SinaWeiboShare"};
    
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    return [WeiboSDK sendRequest:request];
}


+ (BOOL)sharedMessageToSinaWeibo:(NSString *) message
                           webURL:(NSString *)webURL
                           title:(nonnull NSString*)title
                      coverImage:(nullable UIImage*)coverImage;
{
    //实测缩略图限制为(?, ?)
    UIImage *compressedImage = coverImage?[coverImage imageWithFileSize:32*1024 scaledToSize:CGSizeMake(120, 120)]:nil;
    NSData *imageData = coverImage?UIImageJPEGRepresentation(compressedImage,1.0):nil;
    WBMessageObject *wbMessageObject = [WBMessageObject message];
    if (wbMessageObject != nil)
    {
        wbMessageObject.text = message;
    }
    
    if ([webURL length] > 0)
    {
        WBWebpageObject *webObj = [WBWebpageObject object];
        webObj.objectID = [NSString stringWithFormat:@"%d",arc4random()%1000000];
        webObj.webpageUrl = webURL;
        webObj.title = title;
        webObj.thumbnailData = imageData;
        wbMessageObject.mediaObject = webObj;
    }
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = [WeiboApiManager sharedManager].redirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:wbMessageObject authInfo:authRequest access_token:[WeiboApiManager sharedManager].accessToken];
    request.userInfo = @{@"ShareMessageFrom": @"SinaWeiboShare"};

    
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    return [WeiboSDK sendRequest:request];
}

+ (BOOL)sharedMessageToSinaWeibo:(nullable NSString *) message
                        videoURL:(nonnull NSString *)videoURL
                  videoStreamURL:(nullable NSString*)streamURL
                           title:(nonnull NSString*)title
                      coverImage:(nullable UIImage*)coverImage;
{
    //实测缩略图限制为(168, 168)
    UIImage *compressedImage = coverImage?[coverImage imageWithFileSize:32*1024 scaledToSize:CGSizeMake(160, 160)]:nil;
    NSData *imageData = coverImage?UIImageJPEGRepresentation(compressedImage,1.0):nil;
    WBMessageObject *wbMessageObject = [WBMessageObject message];
    if (wbMessageObject != nil)
    {
        wbMessageObject.text = message;
    }
    
    if ([videoURL length] > 0)
    {
        WBVideoObject *videoObj = [WBVideoObject object];
        videoObj.objectID = [NSString stringWithFormat:@"%d",arc4random()%1000000];
        videoObj.videoUrl = videoURL;
        videoObj.videoStreamUrl = streamURL;
        videoObj.title = title;
        videoObj.thumbnailData = imageData;
        wbMessageObject.mediaObject = videoObj;
    }
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:wbMessageObject];
    request.userInfo = @{@"ShareMessageFrom": @"SinaWeiboShare"};
    
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    BOOL success = [WeiboSDK sendRequest:request];
    return success;
}

+(void)getWeiBoFriendsListOfUser:(NSString*)userId
                     accessToken:(NSString*)token
                      completion:(void(^)(id result,NSError *error))completion
{
    [WBHttpRequest requestForFriendsListOfUser:userId
                               withAccessToken:token
                            andOtherProperties:nil
                                         queue:nil
                         withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                             if (completion) {
                                 completion(result,error);
                             }
                         }];
}


- (void)delegateDealloc {
    self.delegate = nil;
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvSendMessageReq:)]) {
            WBSendMessageToWeiboRequest* sendMessageToWeiboReq = (WBSendMessageToWeiboRequest*)request;
            [_delegate managerDidRecvSendMessageReq:sendMessageToWeiboReq];
        }
    }
    else if ([request isKindOfClass:WBAuthorizeResponse.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthorizeReq:)]) {
            WBAuthorizeRequest *authReq = (WBAuthorizeRequest *)request;
            [_delegate managerDidRecvAuthorizeReq:authReq];
        }
    }
    else if ([request isKindOfClass:WBPaymentResponse.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvPaymentReq:)]) {
            WBPaymentRequest *payReq = (WBPaymentRequest *)request;
            [_delegate managerDidRecvPaymentReq:payReq];
        }
    }
    else if([request isKindOfClass:WBSDKAppRecommendRequest.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvRecommendReq:)]) {
            WBSDKAppRecommendRequest *messageReq = (WBSDKAppRecommendRequest *)request;
            [_delegate managerDidRecvRecommendReq:messageReq];
        }
    }

}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvSendMessageResponse:)]) {
            WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
            [_delegate managerDidRecvSendMessageResponse:sendMessageToWeiboResponse];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthorizeResponse:)]) {
            WBAuthorizeResponse *authResp = (WBAuthorizeResponse *)response;
            [_delegate managerDidRecvAuthorizeResponse:authResp];
        }
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvPaymentResponse:)]) {
            WBPaymentResponse *payResp = (WBPaymentResponse *)response;
            [_delegate managerDidRecvPaymentResponse:payResp];
        }
    }
    else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvRecommendResponse:)]) {
            WBSDKAppRecommendResponse *messageResp = (WBSDKAppRecommendResponse *)response;
            [_delegate managerDidRecvRecommendResponse:messageResp];
        }
    }
}

@end
