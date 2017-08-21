//
//  ItemNoJoinContentCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CINoJoinContentCell.h"
#import "M13LiteProgressView.h"
#import "CIItemResultModel.h"

@interface CINoJoinContentCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *amoutLabel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *leftDescLabel;
@property (nonatomic, strong) M13LiteProgressView *progressView;

@property (nonatomic, strong) UIView *bg1View;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *calculateTimeLabel;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CINoJoinContentCell

//- (void)dealloc
//{
//    NSLog(@"%s dealloc",__FILE__);
//}

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.amoutLabel];
	[self cellAddSubView:self.leftLabel];
	[self cellAddSubView:self.tipLabel];
    [self cellAddSubView:self.leftDescLabel];
	[self cellAddSubView:self.progressView];
    
    [self cellAddSubView:self.bg1View];
    [self.bg1View addSubview:self.numberLabel];
    [self.bg1View addSubview:self.timeLabel];
    [self.bg1View addSubview:self.calculateTimeLabel];
    
    //  添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChaged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeFromSuperview
{
    [self.timer invalidate];
    self.timer = nil;
    [super removeFromSuperview];
}

- (void)reloadData
{
	if (self.cellData) {
        CIItemResultModel *resultModel = self.cellData;
        CIActivityModel *activityModel = resultModel.activity;
        
        self.titleLabel.text = resultModel.item.name;
        self.titleLabel.width = SCREEN_WIDTH - 16;
        self.titleLabel.height = [resultModel.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 16].height;
        self.titleLabel.top = 12;
        self.titleLabel.left = 8;
        
        self.progressView.progress = activityModel.progress / 100.0f;
        self.progressView.top = self.titleLabel.bottom + 12;
        
        self.amoutLabel.text = [NSString stringWithFormat:@"最低%@人",activityModel.allParticipantTimes];
        [self.amoutLabel sizeToFit];
        self.amoutLabel.top = self.progressView.bottom + 2;
        self.amoutLabel.left = 8;
        
        self.leftLabel.text = activityModel.participantTimes;
        [self.leftLabel sizeToFit];
        self.leftLabel.right = SCREEN_WIDTH - 8;
        self.leftLabel.centerY = self.amoutLabel.centerY;
        
        self.leftDescLabel.text = @"当前：";
        [self.leftDescLabel sizeToFit];
        self.leftDescLabel.right = self.leftLabel.left;
        self.leftDescLabel.centerY = self.leftLabel.centerY;
        
        self.bg1View.top = self.leftDescLabel.bottom + 8;
        
        
        self.numberLabel.text = [NSString stringWithFormat:@"期号：%@",resultModel.activity.number];
        [self.numberLabel sizeToFit];
        self.numberLabel.bottom = self.bg1View.height / 2.0f - 8;
        self.numberLabel.left = 8;
        
        self.timeLabel.text = @"截止倒计时：";
        [self.timeLabel sizeToFit];
        self.timeLabel.left = 8;
        self.timeLabel.top = self.bg1View.height / 2.0f + 8;
        
        self.tipLabel.bottom = [[self class] heightForCell:self.cellData] - 15;
        
        [self.timer fire];
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        CIItemResultModel *model = cellData;
		height = 130 + 50 + 8 + [model.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 16].height;
	}
    return height;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray42;
        label.numberOfLines = 0;
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_White;
        _numberLabel = label;
    }
    return _numberLabel;
}

- (UILabel *)amoutLabel
{
	if (!_amoutLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_amoutLabel = label;
	}
	return _amoutLabel;
}

- (UILabel *)leftLabel
{
	if (!_leftLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = RGB(79, 136, 228);
		_leftLabel = label;
	}
	return _leftLabel;
}

- (UILabel *)leftDescLabel{
    if (!_leftDescLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray153;
        _leftDescLabel = label;
    }
    return _leftDescLabel;
}

- (UILabel *)tipLabel
{
	if (!_tipLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH  - 24, 34)];
		label.font = FONT(16);
		label.textColor = Color_Gray153;
		label.text = @"您没有参与本期的夺宝哦！";
        label.backgroundColor = Color_Gray233;
        label.bottom = 150 - 15;
        label.textAlignment = NSTextAlignmentCenter;
		_tipLabel = label;
	}
	return _tipLabel;
}

- (M13LiteProgressView *)progressView
{
	if (!_progressView) {
		M13LiteProgressView *progressView = [[M13LiteProgressView alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 6)];
        progressView.progressTintColor = RGB(249, 218, 109);
        progressView.trackTintColor = Color_Gray233;
        progressView.layer.cornerRadius = 3;
        progressView.layer.masksToBounds = YES;
		_progressView = progressView;
	}
	return _progressView;
}

- (UIView *)bg1View
{
    if (!_bg1View) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 64)];
        view.backgroundColor = RGB(234, 66, 74);
        _bg1View = view;
    }
    return _bg1View;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_White;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)calculateTimeLabel{
    if (!_calculateTimeLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = FONT(18);
        label.textColor = Color_White;
        _calculateTimeLabel = label;
    }
    return _calculateTimeLabel;
}



- (void)timeChaged{
    // 设置剩余时间
    CIItemResultModel *model = self.cellData;
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    [fmt setDateStyle:NSDateFormatterMediumStyle];
//    [fmt setTimeStyle:NSDateFormatterShortStyle];
//    fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
//    
//    [fmt setTimeZone:timeZone];
    
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[model.activity.endTime intValue]];
    
    
    NSString *str = [self leftTime:endDate];
    self.calculateTimeLabel.text = str;
    [self.calculateTimeLabel sizeToFit];
    self.calculateTimeLabel.left = self.timeLabel.right;
    self.calculateTimeLabel.centerY = self.timeLabel.centerY;
    
}

- (NSString *)leftTime:(NSDate *)endDate
{
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表哪些差值
    NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSTimeInterval time=[endDate timeIntervalSinceDate:now];
    if (time < 0) {
        return @"00:00:00";
    }
    // 既损两个时间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:now toDate:endDate options:0];
    if (cmps.day <= 0) {
        return [NSString stringWithFormat:@"%02lu:%02lu:%02lu",  cmps.hour,cmps.minute, cmps.second];
    }else{
        return [NSString stringWithFormat:@"%ld天 %02lu:%02lu:%02lu", cmps.day , cmps.hour,cmps.minute, cmps.second];
    }
}
@end
