//
//  CIDetailContentModel.h
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol CIDetailContentModel <NSObject>


@end

@interface CIDetailContentModel : BaseModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString<Optional> *image;
@property (nonatomic, strong) NSString<Optional> *text;
@property (nonatomic, assign) CGFloat  ar;

@end
