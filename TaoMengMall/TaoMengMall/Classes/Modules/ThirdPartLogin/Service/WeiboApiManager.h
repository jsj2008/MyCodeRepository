//
//  WeiboApiManager.h
//  BabyDaily
//
//  Created by marco on 8/24/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeiboSDK/WeiboSDK.h>

@protocol WeiboApiManagerDelegate <NSObject>

@optional
- (void)managerDidRecvSendMessageReq:(WBSendMessageToWeiboRequest *)request;
- (void)managerDidRecvAuthorizeReq:(WBAuthorizeRequest *)request;
- (void)managerDidRecvPaymentReq:(WBPaymentRequest *)request;
- (void)managerDidRecvRecommendReq:(WBSDKAppRecommendRequest *)request;

- (void)managerDidRecvSendMessageResponse:(WBSendMessageToWeiboResponse *)response;
- (void)managerDidRecvAuthorizeResponse:(WBAuthorizeResponse *)response;
- (void)managerDidRecvPaymentResponse:(WBPaymentResponse *)response;
- (void)managerDidRecvRecommendResponse:(WBSDKAppRecommendResponse *)response;


@end

@interface WeiboApiManager : NSObject<WeiboSDKDelegate>

@property (nonatomic, weak) id<WeiboApiManagerDelegate> delegate;

@property (nonatomic, strong) NSString *appId;

@property (nonatomic, strong) NSString *redirectURI;

+ (BOOL)registerApp:(NSString*)appId redirectURI:(NSString*)redirectURI;

+ (instancetype)sharedManager;

+ (BOOL)isWeiboInstalled;

+ (BOOL)sharedMessageToSinaWeibo:(nullable NSString *) message
                           image:(nonnull UIImage *)image;

+ (BOOL)sharedMessageToSinaWeibo:(nullable NSString *) message
                          webURL:(nonnull NSString *)webURL
                           title:(nonnull NSString*)title
                      coverImage:(nullable UIImage*)coverImage;

+ (BOOL)sharedMessageToSinaWeibo:(nullable NSString *) message
                        videoURL:(nonnull NSString *)videoURL
                  videoStreamURL:(nullable NSString*)streamURL
                           title:(nonnull NSString*)title
                      coverImage:(nullable UIImage*)coverImage;

+(void)getWeiBoFriendsListOfUser:(nonnull NSString*)userId
                     accessToken:(nonnull NSString*)token
                      completion:(nullable void(^)( id _Nullable result, NSError *_Nullable error))completion;
@end
