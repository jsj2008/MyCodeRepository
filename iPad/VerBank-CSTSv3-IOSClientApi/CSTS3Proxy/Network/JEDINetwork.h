//
//  JEDINetwork.h
//  JEDI-IOSClientApi-Socket
//
//  Created by felix on 7/9/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// JEDINetwork 是用于客户端与服务器端通讯的类, 它主要是包装了 GCDAsyncSocket 对象。
// 
// 其主要功能有:
//
//    1, 创建网络连接，并实现数据的发送和接收；
//
//    2, 创建单独的线程，处理发送和接收数据；
//
//    3, 压缩发送数据包，和解压缩收到的数据包；
//
//    4, 告知使用者，网络处理的错误和异常；(NSNotificationCenter)
//
#ifndef JEDI_NETWORK_STATE_CHANGED
#define JEDI_NETWORK_STATE_CHANGED @"JEDINetworkStateChanged"
#endif

#ifndef JEDI_NETWORK_DELEGATE_QUEUE
#define JEDI_NETWORK_DELEGATE_QUEUE @"JEDINetworkDelegateQueue"
#endif



#ifndef JEDI_NETWORK_STATE
#define JEDI_NETWORK_STATE
//
// network state
//
#define JEDI_NETWORK_STATE_NONE             0    // 没有初始化 Socket
#define JEDI_NETWORK_STATE_INITIALIZED      1    // 已经初始化 Socket
#define JEDI_NETWORK_STATE_CONNECTING       10   // 网络建立连接中...
#define JEDI_NETWORK_STATE_CONNECTED        11   // 网络已经建立连接
#define JEDI_NETWORK_STATE_SEND_CHECK       12   // 发送 precheckBuf / connectType
#define JEDI_NETWORK_STATE_SEND_RSAKEY      13   // 发送 RSA Modulus / PublicExponent
#define JEDI_NETWORK_STATE_GET_AES_KEY      15   // 等待获取 AES KEY
#define JEDI_NETWORK_STATE_INIT_FINISHED    16   // 网络初始化完成，与服务器验证、交换密码成功
#define JEDI_NETWORK_STATE_DISCONNECTING    20   // 网络断开连接中...
#define JEDI_NETWORK_STATE_DISCONNECTED     21   // 网络已经断开连接
#endif



#ifndef JEDI_NETWORK_TAG
#define JEDI_NETWORK_TAG
//
// tag for writing
//
#define JEDI_NWTAG_WRITE_DEFAULT            0
#define JEDI_NWTAG_WRITE_NET_CHECK          1
#define JEDI_NWTAG_WRITE_NET_CTYPE          2
#define JEDI_NWTAG_WRITE_RSA_KEY            3

#define JEDI_NWTAG_WRITE_HEADER             10
#define JEDI_NWTAG_WRITE_TICK               30
#define JEDI_NWTAG_WRITE_MSGBODY            31
//
// tag for reading
//
#define JEDI_NWTAG_READ_DEFAULT             0
#define JEDI_NWTAG_READ_HEADER              10
#define JEDI_NWTAG_READ_BODY                20
#define JEDI_NWTAG_READ_TESTBODY            30
//
// size for reading
//
#define JEDI_NWSIZE_READ_HEADER             8
#define JEDI_NWSIZE_READ_TESTBODY           3*128
#endif



#ifndef JEDI_NETWORK_DEFAULT_CONFIG
#define JEDI_NETWORK_DEFAULT_CONFIG
#define JEDI_DEFAULT_CSTS_IP    @"192.168.0.55" // 默认使用 IP
#define JEDI_DEFAULT_CSTS_PORT  3543            // 默认使用 Port
#define JEDI_DEFAULT_TIMEOUT    30              // 默认超时 (秒)
#endif



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface JEDINetwork : NSObject

#pragma mark Initialize

- (id)          init;
- (id)          initNetworkWithAddress:(NSString *)ip andPort:(NSInteger) port;

#pragma mark Configration

- (void)        setTimeout:(NSTimeInterval) time;
- (void)        setNetworkDelegate:(id) delegate;
- (void)        setNetworkAddress:(NSString *)ip andPort:(NSInteger) port;

- (BOOL)        isConnected;
- (NSInteger)   getNetworkState;

#pragma mark Connect/Disconnect

- (BOOL)        connectToServer;
- (BOOL)        connectToServerWithAddress:(NSString *)ip andPort:(NSInteger) port;

- (BOOL)        disconnectFromServer;
- (BOOL)        disconnectAfterReadingAndWritting;

#pragma mark Write

- (BOOL)        writeData:(NSData *) data;
- (BOOL)        writeData:(NSData *) data withType:(int) type;

#pragma mark Init/Read Setting

- (void)        sendInitNetworkWithType:(int) type;
- (void)        sendRsaPublicKey;

- (void)        startToReadHeader;      // Normally, we start to read message from server.
- (void)        startToReadTestBody;    // In case of network testing, we start to read test body from server.
- (void)        startToReadBodyWithSize:(int) size;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol JEDINetworkDelegate
@optional

- (void)        onReadMessageBody:(NSData *) data;
- (void)        onNetworkStateChanged:(NSInteger) state;

@end
