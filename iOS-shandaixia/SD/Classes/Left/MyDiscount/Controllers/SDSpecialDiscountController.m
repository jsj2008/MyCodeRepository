//
//  SDSpecialDiscountController.m
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDSpecialDiscountController.h"

#import "SDDiscountCell.h"
#import "SDSharedView.h"
#import "SDDiscount.h"
#import "SDLoginButton.h"
#import "SDSpecialDiscount.h"


@interface SDSpecialDiscountController ()<UITableViewDataSource,UITableViewDelegate,SDSharedViewDelegate>

@property (nonatomic, weak) UITableView *discountTableView;

//分享界面
@property (nonatomic, weak) SDSharedView *sharedView;




@end

@implementation SDSpecialDiscountController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"优惠券"];
    
    [self addLoanTableView];
    
    [self loadDiscount];
    
}

- (void)loadDiscount{
    
    
    if (self.discountArray.count) {
        
        [self.discountTableView reloadData];
        
    }else{
        
        [self noContentUIWithImageNamed:@"no_discount"];
    }
    
}

- (void)addLoanTableView{
    
    UITableView *discountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    discountTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.discountTableView = discountTableView;
    discountTableView.backgroundColor = self.view.backgroundColor;
    discountTableView.delegate = self;
    discountTableView.dataSource = self;
    
    [self.view addSubview:discountTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.discountArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDDiscountCell *cell = [SDDiscountCell cellWithTableView:tableView];
    
    cell.specialDiscount = self.discountArray[indexPath.section];
    cell.selectedButton.hidden = NO;
    
    if (indexPath.section == self.selectedIndex) {
        
        cell.selectedButton.selected = YES;
    }else{
    
        cell.selectedButton.selected = NO;
    }
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 270 * SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if ([self.delegate respondsToSelector:@selector(sprcialDiscountDidClicked:selectedIndex:)]) {
        
        [self.delegate sprcialDiscountDidClicked:self.discountArray[indexPath.section] selectedIndex:indexPath.section];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}




- (void)noContentUIWithImageNamed:(NSString *)named{
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:named]];
    [imageView sizeToFit];
    imageView.centerX = SCREENWIDTH/2;
    imageView.y = 304 * SCALE;
    [self.view addSubview:imageView];
    
    //    [self.view addSubview:noView];
    
//    CGFloat actionW = 236 * SCALE;
//    CGFloat actionX = (SCREENWIDTH - actionW)/2;
//    CGFloat actionY = CGRectGetMaxY(imageView.frame) + 60 * SCALE;
//    CGFloat actionH = 78 * SCALE;
//    
    
}

@end
