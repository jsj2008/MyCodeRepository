//
//  CSPointShowModel.h
//  FlyLantern
//
//  Created by marco on 15/05/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol CSPointShowModel <NSObject>

@end

@interface CSPointShowModel : BaseModel

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *totalDesc;
@property (nonatomic, strong) NSString *inputHint;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *usable;
@property (nonatomic, assign) BOOL intValue;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) BOOL switcher;

@property (nonatomic, assign) BOOL unfold;
@property (nonatomic, assign) BOOL inputEnable;


@property (nonatomic, strong) NSString *inputValue;
@end
