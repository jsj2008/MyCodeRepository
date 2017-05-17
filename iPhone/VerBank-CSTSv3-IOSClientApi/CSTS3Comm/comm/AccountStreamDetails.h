//
//  AccountStreamDetails.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "MoneyAccountStream.h"

@interface AccountStreamDetails : MoneyAccountStream

jsonValueInterface(Aeid,     NSString *)
jsonValueInterface(Balance,  double)

@end
