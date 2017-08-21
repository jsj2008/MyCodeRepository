//
//  SortPanelView.m
//  HongBao
//
//  Created by marco on 5/10/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "SortPanelView.h"

@interface SortPanelView ()

@property(nonatomic, strong) UIButton *customSortBtn;
@property(nonatomic, strong) UIButton *marketFirstBtn;
@property(nonatomic, strong) UIButton *displayModeBtn;
@property(nonatomic, strong) CAShapeLayer *indicatorLayer;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *backGroundView;
@property(nonatomic, strong) UIView *topShadowView;
@property(nonatomic, strong) UIView *bottomShadowView;
@property(nonatomic, strong) UIView *pipeShadowView;

@property(nonatomic, strong) NSArray *sortKinds;

@property(nonatomic, assign) BOOL show;
@property(nonatomic, assign) SortKind sortKind;
@property(nonatomic, assign) CSDisplayMode displayMode;
@end

@implementation SortPanelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.customSortBtn];
        [self.layer addSublayer:self.indicatorLayer];
        [self addSubview:self.marketFirstBtn];
        [self addSubview:self.displayModeBtn];
        
        [self addSubview:self.topShadowView];
        [self addSubview:self.bottomShadowView];
        [self addSubview:self.pipeShadowView];
        
        self.sortKinds = @[@"综合排序",@"价格从低到高",@"价格从高到低"];
        _sortKind = SortKindComprehensive;
        _displayMode = CSDisplayModeBig;
        _show = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.customSortBtn sizeToFit];
    self.customSortBtn.centerX = (SCREEN_WIDTH-44)/4;
    self.customSortBtn.centerY = self.height / 2;
    self.indicatorLayer.position = CGPointMake(self.customSortBtn.right + 10, self.customSortBtn.centerY);
    
    [self.marketFirstBtn sizeToFit];
    self.marketFirstBtn.centerX = (SCREEN_WIDTH-44)*3/4;
    self.marketFirstBtn.centerY = self.height / 2;
}

#pragma mark -Subviews
- (UIButton*)customSortBtn
{
    if (!_customSortBtn) {
        _customSortBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];

        [_customSortBtn addTarget:self action:@selector(handleCustomButton) forControlEvents:UIControlEventTouchUpInside];
        [_customSortBtn setTitle:@"综合排序" forState:UIControlStateNormal];
        [_customSortBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    return _customSortBtn;
}

- (UIButton*)marketFirstBtn
{
    if (!_marketFirstBtn) {
        _marketFirstBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];
        
        [_marketFirstBtn addTarget:self action:@selector(handleMarketButton) forControlEvents:UIControlEventTouchUpInside];
        [_marketFirstBtn setTitle:@"销量优先" forState:UIControlStateNormal];
        [_marketFirstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    return _marketFirstBtn;
}

- (UIButton*)displayModeBtn
{
    if (!_displayModeBtn) {
        _displayModeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 44, 0, 44, 44)];
        [_displayModeBtn addTarget:self action:@selector(handleDisplayButton) forControlEvents:UIControlEventTouchUpInside];
        [_displayModeBtn setImage:[UIImage imageNamed:@"btn_set_avatar"] forState:UIControlStateNormal];
    }
    return _displayModeBtn;
}

- (CAShapeLayer*)indicatorLayer
{
    if (!_indicatorLayer) {
        _indicatorLayer = [[CAShapeLayer alloc]init];
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(8, 0)];
        [path addLineToPoint:CGPointMake(4, 5)];
        [path closePath];
        
        _indicatorLayer.path = path.CGPath;
        _indicatorLayer.lineWidth = 1.0;
        _indicatorLayer.fillColor = [UIColor orangeColor].CGColor;
        
        CGPathRef bound = CGPathCreateCopyByStrokingPath(_indicatorLayer.path, nil, _indicatorLayer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, _indicatorLayer.miterLimit);
        _indicatorLayer.bounds = CGPathGetBoundingBox(bound);
        CGPathRelease(bound);
    }
    return _indicatorLayer;
}

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bottom, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = 44;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView*)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom,SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_backGroundView addGestureRecognizer:gesture];
    }
    return _backGroundView;
}

- (UIView*)topShadowView
{
    if (!_topShadowView) {
        _topShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        _topShadowView.backgroundColor = [UIColor lightGrayColor];
    }
    return _topShadowView;
}

- (UIView*)bottomShadowView
{
    if (!_bottomShadowView) {
        _bottomShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
        _bottomShadowView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomShadowView;
}

- (UIView*)pipeShadowView
{
    if (!_pipeShadowView) {
        _pipeShadowView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 0, 0.5, self.height)];
        _pipeShadowView.backgroundColor = [UIColor lightGrayColor];
    }
    return _pipeShadowView;
}

#pragma mark -button methods
- (void)handleCustomButton
{
    [self showDroupDownMenu:!self.show];
}

- (void)handleMarketButton
{
    //select market button
    [_marketFirstBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_customSortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _indicatorLayer.fillColor = [UIColor blackColor].CGColor;
    
    _sortKind = SortKindMarketFirst;
    
    //hide dropdrown menu if need
    [self showDroupDownMenu:NO];
}

- (void)handleDisplayButton
{
    [self showDroupDownMenu:NO];
    if (_displayMode == CSDisplayModeSmall) {
        _displayMode = CSDisplayModeBig;
        [self.displayModeBtn setImage:[UIImage imageNamed:@"btn_set_avatar"] forState:UIControlStateNormal];
    }else{
        _displayMode = CSDisplayModeSmall;
        [self.displayModeBtn setImage:[UIImage imageNamed:@"bk_media_card_normal"] forState:UIControlStateNormal];
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(sortPanelView:dispalyModeChanged:)]) {
        [self.delegate sortPanelView:self dispalyModeChanged:_displayMode];
    }

}

- (void)backgroundTapped:(UITapGestureRecognizer *)gesture
{
    [self showDroupDownMenu:NO];
}


#pragma mark -Animation
- (void)showDroupDownMenu:(BOOL)show
{
    self.show = show;
    [_tableView reloadData];
    [self animateIndicator];
    [self animateBackGroundView];
    [self animateTableView];
}

- (void)animateIndicator {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = self.show ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [_indicatorLayer addAnimation:anim forKey:anim.keyPath];
    } else {
        [_indicatorLayer addAnimation:anim forKey:anim.keyPath];
        [_indicatorLayer setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    [CATransaction commit];
}

- (void)animateBackGroundView{
    if (self.show) {
        [self.superview addSubview:self.backGroundView];
        [self.backGroundView.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [self.backGroundView removeFromSuperview];
        }];
    }
}

- (void)animateTableView{
    if (self.show) {
        [self.superview addSubview:self.tableView];
        
        CGFloat tableViewHeight = ([self.tableView numberOfRowsInSection:0] > 5) ? (5 *self.tableView.rowHeight) : ([self.tableView numberOfRowsInSection:0] * self.tableView.rowHeight);
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(0, self.bottom, self.width, tableViewHeight);
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.frame = CGRectMake(0, self.bottom, self.width, 0);
        } completion:^(BOOL finished) {
            [self.tableView removeFromSuperview];
        }];
    }
}


#pragma mark -UITableview DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sortKinds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DropDownMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self.sortKinds objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_sortKind == indexPath.row) {
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hud_success"]];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryView = nil;
    }
    return cell;
}

#pragma mark -UITableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _sortKind = (SortKind)indexPath.row;
    
    [_marketFirstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_customSortBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _indicatorLayer.fillColor = [UIColor orangeColor].CGColor;
    
    [self.customSortBtn setTitle:[self.sortKinds objectAtIndex:indexPath.row] forState:UIControlStateNormal];

    [self showDroupDownMenu:NO];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(sortPanelView:sortKindChanged:)]) {
        [self.delegate sortPanelView:self sortKindChanged:_sortKind];
    }
}

@end
