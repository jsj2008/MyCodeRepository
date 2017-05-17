//
//  CertificatePwdInputContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CertificatePwdInputContentView.h"
#import "LangCaptain.h"
#import "CertificateManager.h"
#import "ShowAlertManager.h"
#import "CheckUtils.h"
#import "ClientAPI.h"
#import "UserLogin.h"
#import "APIDoc.h"
#import "IosLogic.h"
#import "TradeApi.h"
#import "CertificateSaveData.h"
#import "CertificateUtil.h"
#import "ZLKeyboardView.h"
#import "UIColor+CustomColor.h"

@interface CertificatePwdInputContentView() <ZLKeyboardDelegate>

@end

@implementation CertificatePwdInputContentView

@synthesize titleLabel;
@synthesize backButton;

@synthesize certificateLabel;
@synthesize passwordField;
@synthesize downloadButton;
@synthesize textView;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"CertificateManagement"]];
        [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    
    [backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    
    [certificateLabel setText:[[LangCaptain getInstance] getLangByCode:@"CertificatePasswordSet"]];
    [downloadButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Download"]
                    forState:UIControlStateNormal];
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"CertificatePasswordChangeTextView"]];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [textView setText:tempString];
    [textView setEditable:false];
    [self setBackgroundColor:[UIColor grayColor]];
    
    [backButton addTarget:self
                   action:@selector(backAction)
         forControlEvents:UIControlEventTouchUpInside];
    
    [downloadButton addTarget:self
                       action:@selector(downLoadCA)
             forControlEvents:UIControlEventTouchUpInside];
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLoginNumber];
    self.passwordField.inputView = inputView;
    [TextFieldUtil removeShortCutItem:self.passwordField];
    [self.passwordField  setDelegate:(id)inputView];
    [inputView setKeyboardDelegate:self];
    [self.passwordField setSecureTextEntry:true];
}

- (void)resetContentView {
    [passwordField setText:@""];
}

#pragma action
- (void)backAction {
    [[CertificateManager getInstance] showCertificateView];
}

- (void)downLoadCA {
    NSString *userPingString = self.passwordField.text;
    if (userPingString == nil || [userPingString isEqualToString:@""]) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"CertificateCanNotNull"]
                                                             delegate:nil];
        return;
    }
    
    Boolean PinIsRight = [CheckUtils isPwdLegal:userPingString accountID:[@([[ClientAPI getInstance] accountID]) stringValue]];
    
    if (!PinIsRight) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordIllegal"]
                                                             delegate:nil];
        return;
    }
    
    if (![self checkCaDownloadTimer]) {
        return;
    }
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"CALoading"]
                                                          onView:[self getMainView]];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 不成功， 不需要查询存在
        if ([self queryRight] == CA_TRADE_SUCCEED) {
            if ([self requestCA] == CA_TRADE_SUCCEED) {
                [self installComplete];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            
        });
    });
}

- (Boolean)checkCaDownloadTimer {
    UserLogin *userLogin = [[APIDoc getUserDocCaptain] getUserLogin:[[ClientAPI getInstance] aeid]];
    if (userLogin != nil && [userLogin getCaDownloadNumber] >= [userLogin getCaLimitNumber]) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"CaDownloadTimeErr"]
                                                             delegate:nil];
        return false;
    }
    return true;
}

- (UIView *)getMainView {
    return [[[[IosLogic getInstance] uiWindow] rootViewController] view];
}

- (int)queryRight {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ShowAlertManager getInstance] hidenAlertWaitView];
        [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"RightQuery"]
                                                              onView:[self getMainView]];
    });
    
    TradeResult_CAFnStatus *result = [[TradeApi getInstance] getFnStatus2DeviceID:[[CertificateSaveData getInstance] GUID]
                                                                         venderID:@"M"];
    int returnCode = -1;
    FnStatus *fnStatus = [result fnStatus];
    if (fnStatus != nil && fnStatus.getReturnCode == CA_TRADE_SUCCEED) {
        int message = [fnStatus getReturnMessage];
        NSString *returnMessage = [@(message) stringValue];
        int code1 = [[returnMessage substringWithRange:NSMakeRange(0,1)] intValue];
        
        switch (code1) {
            case CA_FNSTATUS_REQUEST_DONOT:
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                       andMessage:[[LangCaptain getInstance] getLangByCode:@"Requestdonot"]
                                                                         delegate:nil];
                });
                break;
            case CA_FNSTATUS_REQUEST_MAKECSR:
                returnCode = [self onRequestCert:true fnStatus:fnStatus];
                break;
            case CA_FNSTATUS_REQUEST_NOTCSR:
                returnCode = [self onRequestCert:false fnStatus:fnStatus];
                break;
            default:
                break;
        }
    } else {
        NSString *errMsg = [[LangCaptain getInstance] getLangByCode:@"CARightQueryFailed"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                               andMessage:errMsg
                                                                 delegate:nil];
        });
    }
    return returnCode;
}

- (int)onRequestCert:(Boolean)makeCSR fnStatus:(FnStatus *)fnStatus {
    
    NSString *userPingString = self.passwordField.text;
    if (makeCSR) {
        int rstate = [CertificateUtil makeCSR:userPingString];
        if (rstate != CA_TRADE_SUCCEED) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:@"MakeCSRFailed"]
                                                                     delegate:nil];
            });
            return -1;
        }
    } else {
        NSString *csr = [fnStatus getPreviousCA];
        char *csrChar = (char *)[csr UTF8String];
        
        char *userPinChar = (char *)[userPingString UTF8String];
        
        NSString *cnString = [NSString stringWithFormat:@"CN=%@", [[ClientAPI getInstance]aeid]];
        char *cnChar = (char *)[cnString UTF8String];
        
        [[CertificateSaveData getInstance] setUserPin:userPinChar];
        [[CertificateSaveData getInstance] setKeySet:(char *)[[CertificateUtil getKeySet] UTF8String]];
        [[CertificateSaveData getInstance] setCsr:csrChar];
        [[CertificateSaveData getInstance] setCN:cnChar];
        [[CertificateSaveData getInstance] saveConfigData];
    }
    return CA_TRADE_SUCCEED;
}

- (int)requestCA {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ShowAlertManager getInstance] hidenAlertWaitView];
        [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"RequestCA"]
                                                              onView:[self getMainView]];
    });
    NSString *userPin = [NSString stringWithCString:[[CertificateSaveData getInstance] getUserPin] encoding:NSUTF8StringEncoding];
    NSString *csr = [NSString stringWithCString:[[CertificateSaveData getInstance] getCsr] encoding:NSUTF8StringEncoding];
    NSString *urlencodedString = [CertificateUtil encodeString:csr];
    TradeResult_CACert *result = [[TradeApi getInstance] requestApplyCertDeviceID:[[CertificateSaveData getInstance] GUID]
                                                                         venderID:@"M"
                                                                         password:userPin
                                                                              csr:urlencodedString];
    
    int ret = -1;
    
    if (result != nil && [result succeed] && [result resultCode] == 0) {
        // 成功
        ret = [CertificateUtil importCerticate:[result context]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ret == CA_TRADE_SUCCEED) {
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:@"CertificateImportSuccess"]
                                                                     delegate:nil];
            } else {
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"CertificateImportFailed"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"TWCA_ERROR_%d", ret]]
                                                                     delegate:nil];
            }
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"CertificateApplyFailed"]
                                                               andMessage:[[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"MGW_RESULT_%d", [result resultCode]]]
                                                                 delegate:nil];
        });
    }
    
    return ret;
}

- (void)installComplete {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ShowAlertManager getInstance] hidenAlertWaitView];
        [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"InstallCA"]
                                                              onView:[self getMainView]];
    });
    TradeResult_CACert *result = [[TradeApi getInstance] certInstallCompleteDevice:[[CertificateSaveData getInstance] GUID]
                                                                          venderID:@"M"];
    
    if (![result succeed]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                               andMessage:[[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"MGW_RESULT_%d", [result resultCode]]]
                                                                 delegate:nil];
        });
        
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CertificateManager getInstance] showCertificateView];
    });
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[TradeApi getInstance] updateCADownloadTimer];
    });
}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    return true;
}
- (void)textFiledBeginEdit:(UITextField *)textField {}
- (void)textFieldDidEdit:(UITextField *)textField {}
- (void)textFieldEndEdit:(UITextField *)textField {}

@end
