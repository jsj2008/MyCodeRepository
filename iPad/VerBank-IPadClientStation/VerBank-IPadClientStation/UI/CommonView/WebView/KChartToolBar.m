//
//  KChartToolBar.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/9.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "KChartToolBar.h"
#import "IosLayoutDefine.h"

@interface KChartToolBar()

@end

@implementation KChartToolBar

@synthesize backButton;
@synthesize kChartTypeButton;
@synthesize cycleTypeButton;
@synthesize technologyTypeButton;
@synthesize clearAllButton;
@synthesize drawLineButton;
@synthesize addOrderButton;

@synthesize chooseView;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    backButton              = [[UIButton alloc] init];
    kChartTypeButton        = [[UIButton alloc] init];
    cycleTypeButton         = [[UIButton alloc] init];
    drawLineButton          = [[UIButton alloc] init];
    technologyTypeButton    = [[UIButton alloc] init];
    addOrderButton          = [[UIButton alloc] init];
    clearAllButton          = [[UIButton alloc] init];
    
    chooseView              = [[ToolBarChooseView alloc] init];
    chooseView.subChooseView = [[ToolBarChooseView alloc] init];
    
    [backButton             setBackgroundImage:[UIImage imageNamed:@"images/kChartImage/KChart01"] forState:UIControlStateNormal];
    [kChartTypeButton       setBackgroundImage:[UIImage imageNamed:@"images/kChartImage/KChart02"] forState:UIControlStateNormal];
    [cycleTypeButton        setBackgroundImage:[UIImage imageNamed:@"images/kChartImage/KChart03"] forState:UIControlStateNormal];
    [drawLineButton         setBackgroundImage:[UIImage imageNamed:@"images/kChartImage/KChart04"] forState:UIControlStateNormal];
    [technologyTypeButton   setBackgroundImage:[UIImage imageNamed:@"images/kChartImage/KChart05"] forState:UIControlStateNormal];
    [addOrderButton         setBackgroundImage:[UIImage imageNamed:@"images/kChartImage/KChart06"] forState:UIControlStateNormal];
    [clearAllButton         setBackgroundImage:[UIImage imageNamed:@"images/kChartImage/KChart07"] forState:UIControlStateNormal];
    
    [self addSubview:backButton];
    [self addSubview:kChartTypeButton];
    [self addSubview:cycleTypeButton];
    [self addSubview:technologyTypeButton];
    [self addSubview:clearAllButton];
    [self addSubview:drawLineButton];
    [self addSubview:addOrderButton];
    
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width / 9;
    CGFloat edge = self.frame.size.width / 7;
    CGFloat height = KChartToolBarHeight;
    CGFloat y = 0.0f;
    
    [backButton             setFrame:CGRectMake(edge * 0, y, width, height)];
    [kChartTypeButton       setFrame:CGRectMake(edge * 1, y, width, height)];
    [cycleTypeButton        setFrame:CGRectMake(edge * 2, y, width, height)];
    [drawLineButton         setFrame:CGRectMake(edge * 3, y, width, height)];
    [technologyTypeButton   setFrame:CGRectMake(edge * 4, y, width, height)];
    [addOrderButton         setFrame:CGRectMake(edge * 5, y, width, height)];
    [clearAllButton         setFrame:CGRectMake(edge * 6, y, width, height)];
}

@end
