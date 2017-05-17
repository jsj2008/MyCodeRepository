//
//  ShowChooseView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/10.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "ShowChooseView.h"
#import "IosLayoutDefine.h"
#import "UIView+FreezeTableView.h"
#import "LangCaptain.h"
#import "KChartParam.h"
#import "KChartView.h"
#import "TiArgumentConfig.h"
#import "MAData.h"

#define MaxHeight 170
#define CellHeight 40
//#define CellHeight 60

#define ImageTag 101
#define CellTextTag 102

@interface ShowChooseView()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *mTableView;
    id <chooseProtocol>_delegate;
    NSArray *chooseArray;
    int _type;
}

@end

@implementation ShowChooseView

//@synthesize type = _type;
@synthesize subChooseView;

- (id)init {
    if (self = [super init]) {
        mTableView = [[UITableView alloc] init];
        mTableView.bounces = NO;
        mTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        mTableView.showsVerticalScrollIndicator = NO;
        mTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [mTableView scrollsToTop];
        [mTableView setBackgroundColor:[UIColor blackColor]];
        
        [self addSubview:mTableView];
        [mTableView setDelegate:self];
        [mTableView setDataSource:self];
        
        self.layer.cornerRadius = 5.0f;
        mTableView.layer.cornerRadius = 5.0f;
    }
    return self;
}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
}

- (void)setChooseArray:(NSArray *)array {
    if (subChooseView != nil) {
        [subChooseView setHidden:true];
    }
    chooseArray = array;
    CGFloat height = [array count] * CellHeight > MaxHeight ? MaxHeight : [array count] * CellHeight;
    //    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH / 6 * 2, height);
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH / 6 * 2, height);
    [self setFrame:frame];
    [mTableView setFrame:frame];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (chooseArray == nil) ? 0 : [chooseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSUInteger row = [indexPath row];
    switch (_type) {
        case CycleChooseType:
            return [self cycleChooseCell:row uitableView:tableView];
            break;
        case TechnologyType:
            return [self tiChooseCell:row uitableView:tableView];
            break;
        case DrawType:
            return [self drawChooseCell:row uitableView:tableView];
            break;
        case CandleStickType:
            return [self kChartChooseCell:row uitableView:tableView];
            break;
        case MaSubArrayType:
            return [self maSubArrayChooseCell:row uitableView:tableView];
            break;
        default:
            break;
    }
    return nil;
}

- (UITableViewCell *)cycleChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView{
    static NSString *cycleIdentifier = @"CycleChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cycleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cycleIdentifier];
        [cell addHeaderBottomLineWithWidth:0.8f bgColor:[UIColor whiteColor]];
    }
    
    NSString *cycleName = [[LangCaptain getInstance] getLangByCode:[[chooseArray objectAtIndex:row] stringValue]];
    cell.textLabel.text = cycleName;
    //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
    
    if ([[chooseArray objectAtIndex:row] intValue] == [[KChartParam getInstance] cycle]) {
        if ([cell viewWithTag:ImageTag] == nil) {
            CGRect frame = CGRectMake(0, 0, CellHeight - 15, CellHeight - 15);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setTag:ImageTag];
            [imageView setCenter:CGPointMake(self.frame.size.width - CellHeight, CellHeight / 2)];
            [imageView setImage:[UIImage imageNamed:@"images/normal/select"]];
            [cell addSubview:imageView];
        }
    } else {
        if ([cell viewWithTag:ImageTag] != nil) {
            [[cell viewWithTag:ImageTag] removeFromSuperview];
        }
    }
    return cell;
}

- (UITableViewCell *)maSubArrayChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView{
    static NSString *cycleIdentifier = @"MaSubArrayChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cycleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cycleIdentifier];
        [cell addHeaderBottomLineWithWidth:0.8f bgColor:[UIColor whiteColor]];
    }
    
    //    NSString *cycleName = [[LangCaptain getInstance] getLangByCode:[chooseArray objectAtIndex:row]];
    NSArray *maArray = [[TiArgumentConfig getInstance] maDataArray];
    MAData *data = [maArray objectAtIndex:row];
    int period = [[data maPeriod] intValue];
//    if (subDic != nil) {
//        period = [[subDic objectForKey:@"period"] intValue];
//    }
    NSString *maName = [[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"MA%d", period]];
    cell.textLabel.text = maName;
    //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
    
    //    if ([[[KChartParam getInstance] mutableTechnologyArray] containsObject:[chooseArray objectAtIndex:row]]) {
    if (![[[[KChartParam getInstance] mutableTechnologyArray] objectAtIndex:row] isEqualToString:@"MA0"]) {
        if ([cell viewWithTag:ImageTag] == nil) {
            CGRect frame = CGRectMake(0, 0, CellHeight - 15, CellHeight - 15);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setTag:ImageTag];
            [imageView setCenter:CGPointMake(self.frame.size.width - CellHeight, CellHeight / 2)];
            [imageView setImage:[UIImage imageNamed:@"images/normal/select"]];
            [cell addSubview:imageView];
        }
    } else {
        cell.textLabel.text = @"MA0";
        if ([cell viewWithTag:ImageTag] != nil) {
            [[cell viewWithTag:ImageTag] removeFromSuperview];
        }
    }
    return cell;
}

- (UITableViewCell *)tiChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView {
    //        NSString *cycleName = [[LangCaptain getInstance] getLangByCode:[[chooseArray objectAtIndex:row] stringValue]];
    
    static NSString *tiIdentifier = @"TiChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             tiIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tiIdentifier];
        [cell addHeaderBottomLineWithWidth:0.8f bgColor:[UIColor whiteColor]];
    }

//    cell.textLabel.text = [[LangCaptain getInstance] getLangByCode:[chooseArray objectAtIndex:row]];
//    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
//    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UILabel *textLabel = [cell viewWithTag:CellTextTag];
    if (textLabel == nil) {
        CGRect frame = CGRectMake(10, 0, cell.frame.size.width - 120, CellHeight);
        textLabel = [[UILabel alloc] initWithFrame:frame];
        [textLabel setTag:CellTextTag];
//        [textLabel setCenter:CGPointMake(cell.frame.size.width / 2  + 5, CellHeight / 2)];
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [textLabel setFont:[UIFont systemFontOfSize:13.0f]];
        textLabel.numberOfLines = 0;
        [cell addSubview:textLabel];
    }
   
    NSMutableString *text = [NSMutableString stringWithString:[[LangCaptain getInstance] getLangByCode:[chooseArray objectAtIndex:row]]];

    [textLabel setText:[text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    if ([[[KChartParam getInstance] technologyArray] containsObject:[chooseArray objectAtIndex:row]]) {
        if ([cell viewWithTag:ImageTag] == nil) {
            CGRect frame = CGRectMake(0, 0, CellHeight - 15, CellHeight - 15);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setTag:ImageTag];
            [imageView setCenter:CGPointMake(self.frame.size.width - CellHeight, CellHeight / 2)];
            [imageView setImage:[UIImage imageNamed:@"images/normal/select"]];
            [cell addSubview:imageView];
        }
    } else {
        if ([cell viewWithTag:ImageTag] != nil) {
            [[cell viewWithTag:ImageTag] removeFromSuperview];
        }
    }
    return cell;
}

- (UITableViewCell *)drawChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView {
    static NSString *drawIdentifier = @"DrawChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:drawIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:drawIdentifier];
        [cell addHeaderBottomLineWithWidth:0.8f bgColor:[UIColor whiteColor]];
    }
    cell.textLabel.text = [chooseArray objectAtIndex:row];
    //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setText:[[LangCaptain getInstance] getLangByCode:[chooseArray objectAtIndex:row]]];
    [cell setBackgroundColor:[UIColor blackColor]];
    return cell;
}

- (UITableViewCell *)kChartChooseCell:(NSUInteger)row uitableView:(UITableView *)tableView {
    static NSString *kChartIdentifier = @"KChartChooseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChartIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChartIdentifier];
        [cell addHeaderBottomLineWithWidth:0.8f bgColor:[UIColor whiteColor]];
    }
    
//    cell.textLabel.text = [[LangCaptain getInstance] getLangByCode:[chooseArray objectAtIndex:row]];
    //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//    [cell.textLabel setTextColor:[UIColor whiteColor]];
//    [cell setBackgroundColor:[UIColor blackColor]];
    
    //    cell.textLabel.text = [[LangCaptain getInstance] getLangByCode:[chooseArray objectAtIndex:row]];
    //    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
    //    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UILabel *textLabel = [cell viewWithTag:CellTextTag];
    if (textLabel == nil) {
        CGRect frame = CGRectMake(10, 0, cell.frame.size.width - 120, CellHeight);
        textLabel = [[UILabel alloc] initWithFrame:frame];
        [textLabel setTag:CellTextTag];
        //        [textLabel setCenter:CGPointMake(cell.frame.size.width / 2  + 5, CellHeight / 2)];
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [textLabel setFont:[UIFont systemFontOfSize:13.0f]];
        textLabel.numberOfLines = 0;
        [cell addSubview:textLabel];
    }
    
    NSMutableString *text = [NSMutableString stringWithString:[[LangCaptain getInstance] getLangByCode:[chooseArray objectAtIndex:row]]];
    
    [textLabel setText:[text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    if ([[[KChartParam getInstance] kChartType] isEqualToString:[chooseArray objectAtIndex:row]]) {
        if ([cell viewWithTag:ImageTag] == nil) {
            CGRect frame = CGRectMake(0, 0, CellHeight - 15, CellHeight - 15);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setTag:ImageTag];
            [imageView setCenter:CGPointMake(self.frame.size.width - CellHeight, CellHeight / 2)];
            [imageView setImage:[UIImage imageNamed:@"images/normal/select"]];
            [cell addSubview:imageView];
        }
    } else {
        if ([cell viewWithTag:ImageTag] != nil) {
            [[cell viewWithTag:ImageTag] removeFromSuperview];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didSelectAtIndex:type:)]) {
        [_delegate didSelectAtIndex:(int)[indexPath row] type:_type];
        [tableView reloadData];
    }
    //    [self setHidden:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

- (void)reloadData {
    [mTableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (subChooseView != nil) {
        [subChooseView setHidden:true];
    }
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    if (hidden && subChooseView != nil) {
        [subChooseView setHidden:hidden];
    }
    
    if (!hidden) {
        [mTableView reloadData];
    }
}

@end
