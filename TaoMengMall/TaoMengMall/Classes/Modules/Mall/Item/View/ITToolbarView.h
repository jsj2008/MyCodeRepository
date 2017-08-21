//
//  ITToolbarView.h
//  HongBao
//
//  Created by Ivan on 16/2/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

@protocol ITToolbarDelegate <NSObject>

- (void) chatButtonDidClick;
- (void) likeButtonDidClick;
- (void) shopButtonDidClick;
- (void) addToCartButtonDidClick;
- (void) buyButtonDidClick;

@end

@interface ITToolbarView : UIView

@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) NSString *status;

@property (nonatomic, weak) id<ITToolbarDelegate> delegate;

- (void) render;

@end
