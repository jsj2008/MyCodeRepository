//
//  SDFeedBackView.m
//  SD
//
//  Created by LayZhang on 2017/6/1.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDFeedBackView.h"

@interface SDFeedBackView()<UITextViewDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) UILabel *titleLabel;




@end

@implementation SDFeedBackView

- (instancetype)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    
    self.backgroundColor = SDWhiteColor;
    self.layer.cornerRadius = 10.0f;
    self.alpha = 1.0f;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.text = @"用户反馈";
    titleLabel.font = ZLBoldFont(38 * SCALE);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UITextView *questionTextView = [[UITextView alloc] init];
    self.questionTextView = questionTextView;
    questionTextView.layer.cornerRadius = 10.0f;
    questionTextView.layer.borderWidth = 1.0f;
    questionTextView.layer.borderColor = [UIColor grayColor].CGColor;
    questionTextView.font=  ZLNormalFont(30 * SCALE);
    questionTextView.text = @"你的问题";
    questionTextView.textColor = [UIColor grayColor];
    questionTextView.delegate = self;
    [self addSubview:questionTextView];
    
    UIImageView *questionImageViewA = [[UIImageView alloc] init];
    self.questionImageViewA = questionImageViewA;
    [self addSubview:questionImageViewA];
    
    UIImageView *questionImageViewB = [[UIImageView alloc] init];
    self.questionImageViewB = questionImageViewB;
    [self addSubview:questionImageViewB];
    
    UIImageView *questionImageViewC = [[UIImageView alloc] init];
    self.questionImageViewC = questionImageViewC;
    [self addSubview:questionImageViewC];
    
    UIButton *okButton = [[UIButton alloc] init];
    self.okButton = okButton;
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    okButton.layer.cornerRadius = 50  *SCALE;
    okButton.backgroundColor = FDColor(240, 240, 240);
    [self addSubview:okButton];
    
    UIButton *cancelButton = [[UIButton alloc] init];
    self.cancelButton = cancelButton;
    cancelButton.layer.cornerRadius = 50  *SCALE;
    cancelButton.layer.borderColor = FDColor(240,240, 240).CGColor;
    cancelButton.layer.borderWidth = 1.0f;
    cancelButton.backgroundColor = SDWhiteColor;
    [cancelButton setTitleColor:FDColor(240,240, 240) forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self addSubview:cancelButton];
    
    [self resetImage];
    
    [questionImageViewA addGestureRecognizer:[self getImagePickGesture]];
    [questionImageViewB addGestureRecognizer:[self getImagePickGesture]];
    [questionImageViewC addGestureRecognizer:[self getImagePickGesture]];
    questionImageViewA.userInteractionEnabled = YES;
    questionImageViewB.userInteractionEnabled = YES;
    questionImageViewC.userInteractionEnabled = YES;
}

- (void)updateConstraints {
    [super updateConstraints];
    //    UIView *superView = self;
    //    CGSize superSize = super.frame.size;
    //    CGFloat superViewHeight = superSize.height;
    //    CGFloat superViewWidth = superSize.width;
    
    __weak typeof (self) weakSelf = self;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10 * SCALE);
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(50 * SCALE);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    [self.questionTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(30 * SCALE);
        make.right.equalTo(weakSelf.mas_right).offset(- 20 * SCALE);
        make.left.equalTo(weakSelf.mas_left).offset(20 * SCALE);
        make.height.mas_equalTo(200 * SCALE);
    }];
    
    [self.questionImageViewA mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionTextView.mas_bottom).offset(20 * SCALE);
        make.left.equalTo(self.questionTextView.mas_left).offset(10 * SCALE);
        make.height.mas_equalTo(140 * SCALE);
        make.width.mas_equalTo(140 * SCALE);
    }];
    
    [self.questionImageViewB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionTextView.mas_bottom).offset(20 * SCALE);
        make.left.equalTo(self.questionImageViewA.mas_right).offset(30 * SCALE);
        make.height.mas_equalTo(140 * SCALE);
        make.width.mas_equalTo(140 * SCALE);
    }];
    
    [self.questionImageViewC mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionTextView.mas_bottom).offset(20 * SCALE);
        make.left.equalTo(self.questionImageViewB.mas_right).offset(30 * SCALE);
        make.height.mas_equalTo(140 * SCALE);
        make.width.mas_equalTo(140 * SCALE);
    }];
    
    CGFloat btnwidth = CGRectGetWidth(self.frame) / 2 - 100 * SCALE;
    [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionImageViewA.mas_bottom).offset(20 * SCALE);
        make.centerX.equalTo(weakSelf.mas_centerX).offset(- (btnwidth / 2 + 20 * SCALE));
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(100 * SCALE);
    }];
    
    [self.okButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionImageViewA.mas_bottom).offset(20 * SCALE);
        make.centerX.equalTo(weakSelf.mas_centerX).offset(btnwidth / 2 + 20 * SCALE);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(100 * SCALE);
    }];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - plcehoder
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"你的问题"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"你的问题";
        textView.textColor = [UIColor grayColor];
    }
}

#pragma mark - image UITapGestureRecognizer
- (UITapGestureRecognizer *)getImagePickGesture {
    UITapGestureRecognizer *gesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(imageViewClick:)];
    return gesture;
}

- (void)imageViewClick:(UIGestureRecognizer *)recognizer {
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    NSUInteger selectIndex = 0;
    if (imageView == _questionImageViewA) {
        selectIndex = 0;
    }
    if (imageView == _questionImageViewB) {
        selectIndex = 1;
    }
    if (imageView == _questionImageViewC) {
        selectIndex = 2;
    }
    
    if (_imageArray && _imageArray.count >= selectIndex + 1) {
        [_imageArray removeObjectAtIndex:selectIndex];
        self.imageArray = _imageArray;
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(selectAtIndex:)]) {
        [_delegate selectAtIndex:selectIndex];
    }
}

- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
    [self resetImage];
    for (int i = 0; i < imageArray.count; i++) {
        if (i == 0) {
            self.questionImageViewA.image = imageArray[i];
        }
        if (i == 1) {
            self.questionImageViewB.image = imageArray[i];
        }
        if (i == 2) {
            self.questionImageViewC.image = imageArray[i];
        }
    }
}

-(void)resetImage {
    self.questionImageViewA.image = [UIImage imageNamed:@"icon_add_normal"];
    self.questionImageViewB.image = [UIImage imageNamed:@"icon_add_normal"];
    self.questionImageViewC.image = [UIImage imageNamed:@"icon_add_normal"];
}

- (void)addImage:(UIImage *)image {
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    [_imageArray addObject:image];
    self.imageArray = _imageArray;
}

@end
