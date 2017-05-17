//
//  JEDISecret.m
//  JEDI-IOSClientApi-Socket
//
//  Created by felix on 7/11/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "JEDISecret.h"
#import <openssl/rsa.h>
#import <openssl/err.h>
#import <openssl/pem.h>
#import <openssl/bio.h>

#import "DefAes.h"
#import "JEDIZip.h"
#import "JEDISystem.h"

static JEDISecret *msJEDISecret = NULL;

//-----------------------------------------------------------------------------------
@interface JEDISecret()
{
    RSA         * m_pRSAKey;    // RSA
    aes_context   m_myAesKey;
}

- (void) dealloc;

@end


//-----------------------------------------------------------------------------------
@implementation JEDISecret

//-----------------------------------------------------------------------------------
+ (JEDISecret *) defaultSecret
{
    if(msJEDISecret == NULL){
        msJEDISecret = [[JEDISecret alloc] init];
    }
    
    return msJEDISecret;
}

//-----------------------------------------------------------------------------------
- (id) init
{
    self = [super init];
    
    if(self != NULL)
    {
        m_pRSAKey = RSA_generate_key(2048, RSA_F4, NULL, NULL);
        //        m_pRSAKey = RSA_generate_key_ex(1024, RSA_F4, NULL, NULL);
    }
    
    return self;
}

//-----------------------------------------------------------------------------------
- (void) dealloc
{
    RSA_free(m_pRSAKey);
    m_pRSAKey = NULL;
}

//-----------------------------------------------------------------------------------
- (NSString *)getRSAPublicKey
{
    RSA* pubRsa = RSAPublicKey_dup(m_pRSAKey);
    
    NSString *strTemp = [self readBufferFromRSA:pubRsa];
    
    NSString *rlt1 = [self formatWithRsaPublicString:strTemp];
    
    NSString *esStr = @"";
    for(NSInteger i=0; i < pubRsa->e->dmax; i++){
        esStr = [NSString stringWithFormat:@"%@%x", esStr, pubRsa->e->d[i]];
    }
    
    NSString *rsStr = [[NSString alloc] initWithFormat:@"%@;%@", rlt1, esStr];
    
    RSA_free(pubRsa);
    return rsStr;
}

- (NSString *)readBufferFromRSA:(RSA *)pubRsa
{
    FILE* fTempFile = tmpfile();
    //    PEM_write_RSAPublicKey(ffTest, pubRsa);
    
    JEDI_SYS_Try{
        if(fTempFile == NULL){
            NSLog(@"打开临时文件失败！");
        }
        
        if (RSA_print_fp(fTempFile, pubRsa, 0) != 1) {
            NSLog(@"RSA_print_fp failed!");
        }
        
        fseek(fTempFile, 0L, SEEK_END);
        long filesize = ftell(fTempFile);
        fseek(fTempFile,0L,SEEK_SET);
        
        char *buffer = (char *)malloc(filesize+1);
        memset(buffer, 0, filesize+1);
        
        fread(buffer, sizeof(char), filesize, fTempFile);
        
        fclose(fTempFile);
        NSMutableString *strTemp = [NSMutableString stringWithUTF8String:buffer];
        free(buffer);
        return strTemp;
    }
    JEDI_SYS_EndTry
    
}

- (NSString *)formatWithRsaPublicString:(NSString *)strTemp
{
    strTemp = [strTemp stringByReplacingOccurrencesOfString:@"Modulus" withString:@""];
    strTemp = [strTemp stringByReplacingOccurrencesOfString:@"Public-Key: (2048 bit)" withString:@""];
    strTemp = [strTemp stringByReplacingOccurrencesOfString:@"Exponent: 65537 (0x10001)" withString:@""];
    strTemp = [strTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    strTemp = [strTemp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    strTemp = [strTemp stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    return strTemp;
}

//-----------------------------------------------------------------------------------
- (BOOL)       setAESKeyWithData:(NSData *) nsData
{
    NSData *nsKey = [self decryptDataWithRSA:nsData];
    
    if(nsKey != NULL)
    {
        int setKeyResult = aes_set_key(&m_myAesKey, (unsigned char*)[nsKey bytes], 128);
        //NSLog(@"JEDISecret.setAESKey: setKeyResult = %d", setKeyResult);
        return (setKeyResult == 0);
    }
    
    return NO;
}

//-----------------------------------------------------------------------------------
- (NSData *)   encryptDataWithAES:(NSData *) nsData
{
    int nSize = (int)[nsData length];
    int nBlock = (nSize / aes_block_size) + 1;
    int nPadValue = (nSize % aes_block_size);
    
    nSize += (aes_block_size - nPadValue);
    nPadValue = nSize - (int)[nsData length];
    
    unsigned char srcBuffer[nSize];
    memset(srcBuffer, nPadValue, nSize);  // 0
    [nsData getBytes:srcBuffer];
    
    unsigned char toBuffer[nSize];
    //memset(toBuffer, nPadValue, nSize); // 0
    
    for(int i=0; i<nBlock; ++i)
    {
        unsigned char* subSrc = srcBuffer + (i * aes_block_size);
        unsigned char* subTo = (toBuffer + (i * aes_block_size));
        aes_encrypt(& m_myAesKey, subSrc, subTo);
    }
    
    NSData *rltData = [NSData dataWithBytes:toBuffer length:nSize];
    return rltData;
}

//-----------------------------------------------------------------------------------
- (NSData *)   decryptDataWithAES:(NSData *) nsData
{
    int nSize = [nsData length];
    NSLog(@"%d......", nSize);
    int nBlock = (nSize / aes_block_size);
    int nPadValue = (nSize % aes_block_size);
    
    if(nBlock == 0 || nPadValue > 0)
    {
        [JEDISystem log:@"JEDISecret.decryptDataWithAES, padding error."];
        return nil;
    }
    
//    unsigned char srcBuffer[nSize];
    unsigned char* srcBuffer = malloc(nSize);
    [nsData getBytes:srcBuffer];
    
    unsigned char* toBuffer = malloc(nSize);
//    unsigned char toBuffer[nSize];
    
//    NSLog(@"===%lu", sizeof(toBuffer));
//    NSLog(@"---%lu", sizeof(toBuffer1));
    
    memset(toBuffer, 0, nSize);
    
    for(int i=0; i<nBlock; ++i)
    {
        unsigned char* subSrc = (srcBuffer + (i * aes_block_size));
        unsigned char* subTo = (toBuffer + (i * aes_block_size));
        aes_decrypt(&m_myAesKey, subSrc, subTo);
    }
    
    nPadValue = (unsigned char)toBuffer[nSize-1];
    
    NSData *rltData = [NSData dataWithBytes:toBuffer length:(nSize - nPadValue)];
    free(toBuffer);
    free(srcBuffer);
    return rltData;
}

//-----------------------------------------------------------------------------------
- (NSData *)   encryptDataWithRSA:(NSString *) nsStr
{
    if(m_pRSAKey == NULL){
        return NULL;
    }
    
    int rasSize = RSA_size(m_pRSAKey);
    unsigned char toBuffer[rasSize];
    
    memset(toBuffer, 0, rasSize);
    
    RSA_public_encrypt([nsStr length], (const unsigned char *)[nsStr UTF8String], toBuffer, m_pRSAKey, RSA_PKCS1_PADDING);
    
    if (RSA_public_encrypt([nsStr length], (const unsigned char *)[nsStr UTF8String], toBuffer, m_pRSAKey, RSA_PKCS1_PADDING) < 0) {
        NSLog(@"加密失败");
        return NULL;
    }
    
    NSData* nsData = [[NSData alloc] initWithBytes:(const void*)(toBuffer) length:rasSize];
    return nsData;
}

//-----------------------------------------------------------------------------------
- (NSData *) decryptDataWithRSA:(NSData *) nsData
{
    //[JEDISecret PrintDataByByte:nsData];
    
    int rasSize = (int)[nsData length];
    //        int rasSize = RSA_size(m_pRSAKey);
    unsigned char toBuffer[rasSize];
    memset(toBuffer, 0, rasSize);
    
    int aesSize = RSA_private_decrypt((int)[nsData length], (const unsigned char *)[nsData bytes], toBuffer, m_pRSAKey, RSA_PKCS1_PADDING);
    
    if (aesSize < 0) {
        NSLog(@"解密失败");
        return NULL;
    }
    
    //[JEDISecret PrintBytes:toBuffer onSize:aesSize];
    
    NSData *rltData = [NSData dataWithBytes:toBuffer length:aesSize];
    return rltData;
}


@end
