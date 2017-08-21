//
//  ITZoomingScrollView.h
//  FlyLantern
//
//  Created by marco on 12/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITPhotoProtocol.h"

@class ITPhotoBrowserView,ITCaptionView;

@interface ITZoomingScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic) id <ITPhoto> photo;
@property (nonatomic, weak) ITCaptionView *captionView;


- (id)initWithPhotoBrowser:(ITPhotoBrowserView *)browser;
- (void)displayImage;
//- (void)displayImageFailure;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)prepareForReuse;
- (void)setImageHidden:(BOOL)hidden;
@end
