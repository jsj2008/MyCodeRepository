//
//  RVSkuRateCell.m
//  FlyLantern
//
//  Created by marco on 18/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "RVSkuRateCell.h"
#import "TTGalleryViewController.h"
#import "ITMarkView.h"
#import "RVImageView.h"
#import "TTCheckButton.h"
#import "ReviewInfoModel.h"

NSString *const kNOTIFY_PROOF_IMAGE_UPDATE = @"kNOTIFY_PROOF_IMAGE_UPDATE";

#define IMAGE_WIDTH ((SCREEN_WIDTH - 12*3 - 12*2)/4)

@interface RVSkuRateCell ()<ITMarkViewDelegate,UITextViewDelegate,RVImageView>
@property (nonatomic, strong) UIImageView *skuImageView;
@property (nonatomic, strong) UILabel *matchLabel;
@property (nonatomic, strong) ITMarkView *markView;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) UITextView *reviewsTextView;
@property (nonatomic, strong) UILabel *reviewsPlaceHoldLabel;

@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UILabel *limitLabel;
@property (nonatomic, strong) NSMutableArray<RVImageView*> *imageViews;

@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) TTCheckButton *checkButton;
@property (nonatomic, strong) UILabel *anonymousLabel;
@property (nonatomic, strong) UILabel *tipsLabel;
@end

@implementation RVSkuRateCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.skuImageView];
	[self cellAddSubView:self.matchLabel];
	[self cellAddSubView:self.markView];
	[self cellAddSubView:self.markLabel];
	[self cellAddSubView:self.line1];
	[self cellAddSubView:self.reviewsTextView];
	[self cellAddSubView:self.addImageView];
	//[self cellAddSubView:self.limitLabel];
	[self cellAddSubView:self.line2];
	[self cellAddSubView:self.checkButton];
	[self cellAddSubView:self.anonymousLabel];
	[self cellAddSubView:self.tipsLabel];
    for (RVImageView *image in self.imageViews) {
        [self cellAddSubView:image];
    }
}

- (void)reloadData
{
	if (self.cellData) {
        
        ReviewInfoModel *model = (ReviewInfoModel*)self.cellData;
        
        [self.skuImageView setOnlineImage:model.image];
        
        self.matchLabel.centerY = self.skuImageView.centerY;
        
        self.markView.centerY = self.skuImageView.centerY;
        self.markView.left = 130;
        
        //评分
        NSInteger mark = [model.d integerValue];
        self.markView.mark = mark;
        
        [self updateMarkLabel];
        
        //评价
        self.reviewsTextView.text = model.comment;
        
        //图片
        
        CGFloat top = 147;

        //重新放置images，留出第一个位置给点击的图标
        NSMutableArray *images = model.imageObjs;
        if (images.count >= 3) {
            self.limitLabel.centerY = top + IMAGE_WIDTH*3/2;
        }else{
            self.limitLabel.centerY = top + IMAGE_WIDTH/2;
        }
        if (images.count == 0) {
            self.limitLabel.text = @"上传凭证最多6张";
        }else{
            self.limitLabel.text = [NSString stringWithFormat:@"还能上传%ld张",6-images.count];
        }
        [self.limitLabel sizeToFit];
        self.limitLabel.right = SCREEN_WIDTH -12;
        
        int i = 0;
        for (; i < images.count; i++) {
            
            RVImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.hidden = NO;
            imageView.top = i / 4 * ( imageView.width + 2 ) + 3 + top;
            UIImage *image = [[images safeObjectAtIndex:i] objectForKey:@"imageData"];
            imageView.image = image;
            
        }
        CGFloat imageX = i % 4 * ( IMAGE_WIDTH + 12 ) + 12;
        self.addImageView.top = i / 4 * ( IMAGE_WIDTH + 2 ) + 8 + top;
        self.addImageView.left = imageX;
        
        for (; i < 6; i++) {
            RVImageView *imageView = [self.imageViews safeObjectAtIndex:i];
            imageView.image = nil;
            imageView.hidden = YES;
        }
        
        self.line2.top = self.addImageView.bottom + 8;
        self.checkButton.centerY = self.line2.bottom + 26;
        self.tipsLabel.centerY = self.checkButton.centerY;
        self.anonymousLabel.centerY = self.checkButton.centerY;
        self.checkButton.selected = model.anonymous;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        CGFloat height = 147 + IMAGE_WIDTH + 8 + 56;
        if (cellData) {
            ReviewInfoModel *model = (ReviewInfoModel*)cellData;
            if (model.imageObjs.count >= 3) {
                height += IMAGE_WIDTH + 8;
            }
        }
        return height;
	}
	return height;
}

#pragma mark - Subviews
- (UIImageView *)skuImageView
{
	if (!_skuImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 30, 30)];
		_skuImageView = imageView;
	}
	return _skuImageView;
}

- (UILabel *)matchLabel
{
	if (!_matchLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(52, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray42;
		label.text = @"相符程度";
		[label sizeToFit];
		_matchLabel = label;
	}
	return _matchLabel;
}

- (ITMarkView*)markView
{
    if (!_markView) {
        ITMarkView *markView = [[ITMarkView alloc]initWithFrame:CGRectMake(130, 46, 0, 0)];
        markView.markWidth = 20;
        markView.showMark = NO;
        markView.delegate = self;
        [markView sizeToFit];
        _markView = markView;
    }
    return _markView;
}

- (UILabel *)markLabel
{
	if (!_markLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray153;
		label.text = @"非常好";
		[label sizeToFit];
		_markLabel = label;
	}
	return _markLabel;
}

- (UIView *)line1
{
	if (!_line1) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, LINE_WIDTH)];
		view.backgroundColor = Color_Gray224;
		_line1 = view;
	}
	return _line1;
}

- (UITextView *)reviewsTextView
{
	if (!_reviewsTextView) {
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(12, 70, SCREEN_WIDTH - 12*2, 70)];
        textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
        textView.layer.borderColor = Color_Gray230.CGColor;
        textView.layer.borderWidth = LINE_WIDTH;
        textView.layer.masksToBounds = YES;
        textView.font = FONT(14);
        [textView addSubview:self.reviewsPlaceHoldLabel];
        textView.delegate = self;
		_reviewsTextView = textView;
	}
	return _reviewsTextView;
}

- (UILabel *)reviewsPlaceHoldLabel {
    
    if ( !_reviewsPlaceHoldLabel) {
        _reviewsPlaceHoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _reviewsPlaceHoldLabel.textColor = Color_Gray146;
        _reviewsPlaceHoldLabel.font = FONT(14);
        _reviewsPlaceHoldLabel.text = @"您对宝贝满意吗？说说你的使用心得";
        [_reviewsPlaceHoldLabel sizeToFit];
        _reviewsPlaceHoldLabel.left = 4;
        _reviewsPlaceHoldLabel.top = 6;
    }
    
    return _reviewsPlaceHoldLabel;
}

- (UIImageView *)addImageView {
    
    if ( !_addImageView ) {
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 147, IMAGE_WIDTH, IMAGE_WIDTH)];
        _addImageView.image = [UIImage imageNamed:@"review_addImage"];
        //_addImageView.left = 3;
        //_addImageView.bottom = 160;
        _addImageView.userInteractionEnabled = YES;
        weakify(self);
        [_addImageView bk_whenTapped:^{
            strongify(self);
            ReviewInfoModel *model = (ReviewInfoModel*)self.cellData;
            if (model.imageObjs.count == 6) {
                return ;
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(addImageTapped:)]) {
                [self.delegate addImageTapped:self];
            }
        }];
    }
    
    return _addImageView;
}

- (UILabel*)limitLabel
{
    if (!_limitLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"上传凭证最多6张";
        [label  sizeToFit];
        _limitLabel = label;
    }
    return _limitLabel;
}

- (NSArray<RVImageView *> *)imageViews {
    
    if ( !_imageViews ) {
        
        _imageViews = [[NSMutableArray<RVImageView *> alloc] initWithCapacity:6];
        
        CGFloat imageWidth = IMAGE_WIDTH;
        
        for ( int i = 0; i < 6; i++) {
            
            CGFloat imageX = i % 4 * ( imageWidth + 12 ) + 12;
            CGFloat imageY = i / 4 * ( imageWidth + 12 );
            
            
            RVImageView *imageView = [[RVImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageWidth)];
            //imageView.tag = i;
            //imageView.userInteractionEnabled = YES;
            imageView.delegate = self;
            //            UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
            //            [imageView addGestureRecognizer:tapGesturRecognizer];
            
            [_imageViews addObject:imageView];
            
        }
        
    }
    
    return _imageViews;
}

- (UIView *)line2
{
	if (!_line2) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 248, SCREEN_WIDTH - 24, LINE_WIDTH)];
		view.backgroundColor = Color_Gray224;
		_line2 = view;
	}
	return _line2;
}

- (TTCheckButton *)checkButton {
    
    if ( !_checkButton ) {
        _checkButton = [[TTCheckButton alloc] init];
        _checkButton.centerY = 248 + 26;
        _checkButton.left = 8;
        _checkButton.selected = YES;
        [_checkButton addTarget:self action:@selector(handleCheckButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _checkButton;
}

- (UILabel *)anonymousLabel
{
	if (!_anonymousLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray66;
		label.text = @"匿名";
		[label sizeToFit];
        label.left = self.checkButton.right + 4;
        label.centerY = self.checkButton.centerY;
		_anonymousLabel = label;
	}
	return _anonymousLabel;
}

- (UILabel *)tipsLabel
{
	if (!_tipsLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray153;
		label.text = @"你写的评价会以匿名的形式展现";
		[label sizeToFit];
        label.centerY = 248 + 26;
        label.right = SCREEN_WIDTH -12;
		_tipsLabel = label;
	}
	return _tipsLabel;
}

#pragma mark - 
- (void)updateMarkLabel
{
    NSInteger mark = (int)self.markView.mark;
    if (mark == 5) {
        self.markLabel.text = @"非常好";
    }else if (mark == 4) {
        self.markLabel.text = @"很好";
    }else if (mark == 3) {
        self.markLabel.text = @"一般";
    }else if (mark == 2) {
        self.markLabel.text = @"不好";
    }else if (mark == 1) {
        self.markLabel.text = @"很差";
    }
    [self.markLabel sizeToFit];
    self.markLabel.right = SCREEN_WIDTH - 12;
    self.markLabel.centerY = self.skuImageView.centerY;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.reviewsPlaceHoldLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ( IsEmptyString(textView.text) ) {
        self.reviewsPlaceHoldLabel.hidden = NO;
    } else {
        self.reviewsPlaceHoldLabel.hidden = YES;
    }
    ReviewInfoModel *model = (ReviewInfoModel*)self.cellData;
    model.comment = textView.text;
}

#pragma mark - ITMarkViewDelegate
- (void)rateViewValueChanged:(ITMarkView *)rateView
{
    ReviewInfoModel *model = (ReviewInfoModel*)self.cellData;
    model.d = [NSString stringWithFormat:@"%d",(int)rateView.mark];
    [self updateMarkLabel];
}

#pragma mark - RVImageView Delegate
- (void)deleteButtonTapped:(RVImageView *)imageView
{
    NSInteger index = [self.imageViews indexOfObject:imageView];
    if (index != NSNotFound) {
        ReviewInfoModel *model = (ReviewInfoModel*)self.cellData;
        [model.imageObjs removeObjectAtIndex:index];
        [[NSNotificationCenter defaultCenter]postNotificationName:kNOTIFY_PROOF_IMAGE_UPDATE object:nil];
    }
}

- (void)imageViewTappped:(RVImageView*)imageView
{
    
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    TTGalleryViewController *vc = [[TTGalleryViewController alloc] init];
    
    NSArray *images = (NSArray *)self.cellData;
    
    vc.imageObjs = images;
    vc.index = imageView.tag;
    
    [navigationController pushViewController:vc animated:YES];
}

#pragma mark -
- (void)handleCheckButton
{
    self.checkButton.selected = !self.checkButton.selected;
    ReviewInfoModel *model = (ReviewInfoModel*)self.cellData;
    model.anonymous = !model.anonymous;
}
@end
