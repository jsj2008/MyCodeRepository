#ifndef TWCA_cTWCAMobileCrypto_H
#define TWCA_cTWCAMobileCrypto_H

#ifdef __cplusplus

extern "C" {
#endif
    //component info
    void getVersion(char buffer[20]);
    int getHashType();
    int getDeviceDependent();
    //MakeCSR
    int MakeCSRc(int KeySize, char *CN, char *UserPIN, char *retCSR, char *retKeySet, int retKeySetSize);
    int MakeCSR(int KeySize, char *CN, char *UserPIN, char *retCSR, char *retKeySet, int retKeySetSize);
    int MakePKCS10(unsigned char *N,int NL, unsigned char *E,int EL, unsigned char *D,int DL, unsigned char *P,int PL, unsigned char *Q,int QL, unsigned char *DP,int DPL, unsigned char *DQ,int DQL, unsigned char *QP,int QPL, int KeySize, char *CN, char *UserPIN, char *retCSR, char *retKeySet, int retKeySetSize);
    //ImportCert
    int ImportCert(char *b64Keydata, char *UserPIN, char *b64Cert, char *retKeySet, int retKeySetSize);
    //LoadRSAKey
    int LoadRSAKey(char *b64data, char *pwd);
    int ResetKey();
    int getCN(char *buf);
    int getSN(char *buf);
    int getHexSN(char *buf);
    int getNotbefore(char *buf);
    int getNotafter(char *buf);
    int getCert(char *buf);
    int getSubject(char buf[1024]);
    int getIssuer(char buf[1024]);
    //Sign
    int PKCS1Sign(unsigned char *source, int len);
    int PKCS7Sign(unsigned char *source, int source_len, char *signature, int signBuf_len, int flag);
    int getSignature(char *buf);
    //Verify
    int PKCS1Verify(unsigned char *source, int source_len, char *base64Signature, char *base64Cert);
    int ParseX509Cert(char *base64Cert);
    int ChangePIN(char *b64data, char *oldPIN, char *newPIN, char *retKeySet, int retKeySetSize);
    //Session Enc/Dec
    int generateTwcaKeyPair(int keySize);
    int getTwcaPublicKey(char buf[2048]);
    int getTwcaPrivateKey(char buf[4096]);
    int generateSessionKey(char *base64PublicKey);
    int getSessionKey(char buf[1024]);
    int importSessionKey(char *base64PrivateKey, char *base64EncSessionKey);
    int sessionEncrypt(unsigned char* plain, int plainSize);
    int getSessionEncryptData(char buf[4096]);
    int sessionDecrypt(char* base64EncData);
    int getSessionDecryptData(unsigned char plain[4096], int *plainSize);
    //hash
    void md5(unsigned char *input, int ilen, unsigned char output[16]);
    void sha1(unsigned char *input, int ilen, unsigned char output[20]);
    void sha2(const unsigned char *input, size_t ilen, unsigned char output[32], int is224);
    //for test
    int MakeCsrSha1(int KeySize, char *CN, char *UserPIN, char *retCSR, char *retKeySet, int retKeySetSize);
    int MakeCsrSha256(int KeySize, char *CN, char *UserPIN, char *retCSR, char *retKeySet, int retKeySetSize, int isSHA256);
    int PKCS1SignSha1(unsigned char *source, int len);
    int PKCS1SignSha256(unsigned char *source, int len);

    
    //ios Device ID
    int getDeviceKey(unsigned char *deviceKey);
    int setDeviceID(char *deviceID);
    int ConvertCert(char *keySet, char *pin, char *retKeySet, int retKeySetSize);
    void setDeviceDependent(int depend);
    int isIosVersionLessThan(char *targetVersion);

    //Time Zone
    int getNotbeforeLocalTime(int timeZone, char *buf);
    int getNotafterLocalTime(int timeZone, char *buf);
    int TWCASystemTimeZone;
    
#ifdef __cplusplus
}
#endif
#endif
