//
//  InstrumentChoosePopView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InstrumentChoosePopView.h"
#import "IosLayoutDefine.h"
#import "TopBarView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "UIFormat.h"
#import "ClientSystemConfig.h"
#import "APIDoc.h"
#import "UIView+FreezeTableView.h"

#import "ReOrderTableView.h"

#import "InstrumentStruct.h"

#define CellHeight 50.0f
#define CheckBoxTag 100

@interface InstrumentChoosePopView()<UITableViewDataSource, UITableViewDelegate> {
    UIView *contentView;
    //    UITableView *contentTableView;
    NSMutableArray *contentArray;
    
    UIView *buttonView;
    
    ReOrderTableView *reOrderTableView;
    
    //    NSMutableArray *objects;
}

@end

@implementation InstrumentChoosePopView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self initComponent];
        [self initLayout];
    }
    return self;
}

#pragma init

- (void)initData {
    contentArray = [[NSMutableArray alloc] init];
    [contentArray addObject:[[ClientSystemConfig getInstance] instrumentArray]];
}

- (void)initComponent {
    [self initTopBar];
    [self initContentView];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)initLayout {
    [contentView setFrame:CGRectMake(0,SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT)];
    
    
    
    CGRect buttonViewRect = contentView.frame;
    buttonViewRect.origin.y = 0.0f;
    buttonViewRect.size.height = 45.0f;
    [buttonView setFrame:buttonViewRect];
}

- (void)initTopBar{
    TopBarView *topBar = [[TopBarView alloc] init];
    //    [topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"SystemConfig"] withMidButton:nil];
    [topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"SystemConfig"] withMidButton:nil];
    [self addSubview:topBar];
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    CGPoint centerPoint = CGPointMake(SCREEN_TOPST_HEIGHT / 2, SCREEN_TOPST_HEIGHT / 2);
    CGRect imageRect = CGRectMake(0, 0, 20, 20);
    
    //    [leftButton setFrame:[ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(12, 12, 28, 28)]];
    [leftButton setFrame:CGRectMake(0, SCREEN_STATUS_BAR, SCREEN_TOPST_HEIGHT, SCREEN_TOPST_HEIGHT)];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton addTarget:self action:@selector(reback) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:imageRect]];
    [leftButton addSubview:leftView];
    [leftView setImage:[UIImage imageNamed:@"images/normal/reback.png"]];
    [leftView setCenter:centerPoint];
    
    [topBar addSubview:leftButton];
}

- (void)initContentView {
    contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    CGRect contentRect = CGRectMake(0,45.0f,SCREEN_WIDTH,SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT - 45.0f);
    //    contentRect.origin.y = 0.0f;
    //    contentRect.size.height -= 45.0f;
    //    contentRect.origin.y += 45.0f;
    
    //    [contentTableView setFrame:contentRect];
    
    [reOrderTableView setFrame:ContentRect];
    
    reOrderTableView = [[ReOrderTableView alloc] initWithFrame:contentRect
                                                   withObjects:contentArray
                                                    canReorder:YES];
    reOrderTableView.tableView.delegate = self;
    reOrderTableView.tableView.dataSource = self;
    
    buttonView = [[UIView alloc] init];
    [buttonView setBackgroundColor:[UIColor blackColor]];
    [self initButtonView];
    
    [contentView addSubview:reOrderTableView];
    [contentView addSubview:buttonView];
}

- (void)initButtonView {
    
    CGFloat adge = 10.0f;
    CGFloat gap = 4.0f;
    CGFloat width = (SCREEN_WIDTH - adge * 2 - gap * 2) / 3;
    
    CGRect selectedAllRect = CGRectMake(adge, 5.0f, width, 35.0f);
    CGRect unselectedRect = CGRectMake(adge + width + gap, 5.0f, width, 35.0f);
    CGRect deselectedRect = CGRectMake(adge + width * 2 + gap * 2, 5.0f, width, 35.0f);
    
    UIButton *selectedAllButton = [[UIButton alloc] initWithFrame:selectedAllRect];
    UIButton *unselectedButton = [[UIButton alloc] initWithFrame:unselectedRect];
    UIButton *deselectedButton = [[UIButton alloc] initWithFrame:deselectedRect];
    
    [UIFormat setComplexBlueButtonColor:selectedAllButton];
    [UIFormat setComplexBlueButtonColor:unselectedButton];
    [UIFormat setComplexBlueButtonColor:deselectedButton];
    
    [selectedAllButton setTitle:[[LangCaptain getInstance] getLangByCode:@"SelectAll"] forState:UIControlStateNormal];
    [unselectedButton setTitle:[[LangCaptain getInstance] getLangByCode:@"DefaultSelect"] forState:UIControlStateNormal];
    [deselectedButton setTitle:[[LangCaptain getInstance] getLangByCode:@"DeselectAll"] forState:UIControlStateNormal];
    
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:selectedAllButton];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:unselectedButton];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:deselectedButton];
    
    [buttonView addSubview:selectedAllButton];
    [buttonView addSubview:unselectedButton];
    [buttonView addSubview:deselectedButton];
    
    [selectedAllButton addTarget:self action:@selector(selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    [unselectedButton addTarget:self action:@selector(unselectAction) forControlEvents:UIControlEventTouchUpInside];
    [deselectedButton addTarget:self action:@selector(deselectAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma action

- (void)selectAllAction {
    //    [[ClientSystemConfig getInstance] setUnselectInstrumentArray:[[NSMutableArray alloc] init]];
    for (InstrumentStruct *instStruct in [[ClientSystemConfig getInstance] instrumentArray]) {
        if ([instStruct selectType] == InstrumentUnselect) {
            [instStruct setSelectType:InstrumentSelected];
        }
    }
    [[ClientSystemConfig getInstance] saveConfigData];
    [reOrderTableView.tableView reloadData];
}

- (void)unselectAction {
    
    [[ClientSystemConfig getInstance] resetInstrumentArray];
    
    [[ClientSystemConfig getInstance] saveConfigData];
    [self initData];
    [reOrderTableView.tableView reloadData];
}

- (void)deselectAction {
    //    [[ClientSystemConfig getInstance] setUnselectInstrumentArray:[contentArray[0] mutableCopy]];
    for (InstrumentStruct *instStruct in [[ClientSystemConfig getInstance] instrumentArray]) {
        if ([instStruct selectType] == InstrumentSelected) {
            [instStruct setSelectType:InstrumentUnselect];
        }
    }
    [[ClientSystemConfig getInstance] saveConfigData];
    [reOrderTableView.tableView reloadData];
}


#pragma tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    InstrumentStruct *instStruct = [contentArray[0] objectAtIndex:[indexPath row]];
    NSString * instrument = [instStruct instrumentName];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addHeaderBottomLineWithWidth:0.5f bgColor:[UIColor whiteColor]];
    }
    //    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    [cell.textLabel setText:[[LangCaptain getInstance] getLangByCode:instrument]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
    //    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/SystemBackground/blue1.png"]]];
    //    [self setBackgroundView:cell indexPath:indexPath];
    [cell.textLabel setText:instrument];
    
    UIImageView *checkBox = (UIImageView *)[cell viewWithTag:CheckBoxTag];
    if (checkBox == nil) {
        //        NSString *instrumentName = [[[ClientSystemConfig getInstance] unselectInstrumentArray] objectAtIndex:[indexPath row]];
        //        NSString *instrumentName = [contentArray[0] objectAtIndex:[indexPath row]];
        //        NSMutableArray *unselectInstrumentArray = [[ClientSystemConfig getInstance] unselectInstrumentArray];
        
        //        NSString *instrumentName = [instStruct instrumentName];
        if ([instStruct selectType] == InstrumentSelected) {
            checkBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/normal/checkbox_pressed"]];
        } else {
            checkBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/normal/checkbox_normal"]];
        }
        [checkBox setTag:CheckBoxTag];
        [checkBox setFrame:CGRectMake(0, 0, 30, 30)];
        CGPoint center = CGPointMake(SCREEN_WIDTH - 30.0f, cell.frame.size.height / 2);
        [checkBox setCenter:center];
        
        [cell addSubview:checkBox];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *instrumentName = [contentArray[0] objectAtIndex:[indexPath row]];
    
//    NSMutableArray *instrumentArray = [[ClientSystemConfig getInstance] unselectInstrumentArray];
//    if ([instrumentArray containsObject:instrumentName]) {
//        [instrumentArray removeObject:instrumentName];
//    } else {
//        [instrumentArray addObject:instrumentName];
//    }
    
    InstrumentStruct *instStruct = [contentArray[0] objectAtIndex:[indexPath row]];
    if ([instStruct selectType] == InstrumentSelected) {
        [instStruct setSelectType:InstrumentUnselect];
    } else if ([instStruct selectType] == InstrumentUnselect) {
        [instStruct setSelectType:InstrumentSelected];
    }
    
    [[ClientSystemConfig getInstance] saveConfigData];
    
    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
    [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [reOrderTableView.tableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray[0] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

- (void)reback {
    [self removeFromSuperview];
}


@end
