//
//  AddressCaptain.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

//#import "JEDINetwork.h"
#import "AddressNode.h"


@interface AddressCaptain : NSObject

//----------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------

+(BOOL)             loadDataFormatXML:(NSString *)xmlName;

+(AddressCaptain *) createLiveAddressCaptain:(NSString *)userName byCSTSManager:(Boolean)byCSTSManager;
+(AddressCaptain *) createDemoAddressCaptain:(NSString *)userName byCSTSManager:(Boolean)byCSTSManager;


//----------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------

-(id)               initWithUserName:(NSString *)userName isLive:(BOOL)live byCSTSManager:(BOOL)isManager;

-(int)              getAddressState;
-(AddressNode *)    getBestAddress;
-(NSMutableArray *) getServNames;

-(BOOL)             isLive;

@end
