//
//  MActivityIndicatorView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MActivityIndicatorView.h"



static const NSInteger kInsetValue = 6;
static const CGFloat kActivityIndicatorSizeOfHeight = 20;
static const CGFloat kActivityIndicatorSizeOfWidth = 20;

@implementation MActivityIndicatorView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showCustomWithAlertOnView:(UIView *)view
                        withTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                            width:(CGFloat)width
                           height:(CGFloat)height
                  backgroundImage:(UIImage *)backgroundImage
                  backgroundColor:(UIColor *)backgroundColor
                     cornerRadius:(CGFloat)cornerRadius
                      shadowAlpha:(CGFloat)shadowAlpha
                            alpha:(CGFloat)alpha
                      contentView:(UIView *)contentView
                             type:(CustomAlertType)type{
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    
    //    mainView = [[UIView alloc] initWithFrame:windowRect];
    self.frame = windowRect;
    
    UIView *shadowView = [[UIView alloc] initWithFrame:windowRect];
    shadowView.backgroundColor = [UIColor whiteColor];
    shadowView.alpha = shadowAlpha;
    
    [self addSubview:shadowView];
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width/2 - width/2,
                                                                 view.frame.size.height/2 - height/2,
                                                                 width, height)];
    alertView.backgroundColor = backgroundColor;
    if (backgroundImage) {
        alertView.backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    }
    alertView.layer.cornerRadius = cornerRadius;
    alertView.alpha = alpha;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = titleColor;
    
    titleLabel.numberOfLines = 0;
    CGSize requiredSize = [titleLabel sizeThatFits:CGSizeMake(width - kInsetValue, height - kInsetValue)];
    titleLabel.frame = CGRectMake(width/2 - requiredSize.width / 2, kInsetValue, requiredSize.width, requiredSize.height);
    [alertView addSubview:titleLabel];
    
    UIView *content = nil;
    
    if (type == CustomAlertTypeCustom) {
        content = contentView;
    } else {
        content = [self contentViewFromType:type];
    }
    
    content.frame = CGRectApplyAffineTransform(content.frame, CGAffineTransformMakeTranslation(width/2 - content.frame.size.width/2, titleLabel.frame.origin.y + titleLabel.frame.size.height + kInsetValue));
    
    [alertView addSubview:content];
    
    [self addSubview:alertView];
    //    [self addSubview:mainView];
    [view addSubview:self];
}

- (UIView *)contentViewFromType:(CustomAlertType)type {
    UIImageView *content = [[UIImageView alloc] init];
    //generate default content views based on the type of the alert
    switch (type) {
        case CustomAlertTypeWaiting:
        {
            content.frame = CGRectMake(0, 0, kActivityIndicatorSizeOfWidth, kActivityIndicatorSizeOfHeight);
            content.animationDuration = 0.7;
            content.animationImages = [self setupCustomActivityIndicator];
            [content startAnimating];
        }
            break;
        default:
            break;
    }
    return content;
}

- (NSArray *)setupCustomActivityIndicator{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 12; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"images/loadingImages/loading%d",i]];
        [array addObject:image];
    }
    return array;
}


- (void)hideCustomAlert{
    [self removeFromSuperview];
}

- (void)showCustomAlertViewOnView:(UIView *)view withTitle:(NSString *)titleString withType:(CustomAlertType)type{
    [self showCustomWithAlertOnView:view
                          withTitle:titleString
                         titleColor:[UIColor blackColor]
                              width:200.0
                             height:60.0
                    backgroundImage:nil
                    backgroundColor:[UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f]
                       cornerRadius:4.0f
                        shadowAlpha:0.0
                              alpha:1.0
                        contentView:nil
                               type:type];
}


@end
