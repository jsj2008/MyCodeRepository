//
//  YPCustomNavBarController.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/26.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPCustomNavBarController.h"


#define YPBackBtnColor [UIColor colorWithRed:0.20f green:0.43f blue:0.78f alpha:1.00f]

@interface YPCustomNavBarController () 

@property (nonatomic, copy) YPCustomNavBarControllerNormalBlock actionBlock;


@end

@implementation YPCustomNavBarController

#pragma mark - Override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.view bringSubviewToFront:self.navBarContainer];
}

#pragma mark - Public
- (void)createNavBarWithTitle:(NSString *)title titleColor:(UIColor *)color backImageNamed:(NSString *)named  backGroundColor:(UIColor *)backColor
{
    // 父容器
    UIView *navBarContainer = [[UIView alloc] init];
    self.navBarContainer = navBarContainer;
    [self.view addSubview:navBarContainer];
    navBarContainer.backgroundColor = backColor;
    navBarContainer.frame = CGRectMake(0, 0, YPScreenW, 64);
    //    navBarContainer.layer.masksToBounds = NO;
    //    navBarContainer.layer.shadowColor = YPBlackColor.CGColor;
    //    navBarContainer.layer.shadowOffset = CGSizeMake(0, 0.1);
    //    navBarContainer.layer.shadowOpacity = 0.5;
    //
    
    // 标题标签
    UILabel *navTitleLabel = [[UILabel alloc] init];
    [self.navBarContainer addSubview:navTitleLabel];
    navTitleLabel.backgroundColor = YPClearColor;
    navTitleLabel.textColor = color;
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.font = YPFontBold_17;
    navTitleLabel.text = title;
    navTitleLabel.yp_height = 44;
    navTitleLabel.yp_y = 20;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = navTitleLabel.font;
    attributes[NSForegroundColorAttributeName] = navTitleLabel.textColor;
    size = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    navTitleLabel.yp_width = size.width;
    navTitleLabel.yp_x = YPScreenW * 0.5 - navTitleLabel.yp_width * 0.5;
    
    // 左侧按钮(固定)
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navBarContainer addSubview:leftBtn];
    [leftBtn setImage:[UIImage imageNamed:named]  forState:UIControlStateNormal];
//    leftBtn.tintColor = YPBackBtnColor;
    leftBtn.frame = CGRectMake(0, 20, 44, 44);
    [leftBtn addTarget:self action:@selector(leftBtnDidTouch) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

#pragma mark - Public
- (void)createNavBarWithTitle:(NSString *)title {
    [self createNavBarWithTitle:title withRightTile:@"" andAction:nil];
}

- (void)createNavBarWithTitle:(NSString *)title
                withRightTile:(NSString *)rightTitle
                    andAction:(YPCustomNavBarControllerNormalBlock)actionBlock {
    // 父容器
    UIView *navBarContainer = [[UIView alloc] init];
    self.navBarContainer = navBarContainer;
    [self.view addSubview:navBarContainer];
    navBarContainer.backgroundColor = YPWhiteColor;
    navBarContainer.frame = CGRectMake(0, 0, YPScreenW, 64);
    //    navBarContainer.layer.masksToBounds = NO;
    //    navBarContainer.layer.shadowColor = YPBlackColor.CGColor;
    //    navBarContainer.layer.shadowOffset = CGSizeMake(0, 0.1);
    //    navBarContainer.layer.shadowOpacity = 0.5;
    //
    
    // 标题标签
    UILabel *navTitleLabel = [[UILabel alloc] init];
    [self.navBarContainer addSubview:navTitleLabel];
    navTitleLabel.backgroundColor = YPClearColor;
    navTitleLabel.textColor = FDColor(34, 34, 34);
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.font = YPFontBold_17;
    navTitleLabel.text = title;
    navTitleLabel.yp_height = 44;
    navTitleLabel.yp_y = 20;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = navTitleLabel.font;
    attributes[NSForegroundColorAttributeName] = navTitleLabel.textColor;
    size = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    navTitleLabel.yp_width = size.width;
    navTitleLabel.yp_x = YPScreenW * 0.5 - navTitleLabel.yp_width * 0.5;
    
    // 左侧按钮(固定)
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navBarContainer addSubview:leftBtn];
    [leftBtn setImage:[UIImage imageNamed:@"icon_white_move_normal"] forState:UIControlStateNormal];
    leftBtn.tintColor = YPBackBtnColor;
    leftBtn.frame = CGRectMake(0, 20, 44, 44);
    [leftBtn addTarget:self action:@selector(leftBtnDidTouch) forControlEvents:UIControlEventTouchUpInside];
    
    // bottomLine
    UIView *bottomLine = [[UIView alloc] init];
    [self.navBarContainer addSubview:bottomLine];
    bottomLine.backgroundColor = FDColor(240, 240, 240);
    bottomLine.frame = CGRectMake(0, self.navBarContainer.yp_height - 0.5, self.navBarContainer.yp_width, 0.5);
    
    if (![rightTitle isEqualToString:@""]) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.titleLabel.font = ZLNormalFont(28 * SCALE);
        [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [self.navBarContainer addSubview:rightBtn];
        [rightBtn addTarget:self action:@selector(rightBtnDidTouch) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitleColor:SDBlackColor forState:UIControlStateNormal];
        rightBtn.frame = CGRectMake(SCREENWIDTH - 44, 20, 44, 44);
        _actionBlock = actionBlock;
    }
}

#pragma mark - Private
- (void)leftBtnDidTouch {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnDidTouch {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

- (void)noContentUIWithImageNamed:(NSString *)named{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:named]];
    [imageView sizeToFit];
    imageView.centerX = SCREENWIDTH/2;
    imageView.y = 304 * SCALE;
    [self.view addSubview:imageView];
}


@end
