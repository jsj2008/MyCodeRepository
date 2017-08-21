//
//  ITPhotoBrowserView.h
//  FlyLantern
//
//  Created by marco on 12/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITCaptionView.h"
#import "ITPhotoProtocol.h"
#import "ITPhoto.h"


// a light implementation for MWPhotoBrowser

@class ITPhotoBrowserView;

@protocol ITPhotoBrowserViewDelegate <NSObject>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(ITPhotoBrowserView *)photoBrowser;
- (id <ITPhoto>)photoBrowser:(ITPhotoBrowserView *)photoBrowser photoAtIndex:(NSUInteger)index;

@optional

- (id <ITPhoto>)photoBrowser:(ITPhotoBrowserView *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
- (ITCaptionView *)photoBrowser:(ITPhotoBrowserView *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index;
- (NSString *)photoBrowser:(ITPhotoBrowserView *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index;

- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser didSingleTapPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser didDoubleTapPhotoAtIndex:(NSUInteger)index;

//- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index;
//- (BOOL)photoBrowser:(ITPhotoBrowserView *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index;
//- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected;
//- (void)photoBrowserDidFinishModalPresentation:(ITPhotoBrowserView *)photoBrowser;

@end

@interface ITPhotoBrowserView : UIView<UIScrollViewDelegate>

@property (nonatomic, readonly) NSUInteger currentIndex;
@property (nonatomic, weak) id<ITPhotoBrowserViewDelegate> delegate;
@property (nonatomic) BOOL zoomPhotosToFill;
@property (nonatomic) BOOL hideCaption;

- (id)initWithPhotos:(NSArray *)photosArray;
- (id)initWithDelegate:(id <ITPhotoBrowserViewDelegate>)delegate;

// Reloads the photo browser and refetches data
- (void)reloadData;

// Set page that photo browser starts on
- (void)setCurrentPhotoIndex:(NSUInteger)index;

// Navigation
- (void)showNextPhotoAnimated:(BOOL)animated;
- (void)showPreviousPhotoAnimated:(BOOL)animated;

@end
