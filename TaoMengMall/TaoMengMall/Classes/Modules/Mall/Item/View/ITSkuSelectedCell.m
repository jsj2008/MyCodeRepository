//
//  ITSkuSelectedCell.m
//  FlyLantern
//
//  Created by marco on 10/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "ITSkuSelectedCell.h"

@interface ITSkuSelectedCell ()

@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UILabel *selectedValueLabel;

@property (nonatomic, strong) UILabel *unselectedLabel;
@property (nonatomic, strong) UILabel *unselectedValueLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@end

@implementation ITSkuSelectedCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.selectedLabel];
	[self cellAddSubView:self.selectedValueLabel];
	[self cellAddSubView:self.unselectedLabel];
	[self cellAddSubView:self.unselectedValueLabel];
	[self cellAddSubView:self.moreImageView];
}

- (void)reloadData
{
	if (self.cellData) {
        NSArray *skus = (NSArray*)self.cellData;
        
        NSMutableArray *selectedSkus = [NSMutableArray array];
        NSMutableArray *unselectedSkus = [NSMutableArray array];
        for (NSDictionary *dict in skus) {
            NSString *key = [[dict allKeys] safeObjectAtIndex:0];
            NSString *value = [dict objectForKey:key];
            if (IsEmptyString(value)) {
                [unselectedSkus addObject:dict];
            }else{
                [selectedSkus addObject:dict];
            }
        }
        
        NSString *selectedSkuKey = @"";
        for (NSDictionary *dict in selectedSkus) {
            NSString *key = [[dict allKeys] safeObjectAtIndex:0];
            NSString *value = [dict objectForKey:key];
            selectedSkuKey = [selectedSkuKey stringByAppendingFormat:@" \"%@\"",value];
        }
        self.selectedValueLabel.text = selectedSkuKey;
        [self.selectedValueLabel sizeToFit];
        
        NSString *unselectedSkuName = @"";
        for (NSDictionary *dict in unselectedSkus) {
            NSString *key = [[dict allKeys] safeObjectAtIndex:0];
            unselectedSkuName = [unselectedSkuName stringByAppendingFormat:@" %@",key];
        }
        self.unselectedValueLabel.text = unselectedSkuName;
        [self.unselectedValueLabel sizeToFit];
        
        if (unselectedSkus.count == skus.count) {
            self.unselectedLabel.text = @"请选择";
            [self.unselectedLabel sizeToFit];

            self.selectedLabel.text = @"";
            
            self.unselectedLabel.left = 12;
            self.unselectedValueLabel.left = self.unselectedLabel.right + 4;
            
        }else if (selectedSkus.count == skus.count) {
            self.selectedLabel.text = @"已选择";
            [self.selectedLabel sizeToFit];

            self.unselectedLabel.text = @"";
            
            self.selectedLabel.left = 12;
            self.selectedValueLabel.left = self.selectedLabel.right + 4;
            
        }else{
            self.selectedLabel.text = @"已选择";
            [self.selectedLabel sizeToFit];

            self.unselectedLabel.text = @"请选择";
            [self.unselectedLabel sizeToFit];

            self.selectedLabel.left = 12;
            
            self.selectedValueLabel.text = [NSString stringWithFormat:@"%@，",selectedSkuKey];
            [self.selectedValueLabel sizeToFit];
            self.selectedValueLabel.left = self.selectedLabel.right + 4;
            
            self.unselectedLabel.left = self.selectedValueLabel.right - 4;
            self.unselectedValueLabel.left = self.unselectedLabel.right + 4;
        }
        
        self.selectedLabel.centerY = 25;
        self.unselectedLabel.centerY = 25;
        self.selectedValueLabel.centerY = 25;
        self.unselectedValueLabel.centerY = 25;
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
- (UILabel *)selectedLabel
{
	if (!_selectedLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(178);
		_selectedLabel = label;
	}
	return _selectedLabel;
}

- (UILabel *)selectedValueLabel
{
	if (!_selectedValueLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Black;
		_selectedValueLabel = label;
	}
	return _selectedValueLabel;
}

- (UILabel *)unselectedLabel
{
	if (!_unselectedLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(62);
		_unselectedLabel = label;
	}
	return _unselectedLabel;
}

- (UILabel *)unselectedValueLabel
{
	if (!_unselectedValueLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(62);
		_unselectedValueLabel = label;
	}
	return _unselectedValueLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.right = SCREEN_WIDTH -12;
        _moreImageView.centerY = 25;
    }
    
    return _moreImageView;
}

@end
