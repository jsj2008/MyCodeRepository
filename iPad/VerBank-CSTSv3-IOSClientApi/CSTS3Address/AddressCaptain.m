//
//  AddressCaptain.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "AddressCaptain.h"
#import "MTP4CommDataInterface.h"
#import "AddressPack.h"
#import "SpeedChecker.h"
#import "GDataXMLNode.h"
#import "JEDISystem.h"
#import "CSTSManager.h"


#define XML_DEMO        @"DEMO"
#define XML_LIVE        @"LIVE"
#define XML_PROXY       @"PROXY"

#define XML_PREMARK     @"PREMARK"
#define XML_NODE        @"NODE"

#define XML_N_NAME      @"NAME"
#define XML_N_IP        @"IP"
#define XML_N_PORT      @"PORT"
#define XML_N_USER      @"USER"
#define XML_N_PWD       @"PWD"



static NSMutableArray * gs_AddressPack_Array = nil;


@interface AddressCaptain()
{
@private
    NSMutableArray  * mNodeArray;
    NSString        * mPreMark;
    BOOL              mIsLive;
    BOOL              mIsManager;
    
    AddressNode     * mCurrentNode;
}

-(NSMutableArray *) getNodeArrayFromPacksByUserName:(NSString *) userName  Demo:(BOOL) isDemo;

@end



@implementation AddressCaptain

//----------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------
#pragma mark Static functions
//----------------------------------------------------------------------------------------------------

+(BOOL) loadDataFormatXML:(NSString *)xmlName
{
    if(xmlName == nil){
        return NO;
    }
    
    JEDI_SYS_Try
    {
        if(gs_AddressPack_Array == nil){
            gs_AddressPack_Array = [[NSMutableArray alloc] init];
        }else{
            [gs_AddressPack_Array removeAllObjects];
        }
        
        [AddressCaptain parseAddressConfigFileWithName:xmlName];
        
#ifdef JEDI_LOGIN_DEBUGGING
        NSLog(@"--------AddressPack --------- %d", gs_AddressPack_Array.count);
        for(AddressPack * pack in gs_AddressPack_Array){
            [pack toString];
        }
#endif
    }
    JEDI_SYS_EndTry
    
    return (gs_AddressPack_Array.count > 0);
}

//----------------------------------------------------------------------------------------------------
+(AddressCaptain *) createLiveAddressCaptain:(NSString *)userName byCSTSManager:(Boolean)byCSTSManager
{
    return [[AddressCaptain alloc] initWithUserName:userName isLive:YES byCSTSManager:byCSTSManager];
}

//----------------------------------------------------------------------------------------------------
+(AddressCaptain *) createDemoAddressCaptain:(NSString *)userName byCSTSManager:(Boolean)byCSTSManager
{
    return [[AddressCaptain alloc] initWithUserName:userName isLive:NO byCSTSManager:byCSTSManager];
}

//----------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------
#pragma mark Public functions
//----------------------------------------------------------------------------------------------------

-(id)               initWithUserName:(NSString *)userName isLive:(BOOL) live byCSTSManager:(BOOL)isManager
{
    self = [super init];
    if(self != nil)
    {
        mIsLive = live;
        mIsManager = NO;
        mPreMark = @"";
        mCurrentNode = nil;
        
        mNodeArray = [self getNodeArrayFromPacksByUserName:userName  Demo:!live];
        
        if(isManager && [mPreMark isEqualToString:@""])
        {
            mIsManager = YES;
            mNodeArray = [CSTSManager addressNodesFromManagers:mNodeArray userName:userName];
            [self setNodeNameForNodeArray:mNodeArray];
        }
    }
    
    return self;
}

//----------------------------------------------------------------------------------------------------
-(JEDINetwork *)    createSocket:(AddressNode * )addressNode
{
    return nil;
}

//----------------------------------------------------------------------------------------------------
-(int)              getAddressState
{
    if(mNodeArray != nil && mNodeArray.count > 0){
        return USERIDENTIFY_RESULT_SUCCEED;
    }
    
    if(!mIsManager){
        return USERIDENTIFY_RESULT_ERR_NETCFG;
    }
    
    if([CSTSManager isNetworkOk]){
        return USERIDENTIFY_RESULT_ERR_USER_NOT_FOUND;
    }else{
        return USERIDENTIFY_RESULT_ERR_NETERR;
    }
}

//----------------------------------------------------------------------------------------------------
-(AddressNode *)    getBestAddress
{
    if(mNodeArray == nil || mNodeArray.count == 0){
        return nil;
    }
    
    //
    // check
    //
    SpeedChecker * checker = [[SpeedChecker alloc] init];
    [checker checkSpeed:mNodeArray];
    
    //
    // sort
    //
    [mNodeArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        AddressNode * n1 = (AddressNode *) obj1;
        AddressNode * n2 = (AddressNode *) obj2;
        
        return [n1 compareTo:n2];
    }];
    
    //
    // get best
    //
    mCurrentNode = [mNodeArray objectAtIndex:0];
    
#ifdef JEDI_LOGIN_DEBUGGING
    [JEDISystem log:@"*******************************************************"];
    for(int i=0; i<mNodeArray.count; ++i)
    {
        AddressNode * node = [mNodeArray objectAtIndex:i];
        [JEDISystem log:[node toString]];
    }
    [JEDISystem log:@"*******************************************************"];
#endif

    return mCurrentNode;
}

//----------------------------------------------------------------------------------------------------
-(NSMutableArray *) getServNames
{
    return nil;
}

//----------------------------------------------------------------------------------------------------
-(BOOL) isLive
{
    return mIsLive;
}

//----------------------------------------------------------------------------------------------------
-(void) setNodeNameForNodeArray:(NSMutableArray *) nodeArray
{
    if(nodeArray == nil) return;
    
    AddressNode * node = nil;
    
    for(int i=0; i<nodeArray.count; ++i)
    {
        node = [nodeArray objectAtIndex:i];
        node.strName = [NSString stringWithFormat:@"CMN_%d", i];
        //NSLog(@"-->%@: %@ %d", node.strName, node.strIp, node.nPort);
    }
}

//----------------------------------------------------------------------------------------------------
-(NSMutableArray *) getNodeArrayFromPacksByUserName:(NSString *) userName  Demo:(BOOL) isDemo
{
    NSMutableArray * nodeArray = [[NSMutableArray alloc] init];
    NSString * strUpperName = [userName uppercaseString];
    
    if(gs_AddressPack_Array)
    {
        for (AddressPack * pack in gs_AddressPack_Array)
        {
            if(pack.isDemo != isDemo){
                continue;
            }
            
            if(pack.strPreMark == nil || [pack.strPreMark isEqualToString:@""])
            {
                [nodeArray addObjectsFromArray:pack.nodeArray];//把gs_AddressPack_Array中的数组放到nodeArray中//要返回的array
                return nodeArray;
            }
            else
            {
                NSString * strUpperMark = pack.strPreMark.uppercaseString;
                NSRange rang = NSMakeRange(0, strUpperMark.length);
                NSComparisonResult rlt = [strUpperName compare:strUpperMark options:NSLiteralSearch range:rang];//判断两者是否相同
                
                if(rlt == NSOrderedSame)
                {
                    mPreMark = strUpperMark;
                    [nodeArray addObjectsFromArray:pack.nodeArray];
                    return nodeArray;
                }
            }
        }
    }
    
    return nodeArray;
}


//----------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------
#pragma mark Private functions
//----------------------------------------------------------------------------------------------------
+ (void) parseAddressConfigFileWithName:(NSString *) xmlName
{
    //获取工程目录的xml文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:xmlName ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //使用NSData对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    
    //获取根节点（Address）
    GDataXMLElement *rootElement = [doc rootElement];
    
    //获取根节点下的节点（DEMO）
    NSArray * demos = [rootElement elementsForName:XML_DEMO];
    [AddressCaptain parseDemoElements:demos];
    
    //获取根节点下的节点（LIVE）
    NSArray * lives = [rootElement elementsForName:XML_LIVE];
    [AddressCaptain parseLiveElements:lives];
}

//----------------------------------------------------------------------------------------------------
+ (void) parseDemoElements:(NSArray *) demos
{
    if(demos && demos.count > 0)
    {
        JEDI_SYS_Try
        {
            for (GDataXMLElement * demo in demos)
            {
                AddressPack * demoPack = [[AddressPack alloc] init];
                demoPack.nodeArray  = [[NSMutableArray alloc] init];
                demoPack.strPreMark = [[demo attributeForName:XML_PREMARK] stringValue];
                demoPack.isDemo = true;
                
                NSArray * nodes = [demo elementsForName:XML_NODE];
                [AddressCaptain parseNodeElements:nodes toPack:demoPack];
                
                [gs_AddressPack_Array addObject:demoPack];
            }
        }
        JEDI_SYS_EndTry
    }
}

//----------------------------------------------------------------------------------------------------
+ (void) parseLiveElements:(NSArray *) lives
{
    if(lives && lives.count > 0)
    {
        JEDI_SYS_Try
        {
            for (GDataXMLElement * live in lives)
            {
                AddressPack * livePack = [[AddressPack alloc] init];
                livePack.nodeArray  = [[NSMutableArray alloc] init];
                livePack.strPreMark = [[live attributeForName:XML_PREMARK] stringValue];
                livePack.isDemo = false;
                
                NSArray * nodes = [live elementsForName:XML_NODE];
                [AddressCaptain parseNodeElements:nodes toPack:livePack];
                
                [livePack toString];
                
                [gs_AddressPack_Array addObject:livePack];
            }
        }
        JEDI_SYS_EndTry
    }

}

//----------------------------------------------------------------------------------------------------
+ (void) parseNodeElements:(NSArray *) nodes toPack:(AddressPack *) pack
{
    JEDI_SYS_Try
    {
        for (GDataXMLElement * node in nodes)
        {
            AddressNode * aNode = [[AddressNode alloc] init];
            aNode.strName = [[node attributeForName:XML_N_NAME] stringValue];
            aNode.strIp   = [[node attributeForName:XML_N_IP] stringValue];
            aNode.nPort   = (int)[[[node attributeForName:XML_N_PORT] stringValue] integerValue];
            
            [pack.nodeArray addObject:aNode];
        }
    }
    JEDI_SYS_EndTry
}


@end
