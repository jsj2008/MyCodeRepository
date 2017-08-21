//
//  ODOrderInfoCell.m
//  FlyLantern
//
//  Created by marco on 16/05/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "ODOrderInfoCell.h"
#import "ODPointUsageModel.h"

@interface ODOrderInfoCell ()
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UILabel *payTimeLabel;

@property (nonatomic, strong) NSMutableArray *pointLabels;
@end

@implementation ODOrderInfoCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.orderIdLabel];
	[self cellAddSubView:self.orderTimeLabel];
	[self cellAddSubView:self.payTimeLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        NSDictionary *data = (NSDictionary *)self.cellData;
        
        self.orderIdLabel.text = [NSString stringWithFormat:@"订单编号：%@", [data objectForKey:@"orderId"]];
        [self.orderIdLabel sizeToFit];
        self.orderIdLabel.top = 12;
        self.orderIdLabel.left = 14;
        
        NSArray *points = [data objectForKey:@"points"];
        
        for (UILabel *label in self.pointLabels) {
            [label removeFromSuperview];
        }
        [self.pointLabels removeAllObjects];
        
        for (int i = 0; i < points.count; i++) {
            ODPointUsageModel *point = [points safeObjectAtIndex:i];
            UILabel *label = [self createPointLabel:point];
            label.top = 12 + 18*(1+i);
            label.left = 14;
            [self.pointLabels addObject:label];
            [self cellAddSubView:label];
        }
        
        self.orderTimeLabel.text = [NSString stringWithFormat:@"提交时间：%@", [data objectForKey:@"orderTime"]];
        [self.orderTimeLabel sizeToFit];
        self.orderTimeLabel.top = 12 + 18 *(1 + points.count);
        self.orderTimeLabel.left = 14;
        
        NSString *payTime = [data objectForKey:@"payTime"];
        if (!IsEmptyString(payTime)) {
            self.payTimeLabel.text = [NSString stringWithFormat:@"支付时间：%@", [data objectForKey:@"payTime"]];
            [self.payTimeLabel sizeToFit];
            self.payTimeLabel.top = 12 + 18 *(2 + points.count);
            self.payTimeLabel.left = 14;
        }else{
            self.payTimeLabel.text = @"";
        }

	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        NSDictionary *data = (NSDictionary *)cellData;
        NSArray *points = [data objectForKey:@"points"];
        int row = 2;
        if (!IsEmptyString(((NSString*)[data objectForKey:@"payTime"]))) {
            row = 3;
        }
        height = 12*2 + (row + points.count)*18;
	}
	return height;
}

#pragma mark - Subviews
- (UILabel *)orderTimeLabel {
    
    if ( !_orderTimeLabel ) {
        _orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _orderTimeLabel.textColor = Color_Gray153;
        _orderTimeLabel.font = FONT(14);
        _orderTimeLabel.numberOfLines = 1;
    }
    
    return _orderTimeLabel;
}


- (UILabel *)orderIdLabel {
    
    if ( !_orderIdLabel ) {
        _orderIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _orderIdLabel.textColor = Color_Gray153;
        _orderIdLabel.font = FONT(14);
        _orderIdLabel.numberOfLines = 1;
    }
    
    return _orderIdLabel;
}

- (UILabel *)payTimeLabel
{
	if (!_payTimeLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray153;
		label.text = @"";
		[label sizeToFit];
		_payTimeLabel = label;
	}
	return _payTimeLabel;
}

- (UILabel*)createPointLabel:(ODPointUsageModel*)point
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
    label.font = FONT(14);
    label.textColor = Color_Gray153;
    label.numberOfLines = 1;
    NSString *name = point.name;
    //空格美化
    if (point.name.length < 4) {
        for (int i = 0; i < 4-point.name.length; i++) {
            name = [@"    " stringByAppendingString:name];
        }
    }
    label.text = [name stringByAppendingFormat:@"：%@",point.value];
    [label sizeToFit];
    return label;
}
@end
