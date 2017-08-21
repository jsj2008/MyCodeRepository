//
//  CSTotalBarView.h
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

@protocol CSTotalBarDelegate <NSObject>

- (void) orderButtonDidClick;

@end

@interface CSTotalBarView : UIView

@property (nonatomic, weak) id<CSTotalBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame totalPrice:(NSString *)totalPrice;

@end
