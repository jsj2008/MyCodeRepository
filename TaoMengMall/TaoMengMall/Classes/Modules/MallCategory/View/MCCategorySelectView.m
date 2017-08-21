//
//  MCCategoryDressSelectView.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MCCategorySelectView.h"
#import "MCCategorySiftModel.h"
#import "MCCategorySiftKeyModel.h"
#import "MCCategorySiftOptionModel.h"

@interface MCCategorySelectView()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,strong) UIButton *selectButton;
@property (nonatomic,strong) UIImageView *upView;
@property (nonatomic,strong) UIImageView *downView;

@end

@implementation MCCategorySelectView

- (void)render
{
    NSString *index =(NSString *) self.index;
    
    [self addSubview:self.bgView];
    
    NSArray *cellData = self.cellData;
    //        NSArray *tabs = @[@"综合",@"销量",@"新品",@"价格"];
    
    for (int i = 0; i < cellData.count; i++) {
        UIButton *button = [self.buttons safeObjectAtIndex:i];
        MCCategorySiftModel *model =[cellData safeObjectAtIndex:i];
        MCCategorySiftKeyModel *key =model.key;
        
        [button setTitle:key.desc forState:UIControlStateNormal];
        
        [self.bgView addSubview:button];
        if ([key.desc isEqualToString:@"价格"]) {
            [button addSubview:self.upView];
            [button addSubview:self.downView];
            CGSize titleSize = [key.desc sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize: 14.0f]}];
            self.upView.left = button.width / 2 +titleSize.width/2 + 2;
            self.upView.bottom = button.height/2 ;
            
            self.downView.left =button.width / 2 +titleSize.width/2 + 2;
            self.downView.top =button.height/2 ;
        }
        
    }
    if (cellData) {
        UIButton *selectBtn = (UIButton *)[self.bgView viewWithTag:[index integerValue]];
        [self buttonClick:selectBtn needDelegate:NO];
    }
   
}


#pragma mark - Subviews
- (UIView *)bgView
{
    if (!_bgView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 45)];
        view.backgroundColor = Color_White;
        _bgView = view;
    }
    return _bgView;
}

- (UIImageView *)downView
{
    if (!_downView) {
        _downView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 16)];
        _downView.image =[UIImage imageNamed:@"pricedown_unselect"];
        [_downView sizeToFit];
    }
    return _downView;
}

- (UIImageView *)upView
{
    if (!_upView) {
        _upView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _upView.image =[UIImage imageNamed:@"priceup_unselect"];
        [_upView sizeToFit];
    }
    return _upView;
}

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        NSMutableArray *arr = [NSMutableArray array];
       
        
        NSArray *siftsArray = self.cellData;

        CGFloat width = SCREEN_WIDTH / siftsArray.count;
        for (int i = 0; i < siftsArray.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 45)];
            button.top = 0;
            button.left = i * width;
            button.tag = i + 1;
            
            [button setTitleColor:Color_Gray(153) forState:UIControlStateNormal];
            [button setTitleColor:Theme_Color forState:UIControlStateSelected];
            button.titleLabel.font = FONT(14);
            weakify(self);
            [button bk_whenTapped:^{
                strongify(self);
                [self buttonClick:button needDelegate:YES];
            }];
            
           
            
            [arr addObject:button];
        }
        _buttons = arr;
    }
    return _buttons;
}

#pragma mark - action

- (void)buttonClick:(UIButton *)button needDelegate:(BOOL)need
{
    
    NSArray *siftArray = self.cellData;
    MCCategorySiftModel *model =[siftArray safeObjectAtIndex:button.tag - 1];
    MCCategorySiftKeyModel *key =model.key;
    NSArray *options =model.options;
    
    if (button == self.selectButton && (![button.titleLabel.text isEqualToString:@"价格"])) {
        return;
    }else if ([button.titleLabel.text isEqualToString:@"价格"]) {
        
        if (need) {
            _temp ++;
            MCCategorySiftOptionModel *option ;
            if (_temp %2 != 0) {
                option = [options safeObjectAtIndex:1];
            }else {
                option = [options safeObjectAtIndex:0];
            }
            if ([self.delegate respondsToSelector:@selector(viewChooseIndex:withPriceUpOrDown:keyName:keyValue:)]) {
                [self.delegate viewChooseIndex:button.tag withPriceUpOrDown:_temp keyName:key.name keyValue:option.value];
            }
        }
        // 更新价格高低排序图标
        if (_temp % 2 != 0) {
            self.upView.image = [UIImage imageNamed:@"priceup_select"];
            self.downView.image = [UIImage imageNamed:@"pricedown_unselect"];
            
        }else {
            self.upView.image = [UIImage imageNamed:@"priceup_unselect"];
            self.downView.image = [UIImage imageNamed:@"pricedown_select"];
        }
    }
    self.selectButton.selected = NO;
    NSLog(@"%@",[button class]);
    button.selected = YES;
    self.selectButton = button;
    
    if (![button.titleLabel.text isEqualToString:@"价格"]) {
        _temp = 0;
        self.upView.image = [UIImage imageNamed:@"priceup_unselect"];
        self.downView.image = [UIImage imageNamed:@"pricedown_unselect"];
        
        if (need) {
            MCCategorySiftOptionModel *option = [options safeObjectAtIndex:0];
            if ([self.delegate respondsToSelector:@selector(viewChooseIndex:withPriceUpOrDown:keyName:keyValue:)]) {
                [self.delegate viewChooseIndex:button.tag withPriceUpOrDown:_temp keyName:key.name keyValue:option.value];
            }
        }
        
    }
    
}


@end
