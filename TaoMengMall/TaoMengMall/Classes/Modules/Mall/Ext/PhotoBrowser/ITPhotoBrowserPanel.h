//
//  ITPhotoBrowserPanel.h
//  FlyLantern
//
//  Created by marco on 13/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ITPhotoBrowserPanel;

@protocol ITPhotoBrowserPanelDelegate <NSObject>

- (void) willHidePhotoBrowsePanel:(ITPhotoBrowserPanel*)panel;

@end

@interface ITPhotoBrowserPanel : UIView

@property (nonatomic, weak) id<ITPhotoBrowserPanelDelegate> delegate;
@property (nonatomic, assign) NSUInteger currentIndex;

- (instancetype)initWithPhotos:(NSArray*)photos;

//- (void)setCurrentIndex:(NSUInteger)currentIndex animated:(BOOL)animated;

- (void) show;

- (void) dismiss;

@end
