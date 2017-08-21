//
//  MCCategoryDressSelectView.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCCategorySelectViewDeleget <NSObject>

// temp除2 判断是价格高还是低 index 点击的tag
- (void)viewChooseIndex:(NSInteger)index withPriceUpOrDown:(NSInteger)temp keyName:(NSString *)name keyValue:(NSString *)keyValue;

@end

@interface MCCategorySelectView : UIView

@property (nonatomic,weak) id <MCCategorySelectViewDeleget>delegate;

@property (nonatomic, strong) id cellData;
@property (nonatomic,copy) NSString *index;

@property (nonatomic,assign) NSInteger temp;

- (void)render;
@end
