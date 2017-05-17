//
//  AccountCapitalStatus.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocBasicStruct.h"

@interface AccountCapitalStatus : CommDocBasicStruct

@property double var_E;
@property double var_E0;
@property double var_M2;
@property double var_M_O;
@property double var_M_c1;
@property double var_M_c2;
@property double var_M_L;
@property double var_M0_O;
@property double var_M0_c1;
@property double var_M0_c2;
@property double var_M0_L;
@property double var_E0_L;
@property double var_E0_O;
@property double var_E0_c1;
@property double var_E0_c2;
@property double var_delta_E0_O;
@property double var_delta_E0_c1;
@property double var_delta_E0_c2;
@property double var_delta_E0_L;
@property double var_delta_E_1;
@property double var_delta_E_2;

@property double var_risk_O_1;
@property double var_risk_C1_1;
@property double var_risk_C2_1;
@property double var_risk_L_1;
@property double var_risk_O_2;
@property double var_risk_C1_2;
@property double var_risk_C2_2;
@property double var_risk_L_2;

@property double var_maxMarginSum;
@property double var_usableMargin_4open;
@property double var_withdrawableMoney;

@property int var_risk1_Level;
@property int var_risk2_Level;

@end
