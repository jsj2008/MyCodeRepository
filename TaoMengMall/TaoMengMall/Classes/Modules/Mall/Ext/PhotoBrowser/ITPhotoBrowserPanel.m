//
//  ITPhotoBrowserPanel.m
//  FlyLantern
//
//  Created by marco on 13/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ITPhotoBrowserPanel.h"
#import "ITPhotoBrowserView.h"

@interface ITPhotoBrowserPanel ()<ITPhotoBrowserViewDelegate>

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ITPhotoBrowserView *browserView;
@property (nonatomic, strong) UILabel *coverIndexLabel;
@end

@implementation ITPhotoBrowserPanel

- (instancetype)initWithPhotos:(NSArray*)photos
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        _photos = [NSMutableArray array];
        
        ITPhoto *photo;
        for (NSString *cover in photos) {
            photo = [[ITPhoto alloc]initWithURL:[NSURL URLWithString:cover]];
            [self.photos addSafeObject:photo];
        }
        [self render];
    }
    return self;
}

- (void) render {
    
    self.userInteractionEnabled = YES;
    
    [self addSubview:self.maskView];
    [self addSubview:self.browserView];
    [self addSubview:self.coverIndexLabel];
    [self.browserView reloadData];
}

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self.browserView setCurrentPhotoIndex:_currentIndex];
}

#pragma mark - Custom Methods

- (void)show
{
    [self.browserView reloadData];
    [self.browserView setCurrentPhotoIndex:self.currentIndex];
    
    [[ApplicationEntrance shareEntrance].window addSubview:self];
    
    weakify(self);
    
    [UIView animateWithDuration:0.4 animations:^{
        strongify(self);
        self.browserView.alpha = 1;
    } completion:^(BOOL finished) {
        strongify(self);
        self.maskView.alpha = 1;
        self.coverIndexLabel.alpha = 1;
    }];
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(willHidePhotoBrowsePanel:)]) {
        [self.delegate willHidePhotoBrowsePanel:self];
    }
    
    weakify(self);
    self.maskView.alpha = 0;
    self.coverIndexLabel.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        
        strongify(self);
        self.browserView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        strongify(self);
        [self removeFromSuperview];
        
    }];
}

#pragma mark - Getters And Setters

- (UIView *)maskView {
    
    if ( !_maskView ) {
        _maskView = [[UIView alloc] initWithFrame:self.frame];
        _maskView.backgroundColor = RGBA(0, 0, 0, 1);
        _maskView.userInteractionEnabled = YES;
        _maskView.alpha = 0;

        weakify(self);
        [_maskView bk_whenTapped:^{
            strongify(self);
            [self dismiss];
        }];
    }
    
    return _maskView;
}

- (ITPhotoBrowserView*)browserView
{
    if (!_browserView) {
        _browserView = [[ITPhotoBrowserView alloc]initWithDelegate:self];
        _browserView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _browserView.zoomPhotosToFill = NO;
        _browserView.hideCaption = YES;
        _browserView.alpha = 0;
        [_browserView setCurrentPhotoIndex:0];
    }
    return _browserView;
}

- (UILabel*)coverIndexLabel
{
    if (!_coverIndexLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 20)];
        label.font = FONT(12);
        label.backgroundColor = RGBA(0, 0, 0, 0.4);
        label.textColor = Color_White;
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 0;
        _coverIndexLabel = label;
    }
    return _coverIndexLabel;
}

#pragma mark - ITPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(ITPhotoBrowserView *)photoBrowser {
    return _photos.count;
}

- (id <ITPhoto>)photoBrowser:(ITPhotoBrowserView *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
    _currentIndex = index;
    self.coverIndexLabel.text = [NSString stringWithFormat:@"%lu/%lu",index+1,self.photos.count];
    [self.coverIndexLabel sizeToFit];
    self.coverIndexLabel.width += 22;
    self.coverIndexLabel.height += 4;
    self.coverIndexLabel.layer.cornerRadius = self.coverIndexLabel.height/2;
    self.coverIndexLabel.right = SCREEN_WIDTH - 24;
    self.coverIndexLabel.bottom = SCREEN_HEIGHT - 12;
}

- (void)photoBrowser:(ITPhotoBrowserView *)photoBrowser didSingleTapPhotoAtIndex:(NSUInteger)index
{
    [self dismiss];
}
@end
