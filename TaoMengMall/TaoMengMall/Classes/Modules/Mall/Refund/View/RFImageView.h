//
//  RVImageView.h
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFImageView : UIView

@property (nonatomic, strong) UIImage *image;
- (void)setOnlineImage:(NSString *)image;
@end
