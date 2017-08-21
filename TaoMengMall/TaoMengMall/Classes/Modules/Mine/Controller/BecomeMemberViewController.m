//
//  BecomeMemberViewController.m
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/17.
//  Copyright © 2017年 任梦晗. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "BecomeMemberViewController.h"
#import "MineRequest.h"

@interface BecomeMemberViewController ()

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIButton *buytButton;
@property (nonatomic,strong) VipResultModel *resultModel;
@property (nonatomic,assign) BOOL isVip;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *titleContent;
@property (nonatomic,strong) UILabel *hint;
@property (nonatomic,strong) UILabel *hintContent;
@end

@implementation BecomeMemberViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNavigationBar];
    
    self.view.backgroundColor = Color_Gray245;
    
    self.title = @"会员";
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];

}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    [MineRequest getVipDataWithParams:nil success:^(VipResultModel *resultModel) {
        
        if (resultModel) {
            self.isVip = resultModel.isVip;
            self.resultModel = resultModel;
            [self render];
        }
        
    } failure:^(StatusModel *status) {
       
        [self showNotice:status.msg];
    }];
}

- (void)render
{
	[self.view addSubview:self.backImageView];
//    [self.backImageView addSubview:self.titleLabel];
//    [self.backImageView addSubview:self.moneyLabel];
//    [self.backImageView addSubview:self.buytButton]
	[self.view addSubview:self.tipLabel];
	[self.view addSubview:self.moneyLabel];
	[self.view addSubview:self.buytButton];
    [self.view addSubview:self.hint];
    [self.view addSubview:self.hintContent];
    [self refreshView];
//    [self.view addSubview:self.titleLabel];
//    [self.view addSubview:self.titleContent];
}

- (void)refreshView
{
    if (self.isVip) {
        self.backImageView.image = [UIImage imageNamed:@"icon_ismember"];
        
        self.tipLabel.textColor = Color_Gray(51);
        self.tipLabel.text = self.resultModel.content;
        [self.tipLabel sizeToFit];
        self.tipLabel.centerX = SCREEN_WIDTH /2 ;
        self.tipLabel.top = self.view.bottom - 80;
        
        self.moneyLabel.hidden = YES;
        
        self.buytButton.hidden = YES;

    }else {
        self.backImageView.image = [UIImage imageNamed:@"icon_ismember"];
        
        self.tipLabel.textColor = Color_Gray(136);
        self.tipLabel.text = self.resultModel.content;
        [self.tipLabel sizeToFit];
        self.tipLabel.centerX = SCREEN_WIDTH /2 ;
        self.tipLabel.top = self.view.bottom - 120;
        
        self.moneyLabel.text = [NSString stringWithFormat:@"购买金额：%@元",self.resultModel.price];
        [self.moneyLabel sizeToFit];
        self.moneyLabel.centerX = SCREEN_WIDTH / 2;
        self.moneyLabel.hidden = NO;
        self.moneyLabel.top = self.tipLabel.bottom + 5;
        
        self.buytButton.hidden = NO;
        self.buytButton.top = self.moneyLabel.bottom +20;
        
    }
}

#pragma mark - Subviews

- (UILabel *)hint
{
    if (!_hint) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.text = @"温馨提示";
        label.textAlignment=NSTextAlignmentLeft;
        label.font = FONT(16);
        label.textColor = Color_Gray(99);
        [label sizeToFit];
        label.bottom = self.view.bottom - 250;
        if (IS_IPHONE5) {
            label.bottom = self.view.bottom - 210;

        }else if (IS_IPHONE6Plus) {
            label.bottom = self.view.bottom - 270;

        }else if (IS_IPHONE6) {
            label.bottom = self.view.bottom - 250;
        }
        label.left = 20;
        _hint = label;

    }
    return _hint;
}

- (UILabel *)hintContent
{
    if (!_hintContent) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.text = self.resultModel.tip;
        label.textAlignment=NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = Color_Gray113;
        label.numberOfLines = 0;
        if (IS_IPHONE5) {
            label.width = SCREEN_WIDTH-20;
            label.top = self.hint.bottom + 5;
        }else {
            label.width = SCREEN_WIDTH/2+20;
            label.top = self.hint.bottom + 15;

        }
        [label sizeToFit];
        label.left = 20;
        _hintContent = label;
    }
    return _hintContent;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.text = @"购买会员";
        label.font = FONT(20);
        [label sizeToFit];
        label.top = NAVBAR_HEIGHT + 50;
        label.right = SCREEN_WIDTH - 50;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)titleContent
{
    if (!_titleContent) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.text = @"获赠千元超值大礼包\n尊享全商城产品\n消费积分返还";
        label.numberOfLines= 3;
        label.textAlignment=NSTextAlignmentRight;
        label.font = FONT(16);
        label.textColor = Color_Gray(99);
        [label sizeToFit];
        label.top = self.titleLabel.bottom + 15;
        label.right = self.titleLabel.right;
        _titleContent = label;
    }
    return _titleContent;
}

- (UIImageView *)backImageView
{
	if (!_backImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 193, 197)];
        imageView.left =  10;
        imageView.width = SCREEN_WIDTH-20;
        imageView.height =(SCREEN_WIDTH-20)/0.56;
		imageView.top = NAVBAR_HEIGHT;
    
		_backImageView = imageView;
	}
	return _backImageView;
}

- (UILabel *)tipLabel
{
	if (!_tipLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray(136);
		
		_tipLabel = label;
	}
	return _tipLabel;
}

- (UILabel *)moneyLabel
{
	if (!_moneyLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray(136);
		
		_moneyLabel = label;
	}
	return _moneyLabel;
}

- (UIButton *)buytButton
{
	if (!_buytButton) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 124, 38)];
		button.layer.cornerRadius = 5;
		button.layer.masksToBounds = YES;
		button.backgroundColor = Theme_Color;
		[button setTitleColor:Color_White forState:UIControlStateNormal];
		button.titleLabel.font = FONT(16);
		[button setTitle:@"去购买" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(handleButButton:) forControlEvents:UIControlEventTouchUpInside];
        button.centerX = SCREEN_WIDTH /2 ;
        

		_buytButton = button;
	}
	return _buytButton;
}

#pragma mark - Actions
- (void)handleButButton:(UIButton*)button
{
    [MineRequest becomeMemberWithParams:nil success:^(NSDictionary *result) {
        
        if (result) {
            NSString *payId = [NSString stringWithFormat:@"%@",[result objectForKey:@"payId"]];
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"cashier?payId=%@&totalPrice=%@&vipPay=vipPay",payId,self.resultModel.price)];
        }
        
    } failure:^(StatusModel *status) {
       
        [self showNotice:status.msg];
    }];
}



@end
