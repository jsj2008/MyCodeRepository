//
//  SDAlignBothSideView.m
//  SD
//
//  Created by LayZhang on 2017/4/19.
//  Copyright © 2017年 LayZhang. All rights reserved.
//

#import "SDAlignBothSideView.h"

@implementation SDAlignBothSideView


+ (SDAlignBothSideView *)alignViewWithPropFont:(CGFloat)propFont propColor:(UIColor *)propColor desFont:(CGFloat)desFont desColor:(UIColor *)desColor {
    
    SDAlignBothSideView *alignBothSideView = [[SDAlignBothSideView alloc] init];
    
    alignBothSideView.propLabel.font                = [UIFont systemFontOfSize:propFont];
    alignBothSideView.propLabel.textColor           = propColor;
    alignBothSideView.descriptionLabel.font         = [UIFont systemFontOfSize:desFont];
    alignBothSideView.descriptionLabel.textColor    = desColor;
    
    return alignBothSideView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        //        self.backgroundColor = [UIColor redColor];
        
        CGFloat font = 24 * SCALE;
        
        //prop
        UILabel *propLabel = [[UILabel alloc] init];
        self.propLabel = propLabel;
        propLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:propLabel];
        propLabel.textColor = FDColor(34, 34, 34);
        propLabel.font = [UIFont systemFontOfSize:font];
        
        // description
        UILabel *desLabel = [[UILabel alloc] init];
        self.descriptionLabel = desLabel;
        desLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:desLabel];
        desLabel.textColor = FDColor(34, 34, 34);
        desLabel.font = [UIFont systemFontOfSize:font];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.propLabel.width = self.descriptionLabel.width = self.width/2;
    self.propLabel.height = self.descriptionLabel.height = self.height;
    
    self.propLabel.x = 0;
    self.descriptionLabel.x = self.width/2;
    self.propLabel.y = self.descriptionLabel.y = 0;
}


@end
