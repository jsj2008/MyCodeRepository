//
//  YAXGuideCollectionViewController.m
//  Lottery01
//
//  Created by 余艾星 on 16/3/8.
//  Copyright © 2016年 余艾星. All rights reserved.
//

#import "YAXGuideCollectionViewController.h"
#import "YAXGuideCell.h"
#import "YPSideController.h"
#import "YPLeftMenuController.h"
#import "YPReusableControllerConst.h"
#import "ViewController.h"
#import "YPBaseNavigationController.h"

@interface YAXGuideCollectionViewController ()

//保存背景图片
@property (nonatomic,strong) NSArray *backGroundImage;

@property (nonatomic,weak) UIImageView *blxImgView;

// 足球/篮球
@property (nonatomic,weak) UIImageView *adImgView;

// 大文字
@property (nonatomic,weak) UIImageView *bigTextView;

//小文字
@property (nonatomic,weak) UIImageView *smallTextView;

@end

@implementation YAXGuideCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - 懒加载背景图片
- (NSArray *)backGroundImage{

    if (_backGroundImage == nil) {
        
        _backGroundImage = @[
                             [UIImage imageNamed:@"1"],
                             [UIImage imageNamed:@"2"],
                             [UIImage imageNamed:@"3"],
                             
                             ];
        
    }
    
    return _backGroundImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    // Register cell classes
    [self.collectionView registerClass:[YAXGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;

    
    //添加数据
    [self setData];
    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
}

#pragma mark - 设置布局对象
- (instancetype)init{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    flowLayout.minimumLineSpacing = 0;
    
    return [super initWithCollectionViewLayout:flowLayout];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.backGroundImage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YAXGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.backgroundImage = self.backGroundImage[indexPath.item];
    
    if (indexPath.row == 2) {
        
        [cell.enterButton addTarget:self action:@selector(enterButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.enterButton.hidden = NO;
    }else{
    
        cell.enterButton.hidden = YES;
    }
    
    return cell;
}

#pragma mark - 进入主界面按钮被点击事件
- (void)enterButtonDidClick:(UIButton *)sender{
    
    if (self.dismiss) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
    
        YPBaseNavigationController *navVc = [[YPBaseNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        YPLeftMenuController *leftVc = [[YPLeftMenuController alloc] init];
        YPSideController *sideVc = [[YPSideController alloc] initWithContentViewController:navVc leftMenuViewController:leftVc];
        //    sideVc.backgroundImage = [UIImage imageNamed:@"mine_sidebar_background"];
        
        
        //        sideVc.myDelegate = self;
        [UIApplication sharedApplication].keyWindow.rootViewController = sideVc;
        
    }
}


//设置数据
- (void)setData{

    // 波浪线
    UIImageView *blxImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    
    blxImgView.x = -200;
    
    [self.collectionView addSubview:blxImgView];
    
    // 足球/篮球
    UIImageView *adImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    
    [self.collectionView addSubview:adImgView];
    
    self.adImgView = adImgView;
    
    // 大文字
    UIImageView *bigTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    
    bigTextView.y = self.collectionView.height * 0.7;
    
    [self.collectionView addSubview:bigTextView];
    
    self.bigTextView = bigTextView;
    
    
    // 小文字
    UIImageView *smallTextView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    
    smallTextView.y = self.collectionView.height * 0.8;
    
    [self.collectionView addSubview:smallTextView];
    
    self.smallTextView = smallTextView;


}

#pragma mark 代理方法,减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    CGFloat page = contentOffsetX/scrollView.width;
    
    //添加动画的准备工作
    
    CGFloat moveX = contentOffsetX;
    
    if (contentOffsetX > self.adImgView.x + scrollView.width - 1) {
        
        moveX = contentOffsetX + scrollView.width;
        
    }else if(contentOffsetX < self.adImgView.x - scrollView.width + 1){
        
        moveX = contentOffsetX - scrollView.width;
    }
    
    self.adImgView.x = moveX;
    
    
    // 1.3 换图片
    self.adImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%@", @(page + 1)]];
    self.bigTextView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideLargeText%@",@(page + 1)]];
    self.smallTextView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideSmallText%@",@(page + 1)]];
    
    //添加动画
    [UIView animateWithDuration:0.5 animations:^{
        
        //移动图片
        self.adImgView.x = contentOffsetX;
        self.bigTextView.x = contentOffsetX;
        self.smallTextView.x = contentOffsetX;
        
    }];
    
}

@end






















