//
//  CertificateManager.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CertificateManager : NSObject

+ (CertificateManager *)getInstance;

- (void)showCertificateView;

- (Boolean)checkCertificateState;


@end
