//
//  SDLoanProtocolController.m
//  SD
//
//  Created by 余艾星 on 17/3/10.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDLoanProtocolController.h"
#import "SDAccount.h"

@interface SDLoanProtocolController ()

@end

@implementation SDLoanProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"借款协议"];

    [self agrreeButtonDidClicked];
    
}

- (void)agrreeButtonDidClicked{
    
    [SDAccount getAgreementWith:self.loan bankCard:self.defaultBankCard finishedBlock:^(id object) {
        
        if (object) {
            
            NSString *urlString = object;
            
            
            [self addWebViewWithUrlString:urlString];
            
        }
        
    } failuredBlock:^(id object) {
        
    }];
    
}

@end
