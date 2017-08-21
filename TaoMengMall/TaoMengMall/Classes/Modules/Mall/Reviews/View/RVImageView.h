//
//  RVImageView.h
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RVImageView;

@protocol RVImageView <NSObject>

- (void)deleteButtonTapped:(RVImageView*)imageView;
- (void)imageViewTappped:(RVImageView*)imageView;
@end

@interface RVImageView : UIView
@property (nonatomic, weak) id<RVImageView> delegate;

@property (nonatomic, strong) UIImage *image;
- (void)setOnlineImage:(NSString *)image;
@end
