//
//  FDAboutUsController.m
//  FuDai
//
//  Created by 余艾星 on 16/6/18.
//  Copyright © 2016年 fudai. All rights reserved.
//

#import "SDAboutUsController.h"
#import "SDAboutSDXController.h"
#import "YAXGuideCollectionViewController.h"

#define FONT (SCREENWIDTH>370?16:14)

@interface SDAboutUsController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation SDAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createNavBarWithTitle:@"关于我们"];
    
    //修改状态栏颜色 UIStatusBarStyleDefault
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithBgColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    //底部视图
    [self addBottomView];
    [self addLoanTableView];
    
    //添加头部视图
    [self addHeaderView];
    
}

- (void)addLoanTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = FDColor(240, 240, 240);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
    
    
}

- (void)addHeaderView{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, (396.0/750.0)*SCREENWIDTH)];
    
    headerView.backgroundColor = FDColor(242, 242, 242);
    
    CGFloat imageW = (170/750.0)*SCREENWIDTH;
    
    //图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageW, imageW)];
    
    imageView.center = CGPointMake(headerView.centerX, headerView.centerY - 20);
    
    imageView.image = [UIImage imageNamed:@"icon_app"];
    
//    imageView.layer.cornerRadius = imageW/2;
//    imageView.clipsToBounds = YES;
    
    [headerView addSubview:imageView];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *oldVersion = infoDict[@"CFBundleShortVersionString"];
    
    UILabel *versionLabel = [UILabel labelWithText:[NSString stringWithFormat:@"版本：%@",oldVersion] textColor:FDColor(51, 51, 51) font:FONT textAliment:NSTextAlignmentCenter];

    
    versionLabel.size = CGSizeMake(imageView.width, 30 * SCALE);
    
    versionLabel.center = CGPointMake(SCREENWIDTH/2, imageView.centerY + imageView.height/2 + 30 * SCALE);
    
    [headerView addSubview:versionLabel];
    
    self.tableView.tableHeaderView = headerView;
    
    
}

- (void)addBottomView{

    UIImageView *bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_ text"]];
    
    bottomImageView.y = SCREENHEIGHT - 300 * SCALE;
    bottomImageView.centerX = SCREENWIDTH/2;
    
    [self.tableView addSubview:bottomImageView];
    
    
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //1144099528 @"itms-apps://itunes.apple.com/app/id1144099528"
        NSString *url = [[NSString alloc] initWithFormat:@"itms-apps://itunes.apple.com/app/id%@", [(NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"App Store Application Id"] copy]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    }else if (indexPath.row == 1) {
        
        YAXGuideCollectionViewController *guideController = [[YAXGuideCollectionViewController alloc] init];
        
        guideController.dismiss = YES;
        
        [self presentViewController:guideController animated:YES completion:nil];
        
        
    }else if (indexPath.row == 2) {
        
        [self.navigationController pushViewController:[[SDAboutSDXController alloc] init] animated:YES];
    }
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end

