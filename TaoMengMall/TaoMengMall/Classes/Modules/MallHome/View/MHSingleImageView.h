//
//  MHSingleImageView.h
//  FlyLantern
//
//  Created by marco on 18/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

@interface MHSingleImageView : UIView

@property (nonatomic, strong,readonly) UIImageView *iconImageView;

- (void)reloadData:(NSDictionary *)viewData;

@end
