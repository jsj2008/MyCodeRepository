//
//  VersionResultModel.h
//  ZhenBaoHui
//
//  Created by marco on 8/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@interface VersionResultModel : BaseModel

@property (nonatomic, copy) NSString *versionCode;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *updateLog;
@property (nonatomic, copy) NSString<Optional> *fileSize;
@property (nonatomic, assign) BOOL force;

@end
