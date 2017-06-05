//
//  SDProvinceController.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDProvinceController.h"
#import "SDProvinceView.h"
#import "SDProvince.h"
#import "SDCityController.h"

@interface SDProvinceController ()<SDProvinceViewDelegate>

@property (nonatomic, strong) NSArray *provinceArray;

@end

@implementation SDProvinceController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self createNavBarWithTitle:@"认证"];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    
    [self addUI];
    
    [self getData];
    
}

- (void)addUI{
    
    SDProvinceView *provinceView = [[SDProvinceView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    provinceView.delagate = self;
    
    [self.view addSubview:provinceView];
}

- (void)getData{

    [SDProvince getProvinceWithType:self.channelType finishedBlock:^(id object) {
        
        self.provinceArray = object;
        
        
    } failuredBlock:^(id object) {
        
    }];
}

- (void)provinceButtonDidClicked:(NSString *)provinceName{

    if (self.provinceArray != nil) {
        
        FDLog(@"provinceName - %@",provinceName);
        
        for (SDProvince *p in self.provinceArray) {
            
            if ([p.province isEqualToString:provinceName]) {
                
                SDCityController *cityCon = [[SDCityController alloc] init];
                
                cityCon.city = p.list;
                cityCon.channelType = self.channelType;
                
                [cityCon addLoanTableView];
                [cityCon.tableView reloadData];
                
                [self.navigationController pushViewController:cityCon animated:YES];
            }
        }
        
        
    }
}

@end
