//
//  SDLoanProcedureBankCardController.h
//  SD
//
//  Created by 余艾星 on 17/3/7.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "YPCustomNavBarController.h"
@class SDBankCard;

@protocol SDLoanProcedureBankCardControllerDelegate <NSObject>

@optional
- (void)loanProcedureBankCardDidClicked:(SDBankCard *)bankCard;

@end

@interface SDLoanProcedureBankCardController : YPCustomNavBarController

@property (nonatomic, strong) NSMutableArray *cardArray;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) id<SDLoanProcedureBankCardControllerDelegate> delegate;

//- (void)dissmiss;
- (void)showWithParentController:(UIViewController *)controller;

@end
