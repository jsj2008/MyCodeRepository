//
//  ShareView.m
//  YouJu
//
//  Created by wzningjie on 16/10/10.
//  Copyright © 2016年 wzningjie. All rights reserved.
//

#import "XMShareView.h"

#import "WXApiManager.h"
#import "WeiboApiManager.h"
#import "QQApiManager.h"

#define CONTAINER_HEIGHT 193
#define BUTTON_WIDTH  54

@interface XMShareView ()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSMutableArray *configs;
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation XMShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        _buttons = [NSMutableArray array];
        _configs = [NSMutableArray array];
        [_configs addObject:@{@"type":@"qq",@"title":@"QQ好友",@"icon":@"Third_share_qq"}];
        [_configs addObject:@{@"type":@"zone",@"title":@"QQ空间",@"icon":@"Third_share_zone"}];
        
        [_configs addObject:@{@"type":@"wechat",@"title":@"微信",@"icon":@"Third_share_wechat"}];
        [_configs addObject:@{@"type":@"timeline",@"title":@"朋友圈",@"icon":@"Third_share_timeline"}];
        
        [_configs addObject:@{@"type":@"qq",@"title":@"新浪微博",@"icon":@"Third_share_weibo"}];
        
        self.userInteractionEnabled = YES;
        [self addSubview:self.maskView];
        [self addSubview:self.containerView];
    }
    return self;
}

- (instancetype)init
{
    return [[[self class]alloc]initWithFrame:CGRectZero];
}

- (void)render
{
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    [self.configs removeAllObjects];
    
    [_configs addObject:@{@"type":@(XMShareTypeQQ),@"title":@"QQ好友",@"icon":@"Third_share_qq"}];
    [_configs addObject:@{@"type":@(XMShareTypeZone),@"title":@"QQ空间",@"icon":@"Third_share_zone"}];
    //if ([WXApi isWXAppInstalled]) {
    [_configs addObject:@{@"type":@(XMShareTypeWeChat),@"title":@"微信",@"icon":@"Third_share_wechat"}];
    [_configs addObject:@{@"type":@(XMShareTypeTimeline),@"title":@"朋友圈",@"icon":@"Third_share_timeline"}];
    //}
    [_configs addObject:@{@"type":@(XMShareTypeWeiBo),@"title":@"新浪微博",@"icon":@"Third_share_weibo"}];
    
    NSInteger row = 0,column = 0;
    for (int i = 0; i < _configs.count; i++) {
        row = i/3;
        column = i%3;
        UIButton *shareButton = [self createShareButton:[_configs safeObjectAtIndex:i]];
        shareButton.centerX = SCREEN_WIDTH/6*(2*column+1);
        shareButton.top = 38 + (BUTTON_WIDTH + 40)*row;
        [self.backView addSubview:shareButton];
        [self.buttons addObject:shareButton];
    }
    
    self.backView.height = 38*2+(BUTTON_WIDTH+40)*(row+1);
    self.containerView.height = self.backView.height + 42;
}

#pragma mark - Subviews

- (UIView *)maskView {
    
    if ( !_maskView ) {
        _maskView = [[UIView alloc] initWithFrame:self.frame];
        _maskView.backgroundColor = RGBA(0, 0, 0, 0.55);
        _maskView.userInteractionEnabled = YES;
        
        weakify(self);
        [_maskView bk_whenTapped:^{
            strongify(self);
            [self cancelButtonTapped:nil];
        }];
    }
    
    return _maskView;
}

- (UIView *)containerView {
    
    if ( !_containerView ) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CONTAINER_HEIGHT)];
        _containerView.backgroundColor = Color_Gray(251);
        _containerView.userInteractionEnabled = YES;
        [_containerView addSubview:self.titleLabel];
        [_containerView addSubview:self.line];
        [_containerView addSubview:self.backView];
        [_containerView addSubview:self.cancelButton];
        self.cancelButton.centerY = 21;
        self.cancelButton.right = SCREEN_WIDTH;
    }
    return _containerView;
}

- (UIView*)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 151)];
        _backView.backgroundColor = Color_White;
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = BOLD_FONT(16);
        label.text = @"分享";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/2;
        label.centerY = 21;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        view.bottom = 42;
        _line = view;
    }
    return _line;
}


- (UIButton*)createShareButton:(NSDictionary*)conf
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_WIDTH+40)];
    [button setImage:[UIImage imageNamed:conf[@"icon"]] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:conf[@"icon"]] forState:UIControlStateHighlighted];
    [button setTitleColor:Color_Gray(129) forState:UIControlStateNormal];
    button.titleLabel.font = FONT(13);
    [button setTitle:conf[@"title"] forState:UIControlStateNormal];
    button.tag = [conf[@"type"] integerValue];
    
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    CGSize textSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font }];
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + 4);
    button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton*)cancelButton
{
    if (!_cancelButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 42, 42)];
        [button setImage:[UIImage imageNamed:@"icon_cancel"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = button;
    }
    return _cancelButton;
}

#pragma mark - Public
- (void)show
{
    [self render];
    
    [[ApplicationEntrance shareEntrance].window addSubview:self];
    
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        strongify(self);
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT - self.containerView.height, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)dismiss
{
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        strongify(self);
        
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        
    } completion:^(BOOL finished) {
        
        strongify(self);
        [self removeFromSuperview];
        
    }];
}


#pragma mark - Button actions
- (void)cancelButtonTapped:(UIButton*)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewDidCancel:)]) {
        [self.delegate shareViewDidCancel:self];
    }
    [self dismiss];
}

- (void)buttonTapped:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(shareView:clickWithShareType:)]) {
        [self.delegate shareView:self clickWithShareType:button.tag];
    }
    if (self.shareInfo) {
        [self shareWithShareType:button.tag];
    }
    [self dismiss];
}

#pragma mark - Private
- (void)shareWithShareType:(XMShareType)type
{
    if (!self.shareInfo) {
        return;
    }
    //self.shareInfo.shareImg = @"http://upload.jianshu.io/users/upload_avatars/1176193/05f664586af7?imageMogr/thumbnail/90x90/quality/100";
    NSURL *shareImageUrl = [NSURL URLWithString:self.shareInfo.shareImg];
    
    if (type == XMShareTypeWeChat) {
        if (![WXApi isWXAppInstalled]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"微信未安装！" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:shareImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [WXApiManager sharedMessageToWeChat:self.shareInfo.shareTitle
                                    description:self.shareInfo.shareDesc
                                      detailUrl:self.shareInfo.shareUrl
                                          image:image
                                      shareType:WeChatShareSession];
        }];
        
    }else if (type == XMShareTypeTimeline) {
        if (![WXApi isWXAppInstalled]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"微信未安装！" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
        [[SDWebImageManager sharedManager] downloadImageWithURL:shareImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [WXApiManager sharedMessageToWeChat:self.shareInfo.shareTitle
                                    description:self.shareInfo.shareDesc
                                      detailUrl:self.shareInfo.shareUrl
                                          image:image
                                      shareType:WeChatShareTimeline];
        }];
    }else if (type == XMShareTypeWeiBo) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:shareImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            NSString *content = [NSString stringWithFormat:@"%@ %@",self.shareInfo.shareDesc,self.shareInfo.shareUrl];
            [WeiboApiManager sharedMessageToSinaWeibo:content image:image];
            
//            [WeiboApiManager sharedMessageToSinaWeibo:self.shareInfo.shareDesc
//                                               webURL:self.shareInfo.shareUrl
//                                                title:self.shareInfo.shareTitle
//                                           coverImage:image];
            
            
            
            //            [WeiboApiManager sharedMessageToSinaWeibo:self.shareInfo.shareDesc
            //                                             videoURL:self.shareInfo.shareUrl
            //                                       videoStreamURL:nil
            //                                                title:self.shareInfo.shareTitle
            //                                           coverImage:image];
            
        }];
    }else if (type == XMShareTypeQQ) {
        if (![QQApiManager isQQInstalled]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"QQ未安装！" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
        [[SDWebImageManager sharedManager] downloadImageWithURL:shareImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [QQApiManager sharedMessageToQQ:self.shareInfo.shareTitle
                                    message:self.shareInfo.shareDesc
                                  detailUrl:self.shareInfo.shareUrl
                                      image:image
                                  shareType:QQShareMessage];
            
        }];
    }else if (type == XMShareTypeZone) {
        if (![QQApiManager isQQInstalled]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"QQ未安装！" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
        [[SDWebImageManager sharedManager] downloadImageWithURL:shareImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [QQApiManager sharedMessageToQQ:self.shareInfo.shareTitle
                                    message:self.shareInfo.shareDesc
                                  detailUrl:self.shareInfo.shareUrl
                                      image:image
                                  shareType:QQShareZone];
            
        }];
    }
}
@end
