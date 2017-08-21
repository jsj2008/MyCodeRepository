//
//  ITPhoto.h
//  FlyLantern
//
//  Created by marco on 12/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "ITPhotoProtocol.h"

@interface ITPhoto : NSObject<ITPhoto>

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic) BOOL emptyImage;
@property (nonatomic) BOOL isVideo;

+ (ITPhoto *)photoWithImage:(UIImage *)image;
+ (ITPhoto *)photoWithURL:(NSURL *)url;
+ (ITPhoto *)photoWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;
+ (ITPhoto *)videoWithURL:(NSURL *)url; // Initialise video with no poster image

- (id)init;
- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;
- (id)initWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;
- (id)initWithVideoURL:(NSURL *)url;

@end
