//
//  SDHighProveView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/13.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDHighProveViewDelegate;
@class SDUserVerifyDetail;
typedef enum {
    SDProveTypeTaobao,
    SDProveTypeJingdong,
    SDProveTypeYanghang,
    SDProveTypeShebao,
    SDProveTypeGongjijin,
    SDProveTypeXueXinWang
    
}SDProveType;

@protocol SDHighProveViewDelegate <NSObject>

- (void)highProveViewButtonDidClicked:(SDProveType)type;

@end


@interface SDHighProveView : UIView

@property (nonatomic, weak) id<SDHighProveViewDelegate> delegate;

@property (nonatomic, strong) SDUserVerifyDetail *userVerifyDetail;

@end
