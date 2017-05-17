//
//  JEDIZip.h
//  Objective-Zip
//
//  Created by felix on 7/14/13.
//
//

#import <Foundation/Foundation.h>

@interface JEDIZip : NSObject

//
// Zip Data
//
+ (NSData *) zipDataFromData:(NSData *) data;

//
// Unzip Data
//
+ (NSData *) dataFromZipData:(NSData *) zipData;

@end
