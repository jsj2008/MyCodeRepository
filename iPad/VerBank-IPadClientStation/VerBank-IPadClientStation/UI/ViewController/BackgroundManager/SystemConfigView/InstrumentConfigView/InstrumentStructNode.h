//
//  InstrumentStructNode.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, InstrumentSelectType) {
    InstrumentSelected      = 0,
    InstrumentUnselect      = 1,
    InstrumentUnknow        = 2,
};

@interface InstrumentStructNode : NSObject

- (id)initWithInstrument:(NSString *)instrument selectType:(InstrumentSelectType)type;

@property NSString *instrumentName;
@property int selectType;

@end

