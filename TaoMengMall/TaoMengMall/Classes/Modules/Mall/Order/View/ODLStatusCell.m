//
//  ODLStatusCell.m
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODLStatusCell.h"

@interface ODLStatusCell ()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *line1View;
@property (nonatomic, strong) UIView *line2View;
@property (nonatomic, strong) UIView *pipe1View;
@property (nonatomic, strong) UIView *pipe2View;
@end

@implementation ODLStatusCell

- (void)drawCell
{
    [self cellAddSubView:self.bkgView];
    [self cellAddSubView:self.line1View];
    [self cellAddSubView:self.statusLabel];
    [self cellAddSubView:self.line2View];
    [self cellAddSubView:self.pipe1View];
    [self cellAddSubView:self.pipe2View];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        NSString *statusForShow = (NSString *)self.cellData;
        
        self.statusLabel.text = statusForShow;
        [self.statusLabel sizeToFit];
        self.statusLabel.left = 24;
        self.statusLabel.centerY = [ODLStatusCell heightForCell:statusForShow] / 2;
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 44;
    }
    return 0;
}

#pragma mark - Getters And Setters
- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 44)];
        view.backgroundColor = Color_Gray(234);
        _bkgView = view;
    }
    return _bkgView;
}

- (UIView *)line1View {
    
    if ( !_line1View ) {
        _line1View = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, LINE_WIDTH)];
        _line1View.backgroundColor = Color_Gray230;
    }
    
    return _line1View;
}

- (UIView *)line2View {
    
    if ( !_line2View ) {
        _line2View = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, LINE_WIDTH)];
        _line2View.backgroundColor = Color_Gray230;
        _line2View.bottom = 44;
    }
    
    return _line2View;
}

- (UILabel *)statusLabel {
    
    if ( !_statusLabel ) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _statusLabel.textColor = Color_Black;
        _statusLabel.font = FONT(14);
        _statusLabel.numberOfLines = 1;
    }
    
    return _statusLabel;
}

- (UIView*)pipe1View
{
    if (!_pipe1View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LINE_WIDTH, 44)];
        view.backgroundColor = Color_Gray238;
        _pipe1View = view;
    }
    return _pipe1View;
}

- (UIView*)pipe2View
{
    if (!_pipe2View) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-LINE_WIDTH, 0, LINE_WIDTH, 44)];
        view.backgroundColor = Color_Gray238;
        _pipe2View = view;
    }
    return _pipe2View;
}
@end
