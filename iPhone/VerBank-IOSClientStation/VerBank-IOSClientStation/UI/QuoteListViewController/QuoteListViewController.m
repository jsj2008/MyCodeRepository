//
//  MainViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "QuoteListViewController.h"
#import "LeftTableViewCell.h"
#import "LangCaptain.h"

#import "ImageUtils.h"
#import "IosLogic.h"
#import "QuoteListContentView.h"
#import "API_IDEventCaptain.h"
#import "JEDISystem.h"
#import "CDS_PriceSnapShot.h"

#import "IosConfig.h"
#import "IosLayoutDefine.h"
#import "QuoteDataStore.h"

#import "KChartView.h"

#import "TradeApi.h"
#import "KChartParam.h"
#import "FreezeTableView.h"
#import "KChartView.h"

#import "OperationRecordsSave.h"

@interface QuoteListViewController(){
    QuoteListContentView *quoteListView;
    CGFloat width;
    CGFloat height;
}

@end

@implementation QuoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"QuoteList"] centerButton:nil];
    [self initQuoteContentView];
    [KChartView getInstance];
}

- (void)initQuoteContentView{
    //    quoteListView = [[QuoteListContentView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:ContentRect]];
    //    ContentRect CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT)
    CGRect quoteListRect = ContentRect;
//    quoteListRect.size.height += FIXHOTTOPIC_HEIGHT;
    //    quoteListRect.size.height -= buttonHeight;
    quoteListView = [[QuoteListContentView alloc] initWithFrame:quoteListRect];
    [quoteListView setBackgroundColor:[UIColor blackColor]];
    [self.centerContentView addSubview:quoteListView];
    
    //    KChartView *kChartView = [[KChartView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT - buttonHeight, SCREEN_WIDTH, 400.0f)];
    
    [self.centerContentView setBackgroundColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    width = SCREEN_WIDTH;
    height = SCREEN_HEIGHT;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 初始化
    [quoteListView reloadData];
    [quoteListView autoPortrait];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = [[UIDevice currentDevice] orientation];
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
    [quoteListView addListener];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[KChartView getInstance] removeFromSuperview];
    [[KChartView getInstance] reset];
//    [KChartView getInstance];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)dealloc{
    [quoteListView removeFromSuperview];
    quoteListView = nil;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        // 横屏
        [self autoLandscape];
    } else if (toInterfaceOrientation == UIInterfaceOrientationPortrait){
        // 竖屏
        [self autoPortrait];
    }
}

- (void)autoLandscape {
    [quoteListView portrait:Landscape];
    [self.centerContentView setFrame:CGRectMake(0,
                                                0,
                                                height,
                                                width)];
    [quoteListView setFrame:CGRectMake(0,
                                       0,
                                       height,
                                       width)];
    
    //    [self.leftContentView setHidden:true];
    //    [self.backgroundView setHidden:true];
    [[KChartView getInstance] ableBackButton];
    [quoteListView autoLandscape];
    
}

- (void)autoPortrait{

    [self.centerContentView setFrame:CGRectMake(0,
                                                SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR,
                                                width,
                                                height - SCREEN_TOPST_HEIGHT - SCREEN_STATUS_BAR)];
    
    [quoteListView setFrame:CGRectMake(0,
                                       0,
                                       width,
                                       height - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT)];
    
    //    [self.leftContentView setHidden:false];
    //    [self.backgroundView setHidden:false];
    
    
    [quoteListView autoPortrait];
    
    if ([[KChartView getInstance] isPoped]) {
        [quoteListView portrait:PortraitPopedForce];
    } else {
        [quoteListView portrait:PortraitNormalForce];
    }
    
}

- (QuoteListContentView *)getQuoteListView {
    return quoteListView;
}

@end
