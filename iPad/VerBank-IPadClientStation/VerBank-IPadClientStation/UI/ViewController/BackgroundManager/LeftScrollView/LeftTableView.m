//
//  LeftTableView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LeftTableView.h"
#import "UIFormat.h"
#import "IOSLayoutDefine.h"
#import "BackgroundStatusEnum.h"
#import "LeftTableViewCell.h"
#import "UIColor+CustomColor.h"
#import "LangCaptain.h"
#import "LayoutCenter.h"

#define Setion0Count 7
#define Setion1Count 2
#define Setion2Count 4

static const CGFloat cellHeight = 40.0f;
static const CGFloat sectionHeight = 8.0f;

static const CGFloat defaultLeftWidth = 200.0f;
static const CGFloat defaultLeftHeight = cellHeight * 13 + sectionHeight * 2 * 3;

@interface LeftTableView()<UITableViewDataSource, UITableViewDelegate> {
    
    Boolean isTouchable;
    NSMutableArray *_leftIndexArray;
    UITableView *_contentTableView;
    
    // 為了傳參， 不得已為之。 以後改。
    LeftViewSelectIndex selectIndex;
}

@end

@implementation LeftTableView

- (id)init {
    if (self = [super init]) {
        [self setDefault];
        [self initComponent];
        [self initIndex];
    }
    return self;
}

#pragma init
- (void)setDefault {
    selectIndex = -1;
    isTouchable = true;
    self.status = Closed;
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:0.0f];
}

- (void)initIndex {
    _leftIndexArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray0 = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < Setion0Count; i++) {
        [tempArray0 addObject:[NSString stringWithFormat:@"0_%d", i]];
    }
    
    for (int i = 0; i < Setion1Count; i++) {
        [tempArray1 addObject:[NSString stringWithFormat:@"1_%d", i]];
    }
    
    for (int i = 0; i < Setion2Count; i++) {
        [tempArray2 addObject:[NSString stringWithFormat:@"2_%d", i]];
    }
    
    [_leftIndexArray addObject:tempArray0];
    [_leftIndexArray addObject:tempArray1];
    [_leftIndexArray addObject:tempArray2];
}

- (void)initComponent {
    [self setFrame:CGRectMake(-defaultLeftWidth,
                              SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR,
                              defaultLeftWidth,
                              defaultLeftHeight)];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setUserInteractionEnabled:true];
    [self initLeftTableView];
}

- (void)initLeftTableView {
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      defaultLeftWidth,
                                                                      defaultLeftHeight)];
    _contentTableView.backgroundColor = [UIColor clearColor];
    _contentTableView.dataSource = self;
    _contentTableView.delegate = self;
    _contentTableView.bounces = NO;
    _contentTableView.showsVerticalScrollIndicator = NO;
    [UIFormat setCorner:UIRectCornerTopRight | UIRectCornerBottomRight WithUIView:_contentTableView withCorner:16.0f];
    //    _contentTableView.layer.shadowOffset = CGSizeMake(10, 10);
    //    _contentTableView.layer.shadowOpacity = 0.80;
    //    _contentTableView.layer.shadowColor = [UIColor redColor].CGColor;
    //    _contentTableView.layer.shadowRadius = 4;
    [_contentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //    [_contentTableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapPressToDo:)]];
    //    [_contentTableView setAllowsSelection:YES];
    [self addSubview:_contentTableView];
}

#pragma tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_leftIndexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_leftIndexArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIndentifier = @"leftViewCell";
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"LeftTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIndentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    }
    
    [self setLeftTableViewCell:cell withIndex:indexPath];
    cell.selectedBackgroundView.backgroundColor = [UIColor leftTableViewBackgroundColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return sectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, sectionHeight)];
    [footerView setBackgroundColor:[UIColor leftTableViewBackgroundColor]];
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, sectionHeight)];
    [headerView setBackgroundColor:[UIColor leftTableViewBackgroundColor]];
    return headerView;
}

- (void) setLeftTableViewCell:(LeftTableViewCell *) cell withIndex:(NSIndexPath *)indexPath {
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"images/LeftTableViewCell/left_%ld_%ld.png",[indexPath section], [indexPath row]]];
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/LeftTableViewCell/background_normal.png"]]];
    [cell setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/LeftTableViewCell/background_selected.png"]]];
    cell.nameLabel.text = [[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"left_%ld_%ld", [indexPath section], [indexPath row]]];
    [cell.nameLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:16.0f]]];
    [cell setBackgroundColor:[UIColor leftTableViewBackgroundColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // 不知道为什么 这个不响应 @@@@ superview 有事件的情况下
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self closeView];
    selectIndex = [indexPath section] * 100 + [indexPath row];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftTableViewCell *cell = (LeftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.nameLabel setTextColor:[UIColor whiteColor]];
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"images/LeftTableViewCell/sleft_%ld_%ld.png",[indexPath section], [indexPath row]]];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftTableViewCell *cell = (LeftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.nameLabel setTextColor:[UIColor blackColor]];
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"images/LeftTableViewCell/left_%ld_%ld.png",[indexPath section], [indexPath row]]];
}

#pragma action
- (void)closeView {
    if (!isTouchable) {
        return;
    }
    isTouchable = false;
//    [super closeView];
    self.status = Closed;
    
    CGRect rect = CGRectMake(-defaultLeftWidth,
                             SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR,
                             defaultLeftWidth,
                             defaultLeftHeight);
    [UIView animateWithDuration:0.5f animations:^{
        [self setFrame:rect];
    } completion:^(BOOL finished) {
        [[self superview] setHidden:true];
        [self setHidden:true];
        isTouchable = true;
        if ([[LayoutCenter getInstance] backgroundLayoutCenter] != nil) {
            [[[LayoutCenter getInstance] backgroundLayoutCenter] leftScrollViewClickAtInde:selectIndex];
        }
        selectIndex = -1;
    }];
}

- (void)openView {
    if (!isTouchable) {
        return;
    }
    isTouchable = false;
    [super openView];
    
    [[self superview] setHidden:false];
    [self setHidden:false];
    CGRect rect = CGRectMake(0,
                             SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR,
                             defaultLeftWidth,
                             defaultLeftHeight);
    [UIView animateWithDuration:0.5f animations:^{
        [self setFrame:rect];
    } completion:^(BOOL finished) {
        isTouchable = true;
    }];
}

@end
