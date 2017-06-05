//
//  TKAddressBook.h
//  SD
//
//  Created by 余艾星 on 17/3/1.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKAddressBook : NSObject

@property NSInteger sectionNumber;
@property NSInteger recordID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *tel;

@end
