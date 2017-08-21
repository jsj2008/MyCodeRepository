//
//  CATotalBarView.h
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

@protocol CATotalBarDelegate <NSObject>

- (void) payButtonDidClick;

@end

@interface CATotalBarView : UIView

@property (nonatomic, weak) id<CATotalBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame totalPrice:(NSString *)totalPrice balance:(NSString *)balance canUseBalance:(BOOL)canUseBalance;

@end
