//
//  MHomeModule2View.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHomeModule2View : UIView

//default to center
@property(nonatomic) NSTextAlignment textAlignment;
@property(nonatomic) UIFont *font;

- (void)reloadData:(NSDictionary *)viewData;
@end
