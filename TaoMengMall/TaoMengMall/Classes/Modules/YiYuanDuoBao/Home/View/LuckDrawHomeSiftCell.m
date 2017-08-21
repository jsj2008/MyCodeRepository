//
//  DHChildSiftCell.m
//  BabyDaily
//
//  Created by marco on 9/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "LuckDrawHomeSiftCell.h"

@interface LuckDrawHomeSiftCell ()
@property (nonatomic, strong) UILabel *popularLabel;
@property (nonatomic, strong) UILabel *lastestLabel;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *line;
@end

@implementation LuckDrawHomeSiftCell

- (void)reloadData
{
    self.backgroundColor = Color_White;
    if (self.cellData) {
        
        NSString *siftType = (NSString*)self.cellData;
        
        [self cellAddSubview:self.popularLabel];
        [self cellAddSubview:self.lastestLabel];
        [self cellAddSubview:self.progressLabel];
        [self cellAddSubview:self.indicatorView];
        [self cellAddSubview:self.line];
        
        self.lastestLabel.right = SCREEN_WIDTH - 32;
        self.lastestLabel.centerY = 19;
        
        self.progressLabel.centerX = SCREEN_WIDTH/2;
        self.progressLabel.centerY = 19;
        
        self.popularLabel.left = 32;
        self.popularLabel.centerY = 19;
        
        self.indicatorView.top = self.popularLabel.bottom;
        
        self.line.bottom = [[self class] heightForCell:self.cellData];
        
        [self selectSiftType:siftType animated:NO];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 42;
    }
    return height;
}

#pragma mark - Private

- (void)selectSiftType:(NSString*)type animated:(BOOL)animated
{
    CGFloat newX = 0;
    
    if ([type isEqualToString:@"0"]) {
        self.popularLabel.textColor = Color_Black;
        self.lastestLabel.textColor = Color_Gray125;
        self.progressLabel.textColor = Color_Gray125;
        
        newX = self.popularLabel.centerX;
    }else if ([type isEqualToString:@"1"]) {
        self.popularLabel.textColor = Color_Gray125;
        self.lastestLabel.textColor = Color_Gray125;
        self.progressLabel.textColor = Color_Black;
        
        newX = self.progressLabel.centerX;
    }else if ([type isEqualToString:@"2"]) {
        self.popularLabel.textColor = Color_Gray125;
        self.lastestLabel.textColor = Color_Black;
        self.progressLabel.textColor = Color_Gray125;
        
        newX = self.lastestLabel.centerX;
    }
    
    if (animated) {
        
        [UIView animateWithDuration:.3 animations:^{
            self.indicatorView.centerX = newX;
        }];
        
        if([self.delegate respondsToSelector:@selector(siftTypeChange:)])
        {
            [self.delegate siftTypeChange:type];
        }
        
    }else{
        self.indicatorView.centerX = newX;
    }
}

#pragma mark -Subviews

- (UILabel*)popularLabel
{
    if (!_popularLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32, 8, 70, 24)];
        label.font = FONT(14);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"人气";
        label.userInteractionEnabled = YES;
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            [self selectSiftType:@"0" animated:YES];
        }];
        _popularLabel = label;
    }
    return _popularLabel;
}

- (UILabel*)progressLabel
{
    if (!_progressLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, 70, 24)];
        label.font = FONT(14);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"进度";
        label.userInteractionEnabled = YES;
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            [self selectSiftType:@"1" animated:YES];
        }];
        _progressLabel = label;
    }
    return _progressLabel;
}

- (UILabel*)lastestLabel
{
    if (!_lastestLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, 70, 24)];
        label.font = FONT(14);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"最新";
        label.userInteractionEnabled = YES;
        weakify(self)
        [label bk_whenTapped:^{
            strongify(self);
            [self selectSiftType:@"2" animated:YES];
        }];
        _lastestLabel = label;
    }
    return _lastestLabel;
}

- (UIView*)indicatorView
{
    if (!_indicatorView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 76, 4)];
        view.backgroundColor = Theme_Color;
        _indicatorView = view;
    }
    return _indicatorView;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        _line = view;
    }
    return _line;
}
@end
