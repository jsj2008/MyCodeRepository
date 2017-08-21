//
//  CSCouponSelectView.m
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CSCouponSelectView.h"
#import "CSPlatformCouponModel.h"
#import "CSCouponInfoCell.h"

#define CONTAINER_HEIGHT 420

@interface CSCouponSelectView ()<UITableViewDelegate,UITableViewDataSource,CSCouponInfoCellDelegate>
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation CSCouponSelectView

- (instancetype)initWithCoupons:(NSArray *)coupons
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        _coupons = [NSMutableArray array];
        [_coupons addObjectsFromSafeArray:coupons];
        
        [self render];
    }
    return self;
}

- (instancetype)init
{
    return [[[self class]alloc]initWithFrame:CGRectZero];
}

- (void)render
{
    self.userInteractionEnabled = YES;
    [self addSubview:self.maskView];
    [self addSubview:self.containerView];
}

#pragma mark - Subviews

- (UIView *)maskView {
    
    if ( !_maskView ) {
        _maskView = [[UIView alloc] initWithFrame:self.frame];
        _maskView.backgroundColor = RGBA(0, 0, 0, 0.2);
        _maskView.userInteractionEnabled = YES;
        
        weakify(self);
        [_maskView bk_whenTapped:^{
            strongify(self);
            [self cancelButtonTapped];
        }];
    }
    
    return _maskView;
}

- (UIView *)containerView {
    
    if ( !_containerView ) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CONTAINER_HEIGHT, SCREEN_WIDTH, CONTAINER_HEIGHT)];
        _containerView.backgroundColor = Color_White;
        _containerView.userInteractionEnabled = YES;
        
        [_containerView addSubview:self.titleLable];
        self.titleLable.centerX = SCREEN_WIDTH/2;
        self.titleLable.top = 8;
        [_containerView addSubview:self.tableView];
        [_containerView addSubview:self.bottomButton];
    }
    return _containerView;
}

- (UILabel*)titleLable
{
    if (!_titleLable) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"选择优惠券";
        [label sizeToFit];
        _titleLable = label;
    }
    return _titleLable;
}


- (UITableView *)tableView {
    
    if ( !_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, CONTAINER_HEIGHT - 44 * 2)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton*)bottomButton
{
    if (!_bottomButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, CONTAINER_HEIGHT - 44, SCREEN_WIDTH, 44)];
        button.backgroundColor = Color_Orange3;
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _bottomButton = button;
    }
    return _bottomButton;
}


#pragma mark - public methods


- (void)show
{
    [[ApplicationEntrance shareEntrance].window addSubview:self];
    
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        strongify(self);
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT - CONTAINER_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)dismiss
{
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        strongify(self);
        
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        
    } completion:^(BOOL finished) {
        
        strongify(self);
        [self removeFromSuperview];
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.coupons.count+1;
}

- (BaseTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSPlatformCouponModel *model = [self.coupons safeObjectAtIndex:indexPath.row];
    if (model) {
        CSCouponInfoCell *cell = [CSCouponInfoCell dequeueReusableCellForTableView:tableView];
        cell.cellData = model;
        cell.delegate = self;
        [cell reloadData];
        return cell;
    }
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat height = 0;
    CSPlatformCouponModel *model = [self.coupons safeObjectAtIndex:indexPath.row];
    if (model) {
        height = [CSCouponInfoCell heightForCell:model];
    }else{
        height = 14;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSCouponInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self didTapCheckButtonInCell:cell];
}

#pragma mark - CSCouponInfoCellDelegate
- (void)didTapCheckButtonInCell:(CSCouponInfoCell*)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    CSPlatformCouponModel *couponInfo = [self.coupons safeObjectAtIndex:indexPath.row];
    if (couponInfo) {
        couponInfo.selected = !couponInfo.selected;
        if (couponInfo.selected) {
            for (CSPlatformCouponModel *model in self.coupons) {
                if (model != couponInfo) {
                    model.selected = NO;
                }
            }
        }
    }
    [self.tableView reloadData];
}

#pragma mark - Button actions
- (void)cancelButtonTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishSelectingCoupon)]) {
        [self.delegate didFinishSelectingCoupon];
    }
    [self dismiss];
}

@end
