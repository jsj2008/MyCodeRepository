//
//  ItemJoinContentCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIJoinContentCell.h"
#import "CIItemResultModel.h"
#import "M13LiteProgressView.h"

@interface CIJoinContentCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bg1View;
@property (nonatomic, strong) UIView *bg2View;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *calculateTimeLabel;
@property (nonatomic, strong) UILabel *joinNumberLabel;
@property (nonatomic, strong) UILabel *captureNumberLabel;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *amoutLabel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *leftDescLabel;
@property (nonatomic, strong) M13LiteProgressView *progressView;

@end

@implementation CIJoinContentCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.amoutLabel];
    [self cellAddSubView:self.leftLabel];
    [self cellAddSubView:self.leftDescLabel];
    [self cellAddSubView:self.progressView];
	[self cellAddSubView:self.bg1View];
	[self cellAddSubView:self.bg2View];
    [self.bg1View addSubview:self.numberLabel];
	[self.bg1View addSubview:self.timeLabel];
    [self.bg1View addSubview:self.calculateTimeLabel];
	[self.bg2View addSubview:self.joinNumberLabel];
	[self.bg2View addSubview:self.captureNumberLabel];
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
        CIItemResultModel *model = self.cellData;
        
        self.titleLabel.text = model.item.name;
        self.titleLabel.width = SCREEN_WIDTH - 16;
        self.titleLabel.height = [model.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 16].height;
        self.titleLabel.left = 8;
        self.titleLabel.top = 12;
        
        self.progressView.progress = model.activity.progress / 100.0f;
        self.progressView.top = self.titleLabel.bottom + 12;
        
        self.amoutLabel.text = [NSString stringWithFormat:@"最低%@人",model.activity.allParticipantTimes];
        [self.amoutLabel sizeToFit];
        self.amoutLabel.top = self.progressView.bottom + 2;
        self.amoutLabel.left = 8;
        
        self.leftLabel.text = model.activity.participantTimes;
        [self.leftLabel sizeToFit];
        self.leftLabel.right = SCREEN_WIDTH - 8;
        self.leftLabel.centerY = self.amoutLabel.centerY;
        
        self.leftDescLabel.text = @"当前：";
        [self.leftDescLabel sizeToFit];
        self.leftDescLabel.right = self.leftLabel.left;
        self.leftDescLabel.centerY = self.leftLabel.centerY;
        
        self.bg1View.top = self.leftDescLabel.bottom + 12;
        self.bg2View.top = self.bg1View.bottom;
        
        self.numberLabel.text = [NSString stringWithFormat:@"期号：%@",model.activity.number];
        [self.numberLabel sizeToFit];
        self.numberLabel.bottom = self.bg1View.height / 2.0f - 8;
        self.numberLabel.left = 8;
        
        self.timeLabel.text = @"截止倒计时：";
        [self.timeLabel sizeToFit];
        self.timeLabel.left = 8;
        self.timeLabel.top = self.bg1View.height / 2.0f + 8;
        
        NSString *npTimesStr = [NSString stringWithFormat:@"您参与了：%@人次",model.participant.participantTimes];
        NSMutableAttributedString *nattributedStr = [[NSMutableAttributedString alloc] initWithString:npTimesStr];
        [nattributedStr addAttribute:NSForegroundColorAttributeName value:RGB(235, 84, 94) range:NSMakeRange(5, model.participant.participantTimes.length)];
        self.joinNumberLabel.attributedText = nattributedStr;
        [self.joinNumberLabel sizeToFit];
        self.joinNumberLabel.left = 8;
        self.joinNumberLabel.top = 10;
        
        self.captureNumberLabel.text = [NSString stringWithFormat:@"夺宝号码：%@",model.participant.captureNumber];
        self.captureNumberLabel.width = SCREEN_WIDTH - 32;
        //self.captureNumberLabel.height = self.joinNumberLabel.height;
        self.captureNumberLabel.height = [self.captureNumberLabel.text sizeWithUIFont:FONT(12) forWidth:SCREEN_WIDTH - 32].height;

        self.captureNumberLabel.left = 8;
        self.captureNumberLabel.top = 32 + 8;
        
        self.bg2View.height = self.captureNumberLabel.bottom + 10;

        [self.timer fire];
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        CIItemResultModel *model = cellData;
		height = 188 + [model.item.name sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH - 16].height;
        
        NSString *capture = [NSString stringWithFormat:@"夺宝号码：%@",model.participant.captureNumber];
        height = height + [capture sizeWithUIFont:FONT(12) forWidth:SCREEN_WIDTH - 32].height;
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

- (UIView *)bg2View
{
	if (!_bg2View) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 64)];
		view.backgroundColor = Color_Gray238;
		_bg2View = view;
	}
	return _bg2View;
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

- (UILabel *)joinNumberLabel
{
	if (!_joinNumberLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_joinNumberLabel = label;
	}
	return _joinNumberLabel;
}

- (UILabel *)captureNumberLabel
{
	if (!_captureNumberLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
        label.numberOfLines = 0;
		_captureNumberLabel = label;
	}
	return _captureNumberLabel;
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
