//
//  RFLastStatusCell.m
//  Refound
//
//  Created by marco on 6/6/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RFLastStatusCell.h"
#import "RefundInfoModel.h"

@interface RFLastStatusCell ()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) NSTimer *downCountTimer;
@property (nonatomic, assign) NSInteger seconds;
//
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *applyButton;
@property (nonatomic, strong) UILabel *youcanLabel;
@end

@implementation RFLastStatusCell

- (void)removeFromSuperview
{
    [self.downCountTimer invalidate];
    self.downCountTimer = nil;
    [super removeFromSuperview];
}

- (void)drawCell
{
    self.backgroundColor = Color_Gray245;

    //主要视图
    [self addSubview:self.bkgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.line];
    [self addSubview:self.contentLabel];
    
    //附加视图
    [self addSubview:self.recordButton];
    [self addSubview:self.cancelButton];
    [self addSubview:self.applyButton];
    [self addSubview:self.youcanLabel];
}



- (void)reloadData
{
    if (self.cellData) {
        RefundInfoModel *model = (RefundInfoModel*)self.cellData;
        self.bkgView.height = [RFLastStatusCell heightForCell:model];

        self.titleLabel.text = model.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = 25;
        self.titleLabel.left = self.bkgView.left + 20;
        
        self.contentLabel.width = self.bkgView.width - 12*2;
        
        NSString *content = @"";
        self.contentLabel.text = content;
        self.contentLabel.height = [RFLastStatusCell heightForContentLabel:content];
        self.contentLabel.top = self.line.bottom + 12;
        self.contentLabel.left = self.bkgView.left + 20;
        
        self.applyButton.hidden = YES;
        self.cancelButton.hidden = YES;
        self.youcanLabel.hidden = YES;
        self.recordButton.hidden = YES;
        
        //1:申请，可取消           显示倒计时、取消申请
        //2:用户取消，再次申请页面   不会进入history页面
        //3:商家接受，处理中        不显示按钮
        //5:申请结束，完成申请       显示查看记录
        //6:商家拒绝，处理中         显示再次申请
        NSString *status = self.status;
//status = @"6";
        if ([status isEqualToString:@"1"]) {
            self.cancelButton.hidden = NO;
            self.cancelButton.top = self.contentLabel.bottom + 8;
            self.cancelButton.centerX = SCREEN_WIDTH/2;
            
            [self startTimer];
        }else if ([status isEqualToString:@"6"]) {
            if (_downCountTimer) {
                [_downCountTimer invalidate];
                _downCountTimer = nil;
            }
            self.contentLabel.text = @"商家拒绝了你的退款申请";
            self.contentLabel.height = [RFLastStatusCell heightForContentLabel:self.contentLabel.text];

            self.youcanLabel.hidden = NO;
            self.applyButton.hidden = NO;
            
            self.applyButton.top = self.contentLabel.bottom + 8;
            self.applyButton.left = self.youcanLabel.right + 6;
            self.youcanLabel.centerY = self.applyButton.centerY;
            
        }
//        else if ([status isEqualToString:@"3"]) {
//            
//            self.contentLabel.text = @"商家已接受您的退款请求，正在处理中";
//            self.contentLabel.height = [RFLastStatusCell heightForContentLabel:self.contentLabel.text];
//   
//        }
        else if ([status isEqualToString:@"5"]||[status isEqualToString:@"3"]||[status isEqualToString:@"4"]) {
            if (_downCountTimer) {
                [_downCountTimer invalidate];
                _downCountTimer = nil;
            }
            self.contentLabel.text = @"商家已接受您的退款请求";
            self.contentLabel.height = [RFLastStatusCell heightForContentLabel:self.contentLabel.text];
            
            self.recordButton.hidden = NO;
            self.recordButton.top = self.contentLabel.bottom + 8;
            self.recordButton.centerX = SCREEN_WIDTH/2;
            
        }

    }
}



+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        RefundInfoModel *model = (RefundInfoModel*)cellData;
        NSString *content = model.desc;
        CGFloat contentHeight = [self heightForContentLabel:content];
        CGFloat buttonHeight = 45;
        height = 51 + 12 + contentHeight + 8 + buttonHeight + 12;
    }
    return height;
}

+ (CGFloat)heightForContentLabel:(NSString*)text
{
    CGFloat height = 32;
    if (text) {
//        CGSize size = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 12*4, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: FONT(14)} context:nil].size;
        height = 32;
    }
    
    return height;
}

#pragma mark - Subviews

- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, LINE_WIDTH)];
        view.backgroundColor = Theme_Color;
        view.layer.cornerRadius = 2.f;
        view.layer.masksToBounds = YES;
        _bkgView = view;
    }
    return _bkgView;
}


- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 0, 0)];
        label.font = FONT(16);
        label.textColor = Color_White;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(32, 50, SCREEN_WIDTH-64, LINE_WIDTH)];
        line.backgroundColor = Color_White;
        _line = line;
    }
    return _line;
}

- (UILabel*)contentLabel
{
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_White;
        label.numberOfLines = 0;
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIButton*)recordButton
{
    if (!_recordButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(32, 0, SCREEN_WIDTH-64, 45)];
        [button setTitle:@"查看退款记录" forState:UIControlStateNormal];
        [button setTitleColor:Color_Gray(45) forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        button.backgroundColor = Color_White;
        //button.layer.borderColor = Color_White.CGColor;
        //button.layer.borderWidth = 1.f;
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(recordButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _recordButton = button;
    }
    return _recordButton;
}

- (UIButton*)cancelButton
{
    if (!_cancelButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(32, 0, SCREEN_WIDTH - 64, 45)];
        [button setTitle:@"取消退款" forState:UIControlStateNormal];
        button.backgroundColor = Color_White;
        [button setTitleColor:Color_Gray(45) forState:UIControlStateNormal];
        button.titleLabel.font = FONT(16);
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = button;
    }
    return _cancelButton;
}

- (UILabel *)youcanLabel
{
    if (!_youcanLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray(45);
        label.text = @"你还可以：";

        [label sizeToFit];
        _youcanLabel = label;
    }
    return _youcanLabel;
}

- (UIButton*)applyButton
{
    if (!_applyButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(24, 0, 85, 45)];
        [button setTitle:@"再次申请" forState:UIControlStateNormal];
        button.backgroundColor = Color_White;
        [button setTitleColor:Color_Gray(45) forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(applyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _applyButton = button;
    }
    return _applyButton;
}

#pragma timer
- (void)startTimer
{
    if (!_downCountTimer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTimeLabel) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        _downCountTimer = timer;
    }
    [self refreshTimeLabel];
    if (_seconds <= 0) {
        self.contentLabel.text = @"请刷新页面";
    }
}

- (void)refreshTimeLabel
{
    //_seconds -- ;
    NSDate *now = [NSDate date];
    NSUInteger nowInterVal = [now timeIntervalSince1970];
    NSUInteger deadtimeInterval = [self.expireTime integerValue];
    
    _seconds = deadtimeInterval - nowInterVal;
    
    NSUInteger day  = (NSUInteger)_seconds/(24*3600);
    NSUInteger hour = (NSUInteger)(_seconds%(24*3600))/3600;
    NSUInteger min  = (NSUInteger)(_seconds%(3600))/60;
    NSUInteger second = (NSUInteger)(_seconds%60);
    //NSLog(@"商家在%lu天%lu小时%lu分%lu秒内未处理，将自动同意",(unsigned long)day,(unsigned long)hour,(unsigned long)min,(unsigned long)second);
    if (_seconds <= 0) {
        self.contentLabel.text = @"退款信息已更新，请刷新页面";
        [self.downCountTimer invalidate];
        self.downCountTimer = nil;
        return;
    }
    self.contentLabel.text = [NSString stringWithFormat:@"商家在%lu天%lu小时%lu分%lu秒内未处理，将自动同意",(unsigned long)day,(unsigned long)hour,(unsigned long)min,(unsigned long)second];
}

#pragma mark button actions
- (void)cancelButtonTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonTapped)]) {
        [self.delegate cancelButtonTapped];
    }
}

- (void)applyButtonTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(applyButtonTapped)]) {
        [self.delegate applyButtonTapped];
    }
}

- (void)recordButtonTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(recordButtonTapped)]) {
        [self.delegate recordButtonTapped];
    }
}
@end
