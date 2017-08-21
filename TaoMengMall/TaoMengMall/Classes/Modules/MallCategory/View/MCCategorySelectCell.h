//
//  MCCategoryDressSelectCell.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/21.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol MCCategorySelectCellDelegate <NSObject>
// temp除2 判断是价格高还是低 index 点击的tag
- (void)cellChooseIndex:(NSInteger)index withPriceUpOrDown:(NSInteger)temp keyName:(NSString *)name keyValue:(NSString *)keyValue;

@end

@interface MCCategorySelectCell : BaseCollectionViewCell

@property (nonatomic,weak) id <MCCategorySelectCellDelegate>delegate;

@property (nonatomic,assign) NSInteger temp;

@property (nonatomic,copy) NSString *index;

@end
