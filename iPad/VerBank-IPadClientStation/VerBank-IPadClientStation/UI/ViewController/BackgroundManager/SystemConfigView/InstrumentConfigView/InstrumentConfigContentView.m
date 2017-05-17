//
//  InstrumentConfigContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "InstrumentConfigContentView.h"
#import "ClientSystemConfig.h"
#import "LangCaptain.h"
#import "InstrumentStructNode.h"
#import "UIView+AddLine.h"
#import "LayoutCenter.h"
#import "API_IDEventCaptain.h"
#import "UIColor+CustomColor.h"

#define CellHeight 50.0f
#define CheckBoxTag 100

@interface InstrumentConfigContentView()<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *contentArray;
}

@end

@implementation InstrumentConfigContentView

@synthesize titleLabel;

@synthesize backButton;

@synthesize leftButton;
@synthesize middleButton;
@synthesize rightButton;
@synthesize reorderView;

- (void)initContent {
    [self initData];
    [self initComponent];
}

#pragma init

- (void)initData {
    contentArray = [[NSMutableArray alloc] init];
    [contentArray addObject:[[ClientSystemConfig getInstance] instrumentArray]];
}

- (void)initComponent {
    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"SystemConfig"]];
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    reorderView.tableView.delegate = self;
    reorderView.tableView.dataSource = self;
    [reorderView setObjects:contentArray];
    [self initButtonView];
    [self setBackgroundColor:[UIColor grayColor]];
}

- (void)initButtonView {
    
    [self.leftButton    setTitle:[[LangCaptain getInstance] getLangByCode:@"SelectAll"] forState:UIControlStateNormal];
    [self.middleButton  setTitle:[[LangCaptain getInstance] getLangByCode:@"DefaultSelect"] forState:UIControlStateNormal];
    [self.rightButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"DeselectAll"] forState:UIControlStateNormal];
    [self.backButton    setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    
    [self.leftButton    addTarget:self action:@selector(selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    [self.middleButton  addTarget:self action:@selector(unselectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton   addTarget:self action:@selector(deselectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton    addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma action

- (void)selectAllAction {
    //    [[ClientSystemConfig getInstance] setUnselectInstrumentArray:[[NSMutableArray alloc] init]];
    for (InstrumentStructNode *instStruct in [[ClientSystemConfig getInstance] instrumentArray]) {
        if ([instStruct selectType] == InstrumentUnselect) {
            [instStruct setSelectType:InstrumentSelected];
        }
    }
    [[ClientSystemConfig getInstance] saveConfigData];
    [reorderView.tableView reloadData];
}

- (void)unselectAction {
    
    [[ClientSystemConfig getInstance] resetInstrumentArray];
    
    [[ClientSystemConfig getInstance] saveConfigData];
    [self initData];
    [reorderView.tableView reloadData];
}

- (void)deselectAction {
    //    [[ClientSystemConfig getInstance] setUnselectInstrumentArray:[contentArray[0] mutableCopy]];
    for (InstrumentStructNode *instStruct in [[ClientSystemConfig getInstance] instrumentArray]) {
        if ([instStruct selectType] == InstrumentSelected) {
            [instStruct setSelectType:InstrumentUnselect];
        }
    }
    [[ClientSystemConfig getInstance] saveConfigData];
    [reorderView.tableView reloadData];
}


#pragma tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    InstrumentStructNode *instStruct = [contentArray[0] objectAtIndex:[indexPath row]];
    NSString * instrument = [instStruct instrumentName];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addHeaderBottomLineWithWidth:0.5f bgColor:[UIColor whiteColor]];
    }
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor grayColor]];
    [cell.textLabel setText:instrument];
    
    UIImageView *checkBox = (UIImageView *)[cell viewWithTag:CheckBoxTag];
    if (checkBox == nil) {
        if ([instStruct selectType] == InstrumentSelected) {
            checkBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/normal/checkbox_pressed"]];
        } else {
            checkBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/normal/checkbox_normal"]];
        }
        [checkBox setTag:CheckBoxTag];
        [checkBox setFrame:CGRectMake(0, 0, 30, 30)];
        CGPoint center = CGPointMake(cell.frame.size.width - 30.0f, cell.frame.size.height / 2);
        [checkBox setCenter:center];
        
        [cell addSubview:checkBox];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstrumentStructNode *instStruct = [contentArray[0] objectAtIndex:[indexPath row]];
    if ([instStruct selectType] == InstrumentSelected) {
        [instStruct setSelectType:InstrumentUnselect];
    } else if ([instStruct selectType] == InstrumentUnselect) {
        [instStruct setSelectType:InstrumentSelected];
    }
    
    [[ClientSystemConfig getInstance] saveConfigData];
    
    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
    [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [reorderView.tableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray[0] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

#pragma action
- (void)backAction {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showSystemConfigView];
    [API_IDEventCaptain fireEventChanged:SystemConfig_InstrumentArrayChanged eventData:nil];
}


@end
