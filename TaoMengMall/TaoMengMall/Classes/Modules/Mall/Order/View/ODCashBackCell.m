//
//  ODCashBackCell.m
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/16.
//  Copyright © 2017年 任梦晗. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "ODCashBackCell.h"
#import "ODCashBackModel.h"

@interface ODCashBackCell()

@property (nonatomic,strong) UIView *pointBgView;
@property (nonatomic,strong) UIView *pointView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UILabel *pointValueLabel;
@property (nonatomic,strong) UIImageView *moreImageView;
@property (nonatomic,strong) UILabel *returnPoint;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation ODCashBackCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_White;
        [self addSubview:self.pointBgView];
    }
    return self;
}

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.pointBgView];
	
}

- (void)reloadData
{
	if (self.cellData) {
        ODCashBackModel *cashbackModel = self.cellData;
//        cashbackModel = [[ODCashBackModel alloc]init];
//        cashbackModel.plan = @"返1000淘米 每日返还 最长300天返还啥啥啥啥啥啥所所所所所所所所所所所";
//        cashbackModel.current = @"2000";
    
        self.pointValueLabel.text = cashbackModel.plan;
        [self.pointValueLabel sizeToFit];
        
        self.returnPoint.text = cashbackModel.current;
        [self.returnPoint sizeToFit];
        self.returnPoint.right = self.moreImageView.left - 5;

        self.pointValueLabel.width = self.returnPoint.left - 8 - self.pointValueLabel.left;
        
        [self.pointView bk_whenTapped:^{
            [[TTNavigationService sharedService] openUrl:cashbackModel.link];
        }];
        
        
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 50;
	}
    return height;
}

#pragma mark - Subviews
- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50-LINE_WIDTH, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor =Color_Gray230;
        _lineView = view;
    }
    return _lineView;
}

- (UIView *)pointBgView
{
    if (!_pointBgView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = Color_Gray245;
        [view addSubview:self.pointView];
        [view addSubview:self.lineView];
        _pointBgView = view;
    }
    return _pointBgView;
}

- (UIView *)pointView
{
    if (!_pointView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
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
