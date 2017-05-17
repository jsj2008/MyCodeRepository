//
//  HedgingSubView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "HedgingSubView.h"
#import "HedgingTableViewCell.h"
#import "UIView+AddLine.h"
#import "APIDoc.h"
#import "ClientAPI.h"
#import "CommDataUtil.h"
#import "JumpDataCenter.h"
#import "DecimalUtil.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "ToCloseTradeNode.h"
#import "CheckUtils.h"

static NSString *hedgingTableViewCell = @"HedgingTableViewCell";
static NSString *hedgingTableViewIdentifier = @"HedgingTableViewIdentifier";

static const CGFloat _cellHeight = 40.0f;

@interface HedgingSubView()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, ZLKeyboardDelegate> {
    NSString *_instrumentName;
    HedgingType _hedgingType;
}

@property NSArray *contentArray;

@end

@implementation HedgingSubView

@synthesize mainView;
@synthesize buySellLabel;
@synthesize openPositionTableView;
@synthesize topNameView;
@synthesize sumValueLabel;
@synthesize bottomBuySellLabel;

@synthesize keyboardView;

@synthesize contentArray;

- (void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"HedgingSubView" owner:self options:nil];
    [self addSubview:self.mainView];
    [self setDefault];
}

- (void)setDefault {
    [self initTableView];
    
    [self defaultData];
    [self.mainView      setBackgroundColor:[UIColor blackColor]];
}

- (void)setHedgingType:(HedgingType)hedgingType {
    _hedgingType = hedgingType;
    NSString *buySellString = nil;
    if (hedgingType == HedgingTypeBuy) {
        buySellString = [[LangCaptain getInstance] getLangByCode:@"Buy"];
    } else {
        buySellString = [[LangCaptain getInstance] getLangByCode:@"Sell"];
    }
    [self.buySellLabel setText:buySellString];
    [self.bottomBuySellLabel setText:[NSString stringWithFormat:@"%@ :", buySellString]];
}

- (void)initTableView {
    self.openPositionTableView.bounces = NO;
    self.openPositionTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.openPositionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.openPositionTableView.allowsSelection = NO;
    self.openPositionTableView.showsVerticalScrollIndicator = NO;
    [self.openPositionTableView setDelegate:self];
    [self.openPositionTableView setDataSource:self];
    [self.openPositionTableView setBackgroundColor:[UIColor blackColor]];
}

- (void)defaultData {
    _hedgingType = HedgingTypeBuy;
    [self.sumValueLabel setText:@"0"];
    self.contentArray = [[NSArray alloc] init];
}

- (void)updateSum {
    double sum = [self getSumAmount];
    [self.sumValueLabel setText:[DecimalUtil formatNumber:sum]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainView setFrame:self.bounds];
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = [NSString stringWithFormat:@"%@%ld", hedgingTableViewIdentifier, (long)[indexPath row]];
    HedgingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:hedgingTableViewCell bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[trade getInstrument]] getDigits];
    
    [cell.ticketLabel           setText:[NSString stringWithFormat:@"%lld", [trade getTicket]]];
    
    NSString *amountString = [DecimalUtil formatNumber:[trade getAmount]];
    if (_hedgingType == HedgingTypeBuy) {
        amountString = [NSString stringWithFormat:@"+%@", amountString];
        [cell.amountLabel setTextColor:[UIColor blueUpColor]];
    } else {
        amountString = [NSString stringWithFormat:@"-%@", amountString];
        [cell.amountLabel setTextColor:[UIColor redDownColor]];
    }
    
    [cell.amountLabel           setText:amountString];
    [cell.openPriceLabel        setText:[DecimalUtil formatMoney:[trade getOpenprice] digist:digist]];
    [cell.openAmountTextField   setText:[DecimalUtil formatNumber:[trade closeAmount]]];
    
    if (!cell.isAddListener) {
        [cell.inputView setKeyboardDelegate:self];
        [cell setIsAddListener:true];
    }
    
    [cell addHeaderTopLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma publicFunc
- (void)reloadDataByNotify:(Boolean)isNotify {
    
    _instrumentName = [[JumpDataCenter getInstance] hedgingInstrumentName];
    NSArray *array = nil;
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] accountID]];
    if (groupDoc != nil) {
        TradeDoc *tradeDoc  =[groupDoc getTradeDoc];
        array = [[tradeDoc getTTradeByAccountList:[[ClientAPI getInstance]accountID]] mutableCopy];
    }
    //    NSArray *array = [[APIDoc getUserDocCaptain] getTradeArray];
    NSMutableArray *tempArray = [[NSMutableArray  alloc] init];
    if (array != nil && [array count] != 0) {
        for (TTrade *trade in array) {
            if ([[trade getInstrument] isEqualToString:_instrumentName]) {
                if ([trade getCorOrderID] == 0 ||
                    ([CommDataUtil isUptradeOrder:[trade getCorOrderID]] && [CommDataUtil isPriceReached:[trade getCorOrderID]])) {
                    if (_hedgingType == HedgingTypeBuy && [trade getBuysell] == BUY) {
                        [tempArray addObject:trade];
                    }
                    
                    if (_hedgingType == HedgingTypeSell && [trade getBuysell] == SELL) {
                        [tempArray addObject:trade];
                    }
                }
            }
        }
    }
    
    if (!isNotify) {
        for (TTrade *trade in tempArray) {
            [trade setCloseAmount:0];
        }
    }
    
    self.contentArray = tempArray;
    [self.openPositionTableView reloadData];
    [self updateSum];
    // 暫時不排序
    //    [self sortArray:contentArray];
}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    if ([text length] >= 3) {
        [textField setText:@""];
//        [textField selectAll:self];
    }
    return true;
}

- (void)textFiledBeginEdit:(UITextField *)textField {
    UIView *view = [[textField superview] superview];
    if ([view isKindOfClass:[UITableViewCell class]] && [textField.text isEqualToString:@"0"]) {
        UITableViewCell *cell = (UITableViewCell *)view;
        NSIndexPath *path = [self.openPositionTableView indexPathForCell:cell];
        if (path == nil) return;
        TTrade *trade = [self.contentArray objectAtIndex:[path row]];
        [textField setText:[DecimalUtil formatNumber:[trade getAmount]]];
        [textField selectAll:self];
        [trade setCloseAmount:[self getDoubleAmount:textField.text]];
        [self updateSum];
    }
    
    ZLKeyboardView *inputView = (ZLKeyboardView *)textField.inputView;
    ZLTradeNumberKeyboard *leftkeyboardView = [inputView getTradeNumberKeyboard];
    CGRect superRect = self.bounds;
    [leftkeyboardView setFrame:CGRectMake(0, superRect.size.height - 200, superRect.size.width, 200)];
    [self addSubview:leftkeyboardView];
    [leftkeyboardView setHidden:false];
    
    CGRect rect = openPositionTableView.frame;
    rect.size.height -= 180.0f;
    [openPositionTableView setFrame:rect];
}

- (void)textFieldDidEdit:(UITextField *)textField {
    // 这样写有点问题, 但暂时想不到更好的
    UIView *view = [[textField superview] superview];
    if ([view isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)view;
        NSIndexPath *path = [self.openPositionTableView indexPathForCell:cell];
        if (path == nil) return;
        TTrade *trade = [self.contentArray objectAtIndex:[path row]];
        [trade setCloseAmount:[self getDoubleAmount:textField.text]];
        [self updateSum];
    }
}

- (void)textFieldEndEdit:(UITextField *)textField {
    double amount = [self getDoubleAmount:textField.text];
    [textField setText:[DecimalUtil formatNumber:amount]];
    
    ZLTradeNumberKeyboard *numberkeyboardView = [(ZLKeyboardView *)textField.inputView getTradeNumberKeyboard];
    CGRect rect = openPositionTableView.frame;
    rect.size.height += 180.0f;
    [openPositionTableView setFrame:rect];
    [numberkeyboardView setHidden:true];
}

- (double)getDoubleAmount:(NSString *)amount {
    if (amount == nil || [amount length] == 0) {
        return 0.0f;
    }
    return [[amount stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

#pragma publicFunc
- (NSArray *)getTradeArray {
    NSMutableArray *nodeArray = [[NSMutableArray alloc] init];
    for (TTrade *trade in self.contentArray) {
        if ([trade closeAmount] > 0.00001) {
            ToCloseTradeNode *node = [[ToCloseTradeNode alloc] init];
            [node setTicket:[trade getTicket]];
            [node setSplitno:[trade getSplitno]];
            [node setAmount:[trade closeAmount]];
            [nodeArray addObject:node];
        }
    }
    return nodeArray;
}

- (double)getSumAmount {
    double sum = 0.0f;
    for (TTrade *trade in self.contentArray) {
        sum += [trade closeAmount];
    }
    return sum;
}

- (Boolean)isRemainLegal {
    double minAmount = [[[APIDoc getSystemDocCaptain] systemConfig] getWebTradeMinAmount];
    for (TTrade *trade in self.contentArray) {
        float leftAmunt = trade.getAmount - [trade closeAmount];
        if (leftAmunt < minAmount - 1 && leftAmunt > 1) {
            return false;
        }
    }
    return true;
}

- (Boolean)checkAmount {
    if (self.contentArray == nil || [self.contentArray count] == 0) {
        return false;
    }
    
    Boolean isBuySell = [[self.contentArray objectAtIndex:0] getBuysell] == BUY;
    double tradeSumValue = 0.0f;
    for (ToCloseTradeNode *trade in [self getTradeArray]) {
        tradeSumValue += [trade getAmount];
    }
    if (![CheckUtils checkAmount:tradeSumValue buySell:isBuySell instrument:_instrumentName]) {
        return false;
    }
    return true;
}

@end
