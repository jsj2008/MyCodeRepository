//
//  ITPropertyButton.m
//  HongBao
//
//  Created by Ivan on 16/2/12.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITPropertyButton.h"

@interface ITPropertyButton ()

@property (nonatomic, strong) ITPropertyKVModel *propertyKV;

@end


@implementation ITPropertyButton

+ (ITPropertyButton *) buttonWithPropertyKV: (ITPropertyKVModel *)propertyKV {
    
    ITPropertyButton *propertyButton = [self buttonWithType:UIButtonTypeCustom];
    
    propertyButton.propertyKV = propertyKV;
    
//    UIEdgeInsets bgEdgeInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
    
//    UIImage *backgroundImageNormal = [[UIImage imageNamed:@"btn_property_bg_normal"] resizableImageWithCapInsets:bgEdgeInsets];
//    
//    UIImage *backgroundImageDisabled = [[UIImage imageNamed:@"btn_property_bg_disabled"] resizableImageWithCapInsets:bgEdgeInsets];
//    
//    UIImage *backgroundImageSelected = [[UIImage imageNamed:@"btn_property_bg_selected"] resizableImageWithCapInsets:bgEdgeInsets];
    
    propertyButton.titleLabel.font = FONT(14);
    [propertyButton setTitle:propertyKV.v forState:UIControlStateNormal];
    propertyButton.contentEdgeInsets = UIEdgeInsetsMake(6.f, 10.f, 6.f, 10.f);
    [propertyButton sizeToFit];
    
    [propertyButton setTitleColor:Color_Gray(140) forState:UIControlStateNormal];
    //[propertyButton setBackgroundImage:backgroundImageNormal forState:UIControlStateNormal];
    
    [propertyButton setTitleColor:Color_Gray230 forState:UIControlStateDisabled];
    //[propertyButton setBackgroundImage:backgroundImageDisabled forState:UIControlStateDisabled];
    
    [propertyButton setTitleColor:Color_White forState:UIControlStateSelected];
    //[propertyButton setBackgroundImage:backgroundImageSelected forState:UIControlStateSelected];
    
    propertyButton.layer.borderWidth = 1.;
    propertyButton.layer.cornerRadius = 2.;
    [propertyButton.layer masksToBounds];
    return propertyButton;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (self.selected) {
        self.layer.borderColor = Theme_Color.CGColor;
        self.backgroundColor = Theme_Color;
    }else{
        self.layer.borderColor = Color_Gray(229).CGColor;
        self.backgroundColor = Color_White;
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (self.enabled) {
        if (self.selected) {
            self.layer.borderColor = Theme_Color.CGColor;
        }else{
            self.layer.borderColor = Color_Gray(229).CGColor;
        }
    }else{
        self.layer.borderColor = Color_Gray(230).CGColor;
    }
}
@end
