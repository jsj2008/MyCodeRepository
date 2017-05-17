//
//  ShowChooseView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/10.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarChooseView.h"
#import "KChartParamDefine.h"
#import "KChartSaveData.h"

@protocol chooseProtocol <NSObject>

- (void)didSelectAtIndex:(int)index value:(id)value type:(ChooseType)type;

@end

@interface ToolBarChooseView : UIView

@property (nonatomic, weak) id<chooseProtocol>delegate;
@property ToolBarChooseView *subChooseView;

@property KChartSaveData *saveData;

//- (void)showSubChooseView;

- (void)showWithType:(ChooseType)type;

@end
