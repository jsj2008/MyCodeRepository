//
//  CTTotalBarView.h
//  HongBao
//
//  Created by Ivan on 16/2/17.
//  Copyright © 2016年 ivan. All rights reserved.
//

@protocol CTTotalBarDelegate <NSObject>

- (void) okButtonDidClick;

@end

@interface CTTotalBarView : UIView

@property (nonatomic, weak) id<CTTotalBarDelegate> delegate;
@property (nonatomic, assign) BOOL selected;

//editing 为YES的时候，结算按钮变删除按钮
@property (nonatomic, assign) BOOL xxEditing;

- (void)reloadData:(NSDictionary *)totalData;

@end
