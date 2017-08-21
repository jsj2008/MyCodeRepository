//
//  CAHomeModuleView.h
//  GongWuBao2.0
//
//  Created by marco on 1/11/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <UIKit/UIKit.h>

//2,5,22 only

@interface MHomeModuleView : UIView

@property (nonatomic, strong,readonly) UIImageView *iconImageView;
@property (nonatomic, strong,readonly) UILabel *titleLabel;

//@property (nonatomic, assign) BOOL isRound;

- (void)reloadData:(NSDictionary *)viewData;

@end
