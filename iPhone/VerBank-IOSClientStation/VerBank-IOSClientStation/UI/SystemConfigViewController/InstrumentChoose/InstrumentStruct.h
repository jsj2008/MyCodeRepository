//
//  InstrumentStruct.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, InstrumentSelectType) {
    InstrumentSelected      = 0,
    InstrumentUnselect      = 1,
    InstrumentUnknow        = 2,
};

@interface InstrumentStruct : NSObject

- (id)initWithInstrument:(NSString *)instrument selectType:(InstrumentSelectType)type;

@property NSString *instrumentName;
@property int selectType;

@end
