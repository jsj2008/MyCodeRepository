//
//  SDFeedBackView.h
//  SD
//
//  Created by LayZhang on 2017/6/1.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedBackImageDelegate <NSObject>

- (void)selectAtIndex:(NSUInteger)index;

@end

@interface SDFeedBackView : UIView
@property (nonatomic, weak) UITextView *questionTextView;


@property (nonatomic, weak) UIImageView *questionImageViewA;
@property (nonatomic, weak) UIImageView *questionImageViewB;
@property (nonatomic, weak) UIImageView *questionImageViewC;

@property (nonatomic, weak) UIButton *okButton;
@property (nonatomic, weak) UIButton *cancelButton;

@property (nonatomic, weak) id<FeedBackImageDelegate>delegate;


@property (nonatomic, strong) NSMutableArray *imageArray;

- (void)addImage:(UIImage *)image;
@end
