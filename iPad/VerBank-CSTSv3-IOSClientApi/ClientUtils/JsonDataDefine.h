//
//  JsonDataDefine.h
//  VerBank-ClientStation
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "JEDISystem.h"
#import "JEDIDateTime.h"

#ifndef VerBank_ClientStation_JsonDataDefine_h
#define VerBank_ClientStation_JsonDataDefine_h

//------------------------
//--------getter----------
//------------------------

//--------NSString--------
#define getJsonStringValueImplementation(ValueName, JsonID) \
-(NSString *) get##ValueName{ \
JEDI_SYS_Try{ \
return [super getEntryString:JsonID];  \
} \
JEDI_SYS_EndTry \
return nil; \
}

//--------int-----------
#define getJsonIntValueImplementation(ValueName, JsonID) \
-(int) get##ValueName{ \
JEDI_SYS_Try{ \
return [super getEntryInt:JsonID];  \
} \
JEDI_SYS_EndTry \
return 0; \
}

//--------double-----------
#define getJsonDoubleValueImplementation(ValueName, JsonID) \
-(double) get##ValueName{ \
JEDI_SYS_Try{ \
return [super getEntryDouble:JsonID];  \
}\
JEDI_SYS_EndTry \
return 0.0;\
}

//--------long-----------
#define getJsonLongValueImplementation(ValueName, JsonID) \
-(long) get##ValueName{ \
JEDI_SYS_Try{\
return [super getEntryLong:JsonID];  \
}\
JEDI_SYS_EndTry \
return 0;\
}

//--------longlong-----------
#define getJsonLongLongValueImplementation(ValueName, JsonID) \
-(long long) get##ValueName{ \
JEDI_SYS_Try{\
return [super getEntryLongLong:JsonID];  \
}\
JEDI_SYS_EndTry \
return 0;\
}

//--------Boolean-----------
#define getJsonBooleanValueImplementation(ValueName, JsonID) \
-(Boolean) get##ValueName{ \
JEDI_SYS_Try{\
return [super getEntryBoolean:JsonID];  \
}\
JEDI_SYS_EndTry \
return false;\
}

//--------NSDate-----------
#define getJsonDateValueImplementation(ValueName, JsonID) \
-(NSDate *) get##ValueName{ \
JEDI_SYS_Try{\
return [super getEntryDate:JsonID];  \
}\
JEDI_SYS_EndTry \
return nil;\
}

//--------NSObject-----------
#define getJsonObjectValueImplementation(ValueName, JsonID) \
-(id) get##ValueName{ \
JEDI_SYS_Try{\
return [super getEntryObject:JsonID];  \
}\
JEDI_SYS_EndTry \
return nil;\
}

//--------NSObjectVec-----------
#define getJsonObjectVecValueImplementation(ValueName, JsonID) \
-(NSMutableArray *) get##ValueName{ \
JEDI_SYS_Try{\
return [super getEntryArray:JsonID];  \
}\
JEDI_SYS_EndTry \
return nil;\
}

#define getJsonValueInterface(ValueName,ReturnType) -(ReturnType) get##ValueName;

//------------------------
//--------setter----------
//------------------------

//--------NSString--------
#define setJsonStringValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(NSString *)value { \
[super setEntry:JsonID entry:value]; \
}

//--------int-----------
#define setJsonIntValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(int)value{ \
NSNumber *number=[NSNumber numberWithInt:value]; \
[super setEntry:JsonID entry:number]; \
}

//--------double-----------
#define setJsonDoubleValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(double)value{ \
NSNumber *number=[NSNumber numberWithDouble:value]; \
[super setEntry:JsonID entry:number]; \
}

//--------long-----------
#define setJsonLongValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(long)value{ \
NSNumber *number=[NSNumber numberWithLong:value]; \
[super setEntry:JsonID entry:number]; \
}

//--------longlong-----------
#define setJsonLongLongValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(long long)value{ \
NSNumber *number=[NSNumber numberWithLongLong:value]; \
[super setEntry:JsonID entry:number]; \
}

//--------Boolean-----------
#define setJsonBooleanValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(Boolean)value{ \
NSNumber *number=[NSNumber numberWithBool:value]; \
[super setEntry:JsonID entry:number]; \
}

//--------NSDate-----------
#define setJsonDateValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(NSDate *)value{ \
NSString * strTime = [JEDIDateTime stringFromDate:value]; \
[super setEntry:JsonID entry:strTime]; \
}

//--------NSObject-----------
#define setJsonObjectValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(id)value{ \
[super setEntry:JsonID entry:value]; \
}

//--------NSObjectVec-----------
#define setJsonObjectVecValueImplementation(ValueName, JsonID) \
-(void) set##ValueName:(NSMutableArray *)value{ \
[super setEntry:JsonID entry:value]; \
}

#define setJsonValueInterface(ValueName,VelueType) -(void) set##ValueName:(VelueType)value;

//----------------------------
//-----getterSetter-----------
//----------------------------

#define jsonImplementionString(ValueName, JsonID) \
getJsonStringValueImplementation(ValueName, JsonID) \
setJsonStringValueImplementation(ValueName, JsonID)

#define jsonImplementionInt(ValueName, JsonID) \
getJsonIntValueImplementation(ValueName, JsonID) \
setJsonIntValueImplementation(ValueName, JsonID)

#define jsonImplementionDouble(ValueName, JsonID) \
getJsonDoubleValueImplementation(ValueName, JsonID) \
setJsonDoubleValueImplementation(ValueName, JsonID)

#define jsonImplementionLong(ValueName, JsonID) \
getJsonLongValueImplementation(ValueName, JsonID) \
setJsonLongValueImplementation(ValueName, JsonID)

#define jsonImplementionLongLong(ValueName, JsonID) \
getJsonLongLongValueImplementation(ValueName, JsonID) \
setJsonLongLongValueImplementation(ValueName, JsonID)

#define jsonImplementionBoolean(ValueName, JsonID) \
getJsonBooleanValueImplementation(ValueName, JsonID) \
setJsonBooleanValueImplementation(ValueName, JsonID)

#define jsonImplementionDate(ValueName, JsonID) \
getJsonDateValueImplementation(ValueName, JsonID) \
setJsonDateValueImplementation(ValueName, JsonID)

#define jsonImplementionObject(ValueName, JsonID) \
getJsonObjectValueImplementation(ValueName, JsonID) \
setJsonObjectValueImplementation(ValueName, JsonID)

#define jsonImplementionObjectVec(ValueName, JsonID) \
getJsonObjectVecValueImplementation(ValueName, JsonID) \
setJsonObjectVecValueImplementation(ValueName, JsonID)

#define jsonValueInterface(ValueName, ReturnType) \
getJsonValueInterface(ValueName,ReturnType) \
setJsonValueInterface(ValueName,ReturnType)

#endif
