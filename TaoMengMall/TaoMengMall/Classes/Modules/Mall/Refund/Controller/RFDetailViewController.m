//
//  RFDetailViewController.m
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RFDetailViewController.h"
#import "RefundRequest.h"
#import "RFDetailResultModel.h"

@interface RFDetailViewController ()
@property (nonatomic, strong) RFDetailResultModel *detailModel;

@property (nonatomic, strong) UIView *bkgView1;
@property (nonatomic, strong) UIView *bkgView2;
@property (nonatomic, strong) UILabel *tradeLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *refundLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *oRefundLabel;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;


@property (nonatomic, strong) UILabel *tradeNameLabel;
@property (nonatomic, strong) UILabel *orderNoLabel;
@property (nonatomic, strong) UILabel *refundSumLabel;
@property (nonatomic, strong) UILabel *timeValueLabel;
@property (nonatomic, strong) UILabel *oRefundSumLabel;

@property (nonatomic, strong) UIButton *okButton;
@end

@implementation RFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];

    self.title = @"退款详情";
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.orderId forKey:@"orderId"];
    
    [RefundRequest getRefundDetailWithParams:params success:^(RFDetailResultModel *resultModel) {
        self.detailModel = resultModel;
        [self render];
        
    } failure:^(StatusModel *status) {
        
    }];
}

- (void)render
{
    [self.view addSubview:self.bkgView1];
    [self.bkgView1 addSubview:self.tradeLabel];
    [self.bkgView1 addSubview:self.orderLabel];
    [self.bkgView1 addSubview:self.refundLabel];
    [self.bkgView1 addSubview:self.timeLabel];
    [self.bkgView1 addSubview:self.tradeNameLabel];
    [self.bkgView1 addSubview:self.orderNoLabel];
    [self.bkgView1 addSubview:self.refundSumLabel];
    [self.bkgView1 addSubview:self.timeValueLabel];
    [self.bkgView1 addSubview:self.line1];
    [self.bkgView1 addSubview:self.line2];
    [self.bkgView1 addSubview:self.line3];

    
    [self.view addSubview:self.bkgView2];
    [self.bkgView2 addSubview:self.oRefundLabel];
    [self.bkgView2 addSubview:self.oRefundSumLabel];
    
    [self.view addSubview:self.okButton];
    
    //赋值
    self.tradeNameLabel.text = self.detailModel.desc;
    self.orderNoLabel.text = self.detailModel.orderId;
    self.refundSumLabel.text = self.detailModel.price;
    self.timeValueLabel.text = self.detailModel.refundTime;
    self.oRefundSumLabel.text = self.detailModel.refundPriceByOldWay;
    
    //适应大小
    [self.tradeNameLabel sizeToFit];
    self.tradeNameLabel.width = SCREEN_WIDTH - 2 - self.tradeLabel.right - 12;
    [self.orderNoLabel sizeToFit];
    self.orderNoLabel.width = SCREEN_WIDTH - 2 - self.orderLabel.right - 12;
    [self.refundSumLabel sizeToFit];
    self.refundSumLabel.width = SCREEN_WIDTH - 2 - self.refundLabel.right - 12;
    [self.timeValueLabel sizeToFit];
    self.timeValueLabel.width = SCREEN_WIDTH - 2 - self.timeLabel.right - 12;
    [self.oRefundSumLabel sizeToFit];
    self.oRefundSumLabel.width = SCREEN_WIDTH - 2 - self.oRefundLabel.right - 12;
    
    self.tradeLabel.centerY = 25;
    self.orderLabel.centerY = 75;
    self.refundLabel.centerY = 125;
    self.timeLabel.centerY = 175;
    self.oRefundLabel.centerY = 25;
    
    self.tradeNameLabel.centerY = self.tradeLabel.centerY;
    self.orderNoLabel.centerY = self.orderLabel.centerY;
    self.refundSumLabel.centerY = self.refundLabel.centerY;
    self.timeValueLabel.centerY = self.timeLabel.centerY;
    self.oRefundSumLabel.centerY = self.oRefundLabel.centerY;
    
    self.tradeNameLabel.right = SCREEN_WIDTH - 12;
    self.orderNoLabel.right = SCREEN_WIDTH - 12;
    self.refundSumLabel.right = SCREEN_WIDTH - 12;
    self.timeValueLabel.right = SCREEN_WIDTH -12;
    self.oRefundSumLabel.right = SCREEN_WIDTH - 12;
}

#pragma mark - Subviews

- (UIView*)bkgView1
{
    if (!_bkgView1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 201)];
        view.backgroundColor = Color_White;
        _bkgView1 = view;
    }
    return _bkgView1;
}

- (UIView*)bkgView2
{
    if (!_bkgView2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT + 201 + 14, SCREEN_WIDTH, 51)];
        view.backgroundColor = Color_White;
        _bkgView2 = view;
    }
    return _bkgView2;
}

- (UIView*)line1
{
    if (!_line1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 50, SCREEN_WIDTH - 12, LINE_WIDTH)];
        view.backgroundColor = Color_Gray153;
        _line1 = view;
    }
    return _line1;
}

- (UIView*)line2
{
    if (!_line2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 100, SCREEN_WIDTH - 12, LINE_WIDTH)];
        view.backgroundColor = Color_Gray153;
        _line2 = view;
    }
    return _line2;
}

- (UIView*)line3
{
    if (!_line3) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 150, SCREEN_WIDTH - 12, LINE_WIDTH)];
        view.backgroundColor = Color_Gray153;
        _line3 = view;
    }
    return _line3;
}


- (UILabel*)tradeLabel
{
    if (!_tradeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"交易说明：";
        [label sizeToFit];
        _tradeLabel = label;
    }
    return _tradeLabel;
}

- (UILabel*)orderLabel
{
    if (!_orderLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"订单编号：";
        [label sizeToFit];
        _orderLabel = label;
    }
    return _orderLabel;
}

- (UILabel*)refundLabel
{
    if (!_refundLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"退款金额：";
        [label sizeToFit];
        _refundLabel = label;
    }
    return _refundLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"退款时间：";
        [label sizeToFit];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel*)oRefundLabel
{
    if (!_oRefundLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"原路退款金额：";
        [label sizeToFit];
        _oRefundLabel = label;
    }
    return _oRefundLabel;
}

- (UILabel*)tradeNameLabel
{
    if (!_tradeNameLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.textAlignment = NSTextAlignmentRight;
        [label sizeToFit];
        _tradeNameLabel = label;
    }
    return _tradeNameLabel;
}

- (UILabel*)orderNoLabel
{
    if (!_orderNoLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.textAlignment = NSTextAlignmentRight;
        [label sizeToFit];
        _orderNoLabel = label;
    }
    return _orderNoLabel;
}

- (UILabel*)refundSumLabel
{
    if (!_refundSumLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.textAlignment = NSTextAlignmentRight;
        [label sizeToFit];
        _refundSumLabel = label;
    }
    return _refundSumLabel;
}

- (UILabel*)timeValueLabel
{
    if (!_timeValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.textAlignment = NSTextAlignmentRight;
        [label sizeToFit];
        _timeValueLabel = label;
    }
    return _timeValueLabel;
}

- (UILabel*)oRefundSumLabel
{
    if (!_oRefundSumLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.textAlignment = NSTextAlignmentRight;
        [label sizeToFit];
        _oRefundSumLabel = label;
    }
    return _oRefundSumLabel;
}

- (UIButton*)okButton
{
    if (!_okButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(12, NAVBAR_HEIGHT + 201 + 14 + 51 + 30, SCREEN_WIDTH-12*2, 46)];
        button.titleLabel.font = FONT(16);
        button.backgroundColor = Theme_Color;
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds = YES;
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:Color_White forState:UIControlStateNormal];
        [button addTarget:self action:@selector(okButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _okButton = button;
    }
    return _okButton;
}

#pragma mark - Subviews
- (void)okButtonTapped
{
    [self clickback];
}
@end
