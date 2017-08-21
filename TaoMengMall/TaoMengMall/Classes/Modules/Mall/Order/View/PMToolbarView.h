//
//  ITToolbarView.h
//  HongBao
//
//  Created by Ivan on 16/2/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

@protocol PMToolbarDelegate <NSObject>

- (void) buyButtonDidClick;

@end

@interface PMToolbarView : UIView

@property (nonatomic, weak) id<PMToolbarDelegate> delegate;

@end
