//
//  ODTotalInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODTotalInfoCell.h"
#import "ODCashBackModel.h"
#import "ODPointUsageModel.h"

@interface ODTotalInfoCell ()

@property (nonatomic, strong) UIView *line1View;
@property (nonatomic, strong) UIView *line2View;
@property (nonatomic, strong) UIView *line3View;
@property (nonatomic, strong) UILabel *shippingFeeLabel;
@property (nonatomic, strong) UILabel *shippingFeeValueLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *totalPriceValueLabel;
@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UILabel *pointLabel;
@property (nonatomic, strong) UILabel *permanentPointLabel;
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic,strong) UIView *pointBgView;
@property (nonatomic,strong) UIView *pointView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UILabel *pointValueLabel;
@property (nonatomic,strong) UIImageView *moreImageView;
@property (nonatomic,strong) UILabel *returnPoint;

@property (nonatomic,strong) UILabel *serviceLabel;
@property (nonatomic,strong) UILabel *serviceValueLabel;

@property (nonatomic, strong) NSMutableArray *pointLabels;
@end

@implementation ODTotalInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.line1View];
    [self addSubview:self.line2View];
    [self addSubview:self.line3View];
    [self addSubview:self.shippingFeeLabel];
    [self addSubview:self.shippingFeeValueLabel];
    [self addSubview:self.totalPriceLabel];
    [self addSubview:self.totalPriceValueLabel];
    
    //[self addSubview:self.serviceLabel];
   // [self addSubview:self.serviceValueLabel];
    
   }

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSDictionary *data = (NSDictionary *)self.cellData;
        NSString *servicePrice =[data objectForKey:@"servicePrice"];

        self.shippingFeeValueLabel.text = [data objectForKey:@"shippingFee"];
        [self.shippingFeeValueLabel sizeToFit];
        self.shippingFeeValueLabel.centerY = self.shippingFeeLabel.centerY;
        self.shippingFeeValueLabel.right = SCREEN_WIDTH - 14;
        
//        if (IsEmptyString(servicePrice)) {
//            self.serviceLabel.hidden = YES;
//            self.serviceValueLabel.hidden = YES;
//            self.totalPriceLabel.centerY = 42+21;
//        }else {
//            self.totalPriceLabel.centerY = 42*2+21;
//        }
//
        self.totalPriceLabel.centerY = 42+21;

        self.totalPriceValueLabel.text = [data objectForKey:@"totalPrice"];
        [self.totalPriceValueLabel sizeToFit];
        self.totalPriceValueLabel.centerY = self.totalPriceLabel.centerY;
        self.totalPriceValueLabel.right = SCREEN_WIDTH - 14;
        
        self.serviceValueLabel.text = [data objectForKey:@"servicePrice"];
        [self.serviceValueLabel sizeToFit];
        self.serviceValueLabel.centerY = [[self class] heightForCell:data]/2;
        self.serviceValueLabel.right = SCREEN_WIDTH - 14;
        
       
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
//        NSDictionary *data = (NSDictionary *)cellData;
//        NSString *servicePrice =[data objectForKey:@"servicePrice"];
//        if (IsEmptyString(servicePrice)) {
//            return 42*2;
//        }else {
//            return 42*3;
//        }
        return 42 *2;
    }
    return 0;
}

#pragma mark - Getters And Setters

- (UIView *)line1View {
    
    if ( !_line1View ) {
        _line1View = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _line1View.backgroundColor = Color_Gray230;
        _line1View.bottom = 42;
    }
    
    return _line1View;
}

- (UIView *)line2View {
    
    if ( !_line2View ) {
        _line2View = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _line2View.backgroundColor = Color_Gray230;
        _line2View.bottom = 84;
    }
    
    return _line2View;
}

- (UIView *)line3View {
    
    if ( !_line3View ) {
        _line3View = [[UIView alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH-13*2, LINE_WIDTH)];
        _line3View.backgroundColor = Color_Gray230;
        _line3View.bottom = 42*3;
    }
    
    return _line3View;
}

- (UILabel *)shippingFeeLabel {
    
    if ( !_shippingFeeLabel ) {
        _shippingFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shippingFeeLabel.textColor = Color_Gray113;
        _shippingFeeLabel.font = FONT(14);
        _shippingFeeLabel.numberOfLines = 1;
        _shippingFeeLabel.text = @"快递运费：";
        [_shippingFeeLabel sizeToFit];
        _shippingFeeLabel.centerY = 21;
        _shippingFeeLabel.left = 14;
    }
    
    return _shippingFeeLabel;
}

- (UILabel *)shippingFeeValueLabel {
    
    if ( !_shippingFeeValueLabel ) {
        _shippingFeeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _shippingFeeValueLabel.textColor = Color_Gray113;
        _shippingFeeValueLabel.font = FONT(14);
        _shippingFeeValueLabel.numberOfLines = 1;
    }
    
    return _shippingFeeValueLabel;
}

- (UILabel *)totalPriceLabel {
    
    if ( !_totalPriceLabel ) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _totalPriceLabel.textColor = Color_Gray113;
        _totalPriceLabel.font = FONT(14);
        _totalPriceLabel.numberOfLines = 1;
        _totalPriceLabel.text = @"价格合计：";
        [_totalPriceLabel sizeToFit];
//        _totalPriceLabel.centerY = 42 *2 + 21;
        _totalPriceLabel.left = 14;
    }
    
    return _totalPriceLabel;
}

- (UILabel *)totalPriceValueLabel {
    
    if ( !_totalPriceValueLabel ) {
        _totalPriceValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _totalPriceValueLabel.textColor = Color_Gray113;
        _totalPriceValueLabel.font = FONT(14);
        _totalPriceValueLabel.numberOfLines = 1;
    }
    
    return _totalPriceValueLabel;
}

- (UILabel *)serviceLabel
{
    
    if ( !_serviceLabel ) {
        _serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _serviceLabel.textColor = Color_Gray113;
        _serviceLabel.font = FONT(14);
        _serviceLabel.numberOfLines = 1;
        _serviceLabel.text = @"服务费：";
        [_serviceLabel sizeToFit];
        _serviceLabel.centerY = 42 + 21;
        _serviceLabel.left = 14;
    }
    
    return _serviceLabel;
}

- (UILabel *)serviceValueLabel
{
    if ( !_serviceValueLabel ) {
        _serviceValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _serviceValueLabel.textColor = Color_Gray113;
        _serviceValueLabel.font = FONT(14);
        _serviceValueLabel.numberOfLines = 1;
    }
    
    return _serviceValueLabel;
}

- (UILabel *)orderTimeLabel {
    
    if ( !_orderTimeLabel ) {
        _orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _orderTimeLabel.textColor = Color_Gray153;
        _orderTimeLabel.font = FONT(14);
        _orderTimeLabel.numberOfLines = 1;
    }
    
    return _orderTimeLabel;
}

- (UILabel*)pointLabel
{
    if (!_pointLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.numberOfLines = 1;
        _pointLabel = label;
    }
    return _pointLabel;
}


- (UILabel*)permanentPointLabel
{
    if (!_permanentPointLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.numberOfLines = 1;
        _permanentPointLabel = label;
    }
    return _permanentPointLabel;
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

- (UIView *)pointBgView
{
    if (!_pointBgView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 42*3, SCREEN_WIDTH, 70)];
        view.backgroundColor = Color_Gray245;
        [view addSubview:self.pointView];
        _pointBgView = view;
    }
    return _pointBgView;
}

- (UIView *)pointView
{
    if (!_pointView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
        view.backgroundColor = Color_White;
        view.userInteractionEnabled = YES;
        
        [view addSubview:self.tipLabel];
        [view addSubview:self.pointValueLabel];
        [view addSubview:self.moreImageView];
        [view addSubview:self.returnPoint];
        _pointView = view;
    }
    return _pointView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Theme_Color;
        label.numberOfLines = 1;
        label.text = @" 返利 ";
        [label sizeToFit];
        label.layer.cornerRadius = 2.;
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = 1.;
        label.layer.borderColor = Theme_Color.CGColor;
        label.centerY = 25;
        label.left = 12;
        _tipLabel = label;
    }
    return _tipLabel;
}

- (UILabel *)pointValueLabel
{
    if (!_pointValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray(62);
        label.text = @"返积分100点 每日返还 最长300天返完";
        [label sizeToFit];
        label.centerY = 25;
        label.left = self.tipLabel.right + 5;
        _pointValueLabel = label;
    }
    return _pointValueLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = 25;
        _moreImageView.right = SCREEN_WIDTH - 15;
    }
    
    return _moreImageView;
}

- (UILabel *)returnPoint
{
    if (!_returnPoint) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray(181);
        label.text = @"已返300";
        [label sizeToFit];
        label.centerY = 25;
        label.right = self.moreImageView.left - 5;
        _returnPoint = label;
    }
    return _returnPoint;
}


@end
