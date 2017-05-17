//
//  TiArgumentConfig.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiArgumentConfig.h"
#import "JEDISystem.h"
#import "TiSaveData.h"
#import "KChartParam.h"
#import "MAData.h"

NSString *const tiArgumentConfig        = @"TiArgumentConfig";

// ma
NSString *const maPeriodKey             = @"period";
NSString *const maWidthKey              = @"maLineWidth";
NSString *const maColorKey              = @"maLineColorRgba";

// rsi
NSString *const rsiShortPeriodKey       = @"shortPeriod";
NSString *const rsiShortWidthKey        = @"rsiShortLineWidth";
NSString *const rsiShortColorKey        = @"rsiShortLineColorRgba";
NSString *const rsiLongPeriodKey        = @"longPeriod";
NSString *const rsiLongWidthKey         = @"rsiLongLineWidth";
NSString *const rsiLongColorKey         = @"rsiLongLineColorRgba";

// kdj
NSString *const kdjPeriodKey               = @"period";
NSString *const kLineWidthKey              = @"kLineWidth";
NSString *const kLineColorKey              = @"kLineColorRgba";
NSString *const dLineWidthKey              = @"dLineWidth";
NSString *const dLineColorKey              = @"dLineColorRgba";
NSString *const jLineWidthKey              = @"jLineWidth";
NSString *const jLineColorKey              = @"jLineColorRgba";

// macd
NSString *const macdShortPeriodKey         = @"shortPeriod";
NSString *const macdLongPeriodKey          = @"longPeriod";
NSString *const macdPeriodSignalKey        = @"periodSignal";
NSString *const macdDiffLineWidthKey       = @"diffLineWidth";
NSString *const macdDiffLineColorKey       = @"diffLineColorRgba";
NSString *const macdDemLineWidthKey        = @"demLineWidth";
NSString *const macdDemLineColorKey        = @"demLineColorRgba";
NSString *const macdPositiveColorKey       = @"macdPositiveColorRgba";
NSString *const macdNegativeColorKey       = @"macdNegativeColorRgba";

// Bollinger
NSString *const bollingerBandPeriodKey     = @"period";
NSString *const bollingerBandKKey          = @"k";
NSString *const bollingerBandLineWidthKey  = @"lineWidth";
NSString *const bollingerBandLineColorKey  = @"lineColorRgba";
NSString *const bollingerBandFillColorKey  = @"fillColorRgba";

static TiArgumentConfig *instance = nil;

@interface TiArgumentConfig() {
    NSString *_fileName;
}
@end

@implementation TiArgumentConfig

// ma
//@synthesize maPeriod;
//@synthesize maWidth;
//@synthesize maColor;

@synthesize maDataArray;

// rsi
@synthesize rsiShortPeriod;
@synthesize rsiShortWidth;
@synthesize rsiShortColor;

@synthesize rsiLongPeriod;
@synthesize rsiLongWidth;
@synthesize rsiLongColor;

// kdj
@synthesize kdjPeriod;
@synthesize kLineWidth;
@synthesize kLineColor;
@synthesize dLineWidth;
@synthesize dLineColor;
@synthesize jLineWidth;
@synthesize jLineColor;

// macd
@synthesize macdShortPeriod;
@synthesize macdLongPeriod;
@synthesize macdPeriodSignal;
@synthesize macdDiffLineWidth;
@synthesize macdDiffLineColor;
@synthesize macdDemLineWidth;
@synthesize macdDemLineColor;
@synthesize macdPositiveColor;
@synthesize macdNegativeColor;

// Bollinger
@synthesize bollingerBandPeriod;
@synthesize bollingerBandK;
@synthesize bollingerBandLineWidth;
@synthesize bollingerBandLineColor;
@synthesize bollingerBandFillColor;

+ (TiArgumentConfig *)getInstance {
    if (instance == nil) {
        instance = [[TiArgumentConfig alloc] init];
    }
    return instance;
}

- (void)reloadData {
    
    NSDictionary *dic = [[[TiSaveData getInstance] tiClientMap] objectForKey:[[KChartParam getInstance] instrumentName]];
    
//    maDataArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    [self initMADataArray:dic];
//    NSDictionary *maDic     = [dic objectForKey:[@(ma) stringValue]];
    
    //    self.maPeriod           = [maDic objectForKey:maPeriodKey];
    //    self.maWidth            = [maDic objectForKey:maWidthKey];
    //    self.maColor            = [self stringToColor:[maDic objectForKey:maColorKey]];
    
    NSDictionary *rsiDic    = [dic objectForKey:[@(rsi) stringValue]];
    self.rsiShortPeriod     = [rsiDic objectForKey:rsiShortPeriodKey];
    self.rsiShortWidth      = [rsiDic objectForKey:rsiShortWidthKey];
    self.rsiShortColor      = [self stringToColor:[rsiDic objectForKey:rsiShortColorKey]];
    self.rsiLongPeriod      = [rsiDic objectForKey:rsiLongPeriodKey];
    self.rsiLongWidth       = [rsiDic objectForKey:rsiLongWidthKey];
    self.rsiLongColor       = [self stringToColor:[rsiDic objectForKey:rsiLongColorKey]];
    
    NSDictionary *kdjDic    = [dic objectForKey:[@(kdj) stringValue]];
    self.kdjPeriod          = [kdjDic objectForKey:kdjPeriodKey];
    self.kLineWidth         = [kdjDic objectForKey:kLineWidthKey];
    self.kLineColor         = [self stringToColor:[kdjDic objectForKey:kLineColorKey]];
    self.dLineWidth         = [kdjDic objectForKey:dLineWidthKey];
    self.dLineColor         = [self stringToColor:[kdjDic objectForKey:dLineColorKey]];
    self.jLineWidth         = [kdjDic objectForKey:jLineWidthKey];
    self.jLineColor         = [self stringToColor:[kdjDic objectForKey:jLineColorKey]];
    
    NSDictionary *macdDic   = [dic objectForKey:[@(macd) stringValue]];
    self.macdShortPeriod    = [macdDic objectForKey:macdShortPeriodKey];
    self.macdLongPeriod     = [macdDic objectForKey:macdLongPeriodKey];
    self.macdPeriodSignal   = [macdDic objectForKey:macdPeriodSignalKey];
    self.macdDiffLineWidth  = [macdDic objectForKey:macdDiffLineWidthKey];
    self.macdDiffLineColor  = [self stringToColor:[macdDic objectForKey:macdDiffLineColorKey]];
    self.macdDemLineWidth   = [macdDic objectForKey:macdDemLineWidthKey];
//    self.macdDemLineColor   = [macdDic objectForKey:macdDemLineColorKey];
    self.macdDemLineColor   = [self stringToColor:[macdDic objectForKey:macdDemLineColorKey]];
    self.macdPositiveColor  = [self stringToColor:[macdDic objectForKey:macdPositiveColorKey]];
    self.macdNegativeColor  = [self stringToColor:[macdDic objectForKey:macdNegativeColorKey]];
    
    NSDictionary *bollingerBandDic  = [dic objectForKey:[@(bollinger_band) stringValue]];
    self.bollingerBandPeriod        = [bollingerBandDic objectForKey:bollingerBandPeriodKey];
    self.bollingerBandK             = [bollingerBandDic objectForKey:bollingerBandKKey];
    self.bollingerBandLineWidth     = [bollingerBandDic objectForKey:bollingerBandLineWidthKey];
    self.bollingerBandLineColor     = [self stringToColor:[bollingerBandDic objectForKey:bollingerBandLineColorKey]];
    self.bollingerBandFillColor     = [self stringToColor:[bollingerBandDic objectForKey:bollingerBandFillColorKey]];
    
    [self checkInit];
}

- (void)initMADataArray:(NSDictionary *)dic {
    maDataArray = [[NSMutableArray alloc] initWithObjects:[MAData new], [MAData new], [MAData new], [MAData new], [MAData new], nil];
    
    for (int i = 0; i < 5; i++) {
        NSDictionary *maDic = [dic objectForKey:[NSString stringWithFormat:@"%d%@", i + 1, [@(ma) stringValue]]];
        MAData *maData = [[MAData alloc] init];
        maData.maPeriod           = [maDic objectForKey:maPeriodKey];
        maData.maWidth            = [maDic objectForKey:maWidthKey];
        maData.maColor            = [self stringToColor:[maDic objectForKey:maColorKey]];
        [maDataArray replaceObjectAtIndex:i withObject:maData];
    }
}

- (void)checkInit {
//    [self resetMA];
    [self resetMADataArray];
    [self resetKDJ];
    [self resetMACD];
    [self resetRSI];
    [self resetBollingerBand];
}

- (void)resetMADataArray {
    for (MAData *data in maDataArray) {
        [self resetMA:data];
    }
}

- (void)resetMA:(MAData *)data {
    if (data.maPeriod == nil) {
        data.maPeriod = [[NSNumber alloc] initWithInt:DefaultMaPeriod];
    }
    if (data.maWidth == nil) {
        data.maWidth = [[NSNumber alloc] initWithInt:DefaultMaWidth];
    }
    if (data.maColor == nil) {
        data.maColor = DefaultMaColor;
    }
}

- (void)resetRSI {
    if (self.rsiShortPeriod == nil) {
        self.rsiShortPeriod = [[NSNumber alloc] initWithInt:DefaultRsiShortPeriod];
    }
    if (self.rsiShortWidth == nil) {
        self.rsiShortWidth = [[NSNumber alloc] initWithInt:DefaultRsiShortWidth];
    }
    if (self.rsiShortColor == nil) {
        self.rsiShortColor = DefaultRsiShortColor;
    }
    if (self.rsiLongPeriod == nil) {
        self.rsiLongPeriod = [[NSNumber alloc] initWithInt:DefaultRsiLongPeriod];
    }
    if (self.rsiLongWidth == nil) {
        self.rsiLongWidth = [[NSNumber alloc] initWithInt:DefaultRsiLongWidth];
    }
    if (self.rsiLongColor == nil) {
        self.rsiLongColor = DefaultRsiLongColor;
    }
}

- (void)resetMACD {
    if (self.macdShortPeriod == nil) {
        self.macdShortPeriod = [[NSNumber alloc] initWithInt:DefaultmacdShortPeriod];
    }
    if (self.macdLongPeriod == nil) {
        self.macdLongPeriod = [[NSNumber alloc] initWithInt:DefaultmacdLongPeriod];
    }
    if (self.macdPeriodSignal == nil) {
        self.macdPeriodSignal = [[NSNumber alloc] initWithInt:DefaultmacdPeriodSignal];
    }
    if (self.macdDiffLineWidth == nil) {
        self.macdDiffLineWidth = [[NSNumber alloc] initWithInt:DefaultmacdDiffLineWidth];
    }
    if (self.macdDiffLineColor == nil) {
        self.macdDiffLineColor = DefaultmacdDiffLineColor;
    }
    if (self.macdDemLineWidth == nil) {
        self.macdDemLineWidth = [[NSNumber alloc] initWithInt:DefaultmacdDiffLineWidth];
    }
    if (self.macdDemLineColor == nil) {
        self.macdDemLineColor = DefaultmacdDemLineColor;
    }
    if (self.macdPositiveColor == nil) {
        self.macdPositiveColor = DefaultmacdPositiveColor;
    }
    if (self.macdNegativeColor == nil) {
        self.macdNegativeColor = DefaultmacdNegativeColor;
    }
}

- (void)resetKDJ {
    if (self.kdjPeriod == nil) {
        self.kdjPeriod = [[NSNumber alloc] initWithInt:DefaultkdjPeriod];
    }
    if (self.kLineWidth == nil) {
        self.kLineWidth = [[NSNumber alloc] initWithInt:DefaultkLineWidth];
    }
    if (self.kLineColor == nil) {
        self.kLineColor = DefaultkLineColor;
    }
    if (self.dLineWidth == nil) {
        self.dLineWidth = [[NSNumber alloc] initWithInt:DefaultdLineWidth];
    }
    if (self.dLineColor == nil) {
        self.dLineColor = DefaultdLineColor;
    }
    if (self.jLineWidth == nil) {
        self.jLineWidth = [[NSNumber alloc] initWithInt:DefaultjLineWidth];
    }
    if (self.jLineColor == nil) {
        self.jLineColor = DefaultjLineColor;
    }
}

- (void)resetBollingerBand {
    if (self.bollingerBandPeriod == nil) {
        self.bollingerBandPeriod= [[NSNumber alloc] initWithInt:DefaultbollingerBandPeriod];
    }
    if (self.bollingerBandK == nil) {
        self.bollingerBandK = [[NSNumber alloc] initWithInt:DefaultbollingerBandK];
    }
    if (self.bollingerBandLineWidth == nil) {
        self.bollingerBandLineWidth= [[NSNumber alloc] initWithInt:DefaultbollingerBandLineWidth];
    }
    if (self.bollingerBandLineColor == nil) {
        self.bollingerBandLineColor = DefaultbollingerBandLineColor;
    }
    if (self.bollingerBandFillColor == nil) {
        self.bollingerBandFillColor = DefaultbollingerBandFillColor;
    }
}

- (UIColor *)stringToColor:(NSString *)colorString {
    if (colorString == nil || [colorString isEqualToString:@""]) {
        return nil;
    }
    NSArray *colorArray = [colorString componentsSeparatedByString:@","];
    return RGBAlpha([colorArray[0] intValue], [colorArray[1] intValue], [colorArray[2] intValue], [colorArray[3] intValue]);
}

@end
