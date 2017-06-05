//
//  SDSignatureFirstAlertView.m
//  SD
//
//  Created by LayZhang on 2017/5/11.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDSignatureFirstAlertView.h"
#import "Masonry.h"
#import "SDLoginButton.h"

static SDSignatureFirstAlertView *_instance;

@interface SDSignatureFirstAlertView()
@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UIImageView *titleImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UIButton *okButton;

@end

@implementation SDSignatureFirstAlertView

+ (instancetype)sharedSignatureFirstAlertView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width = 578 * SCALE;
        CGFloat x = (SCREENWIDTH - width)/2;
        CGFloat height = 780 * SCALE;
        CGFloat y = (SCREENHEIGHT - height)/2;
        _instance = [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
    });
    
    return _instance;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initContent];
    }
    return self;
}

- (void)initContent {
    
    self.layer.cornerRadius = 8 * SCALE;
    self.clipsToBounds = YES;
    self.backgroundColor = SDWhiteColor;
    
    UIImageView *titleImageView = [[UIImageView alloc] init];
    [titleImageView setImage:[UIImage imageNamed:@"icon_box_signature"]];
    self.titleImageView = titleImageView;
    [self addSubview:titleImageView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"电子签名，全新上线";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = FDColor(34, 34, 34);
    titleLabel.font = ZLNormalFont(36 * SCALE);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"专注您的资金安全；引进专业的CA认证技术；保障电子合同具有完整的司法效力；打造顶级安全的防护体系；为您的合法权益保驾护航";
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.textColor = UIColor.grayColor;
    contentLabel.font = [UIFont systemFontOfSize:28 * SCALE];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel = contentLabel;
    [self addSubview:contentLabel];
    
    SDLoginButton *okButton = [[SDLoginButton alloc] init];
    [okButton setTitle:@"知道了" forState:UIControlStateNormal];
    okButton.titleLabel.font = ZLNormalFont(30 * SCALE);
    [okButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.okButton = okButton;
    [self addSubview:okButton];
    
}

- (void)updateConstraints {
    [super updateConstraints];
    UIView *superView = self;
//    CGSize superSize = super.frame.size;
//    CGFloat superViewHeight = superSize.height;
    
    [self.titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.bottom.equalTo(superView.mas_bottom);
    }];
    
    CGFloat buttonEdge = 60.0f * SCALE;
    [self.okButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(buttonEdge);
        make.right.equalTo(superView.mas_right).offset(-buttonEdge);
        make.bottom.equalTo(superView.mas_bottom).offset(-30 * SCALE);
        make.height.mas_equalTo(80 * SCALE);
    }];
    
    CGFloat titleEdge = 30.0f * SCALE;
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(titleEdge);
        make.right.equalTo(superView.mas_right).offset(-titleEdge);
        make.bottom.equalTo(_okButton.mas_top).offset(-40.0f * SCALE);
        make.height.mas_equalTo(140 * SCALE);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(titleEdge);
        make.right.equalTo(superView.mas_right).offset(-titleEdge);
        make.bottom.equalTo(_contentLabel.mas_top).offset(-50.0f * SCALE);
        make.height.mas_equalTo(30 * SCALE);
    }];
}

#pragma constraints
// 这个是必须的
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - public
+ (void)show {
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    shadowButton.backgroundColor = [UIColor blackColor];
    shadowButton.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
    
    SDSignatureFirstAlertView *alert = [self sharedSignatureFirstAlertView];
    alert.shadowButton = shadowButton;
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
}


- (void)dismiss {
    SDSignatureFirstAlertView *alert = [SDSignatureFirstAlertView sharedSignatureFirstAlertView];
    
    [alert removeFromSuperview];
    
    [alert.shadowButton removeFromSuperview];
    
}



@end
