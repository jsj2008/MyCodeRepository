//
//  ReOrderTableView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/24.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReOrderTableView : UIView

@property (nonatomic,strong) UITableView *tableView;

-(instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects;
-(instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder;

@end
