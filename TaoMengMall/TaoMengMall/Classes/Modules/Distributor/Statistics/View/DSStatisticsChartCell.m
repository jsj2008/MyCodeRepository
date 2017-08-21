//
//  DSStatisticsChartCell.m
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSStatisticsChartCell.h"
#import "PNChartDelegate.h"
#import "PNChart.h"
#import "DSStatisticsChartModel.h"
#import "DistributorHeader.h"


@interface DSStatisticsChartCell ()
@property (nonatomic, strong) PNLineChart * lineChart;
@property (nonatomic, strong) UILabel *xUnitLabel;
@property (nonatomic, strong) UILabel *yUnitLabel;
@end

@implementation DSStatisticsChartCell

- (void)drawCell
{
    self.backgroundColor = Chart_Gray;
    //self.backgroundColor = Color_Orange;
    
    [self cellAddSubView:self.lineChart];
    [self cellAddSubView:self.yUnitLabel];
    [self cellAddSubView:self.xUnitLabel];
}


- (void)reloadData
{
    if (self.cellData) {
        
        DSStatisticsChartModel *model = (DSStatisticsChartModel*)self.cellData;
        
        [self.lineChart setXLabels:model.x.values];
        
        //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
        //Only if you needed
        self.lineChart.yFixedValueMax = [[model.y.values lastObject] integerValue];
        self.lineChart.yFixedValueMin = 0;
        
        
        [self.lineChart setYLabels:model.y.values];
        
        //self.lineChart.xUnit = @"(小时)";
        //self.lineChart.yUnit = @"(产量/件)";
        
        NSMutableArray *data = [NSMutableArray array];
        
        if (model.paid) {
            NSArray * data02Array = model.paid;
            PNLineChartData *data02 = [PNLineChartData new];
            data02.dataTitle = @"Paid";
            data02.color = Chart_Red;
            data02.alpha = 1.f;
            data02.itemCount = data02Array.count;
            data02.inflexionPointStyle = PNLineChartPointStyleCircle;
            data02.getData = ^(NSUInteger index) {
                CGFloat yValue = [data02Array[index] floatValue];
                return [PNLineChartDataItem dataItemWithY:yValue];
            };
            [data addObject:data02];
        }
        
        if (model.delivered) {
            NSArray * data01Array = model.delivered;
            PNLineChartData *data01 = [PNLineChartData new];
            data01.dataTitle = @"Success";
            data01.color = Chart_Blue;
            data01.alpha = 1.f;
            data01.itemCount = data01Array.count;
            data01.inflexionPointColor = Chart_Blue;
            data01.inflexionPointStyle = PNLineChartPointStyleCircle;
            data01.getData = ^(NSUInteger index) {
                CGFloat yValue = [data01Array[index] floatValue];
                return [PNLineChartDataItem dataItemWithY:yValue];
            };
            [data addObject:data01];
        }
        
        if (model.total) {
            NSArray * data02Array = model.total;
            PNLineChartData *data02 = [PNLineChartData new];
            data02.dataTitle = @"Damage";
            data02.color = Chart_Red;
            data02.alpha = 1.f;
            data02.itemCount = data02Array.count;
            data02.inflexionPointStyle = PNLineChartPointStyleCircle;
            data02.getData = ^(NSUInteger index) {
                CGFloat yValue = [data02Array[index] floatValue];
                return [PNLineChartDataItem dataItemWithY:yValue];
            };
            [data addObject:data02];
        }
        
        if (model.distribute) {
            NSArray * data01Array = model.distribute;
            PNLineChartData *data01 = [PNLineChartData new];
            data01.dataTitle = @"Success";
            data01.color = Chart_Blue;
            data01.alpha = 1.f;
            data01.itemCount = data01Array.count;
            data01.inflexionPointColor = Chart_Blue;
            data01.inflexionPointStyle = PNLineChartPointStyleCircle;
            data01.getData = ^(NSUInteger index) {
                CGFloat yValue = [data01Array[index] floatValue];
                return [PNLineChartDataItem dataItemWithY:yValue];
            };
            [data addObject:data01];
        }
        
        if ([model.y.isShow isEqualToString:@"1"]) {
            _lineChart.yLabelColor = Color_Gray113;
        }else{
            _lineChart.yLabelColor = Chart_Gray;
        }
        
        self.lineChart.chartData = data;
        [self.lineChart strokeChart];
        
        self.xUnitLabel.text = model.x.unit;
        [self.xUnitLabel sizeToFit];
        self.xUnitLabel.right = SCREEN_WIDTH;
        self.xUnitLabel.bottom = 180;
        
        self.yUnitLabel.text = model.y.unit;
        [self.yUnitLabel sizeToFit];
        self.yUnitLabel.left = 2;
        self.yUnitLabel.top = 2;
    }
}


+ (CGFloat)heightForCell:(id)cellData
{
    return 180;
}

- (PNLineChart*)lineChart
{
    if (!_lineChart) {
        _lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 20.0, SCREEN_WIDTH, 150)];
        _lineChart.yLabelFormat = @"%1.1f";
        _lineChart.yLabelFont = FONT(12);
        _lineChart.yLabelColor = Chart_Gray;
        _lineChart.xLabelFont = FONT(12);
        _lineChart.xLabelColor = Color_Gray92;
        _lineChart.backgroundColor = [UIColor clearColor];
        _lineChart.showCoordinateAxis = YES;
        
        // added an examle to show how yGridLines can be enabled
        // the color is set to clearColor so that the demo remains the same
        _lineChart.yGridLinesColor = [UIColor clearColor];
        _lineChart.showYGridLines = YES;
    }
    return _lineChart;
}

- (UILabel*)xUnitLabel
{
    if (!_xUnitLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray92;
        _xUnitLabel = label;
    }
    return _xUnitLabel;
}

- (UILabel*)yUnitLabel
{
    if (!_yUnitLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray92;
        _yUnitLabel = label;
    }
    return _yUnitLabel;
}
@end
