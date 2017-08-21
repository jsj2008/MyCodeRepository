//
//  MCTopDressModulesCell.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/21.
//  Copyright © 2017年 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "MCCategoryModulesCell.h"
#import "MCCategoryModuleView.h"
#import "MCCategoryModuleModel.h"

#define PADDING (SCREEN_WIDTH-66*4)/5

@interface MCCategoryModulesCell()
@property (nonatomic,strong) UIView *lineView1;
@property (nonatomic,strong) UIView *pointView1;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *lineView2;
@property (nonatomic,strong) UIView *pointView2;
@property (nonatomic, strong) NSMutableArray *moduleViews;


@end

@implementation MCCategoryModulesCell



- (void)reloadData
{
	if (self.cellData) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        NSArray *modules = self.cellData;
        
        for (MCCategoryModuleView *moduleView in self.moduleViews) {
            [self cellAddSubview:moduleView];
        }
        
        for (int i = 0; i<modules.count; i++) {
            MCCategoryModuleView *module = [self.moduleViews safeObjectAtIndex:i];
            [module reloadData:[modules safeObjectAtIndex:i]];
        }
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        
        NSArray *modules = cellData;
        
        if (modules.count != 0 && modules.count < 5) {
            height = 18 + 110 +18;
        }else if (modules.count > 4) {
            height =  18 + 110 + 11 + 110 +18 ;
        }else {
            height = 0;
        }
	}
    return height;
}

#pragma mark - Subviews
- (UIView *)lineView1
{
	if (!_lineView1) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, LINE_WIDTH)];
		view.backgroundColor = Color_Gray(123);
		_lineView1 = view;
	}
	return _lineView1;
}

- (UIView *)pointView1
{
	if (!_pointView1) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 2)];
		view.backgroundColor = Color_Gray(123);
		_pointView1 = view;
	}
	return _pointView1;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(45);
		label.text = @"";
		[label sizeToFit];
        label.centerX =SCREEN_WIDTH /2;
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UIView *)lineView2
{
	if (!_lineView2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, LINE_WIDTH)];
        view.backgroundColor = Color_Gray(123);
		_lineView2 = view;
	}
	return _lineView2;
}

- (UIView *)pointView2
{
	if (!_pointView2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 2)];
        view.backgroundColor = Color_Gray(123);
		_pointView2 = view;
	}
	return _pointView2;
}

- (NSMutableArray*)moduleViews
{
    if (!_moduleViews) {
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:8];
        
        int row,column = 0;
        for (int i = 0; i<8; i++) {
            row = i/4;
            column = i%4;
            MCCategoryModuleView *moduleView = [[MCCategoryModuleView alloc]initWithFrame:CGRectMake(0, 0, 66, 110)];
            moduleView.left = PADDING + (66+PADDING)*column;
            moduleView.top = 18 + 110 * row + row *11;
            [modules addObject:moduleView];
        }
        
        _moduleViews = modules;
    }
    return _moduleViews;
}


@end
