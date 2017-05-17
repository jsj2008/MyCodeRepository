//
//  TiDefaultArgument.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/2.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#ifndef TiDefaultArgument_h
#define TiDefaultArgument_h

#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:((a) / 255.0)]

#define DefaultMaPeriod 20
#define DefaultMaWidth  2
#define DefaultMaColor  RGBAlpha(64.0, 128.0, 255.0, 255.0)

#define DefaultRsiShortPeriod 3
#define DefaultRsiShortWidth  2
#define DefaultRsiShortColor  RGBAlpha(32.0, 140.0, 32.0, 255.0)
#define DefaultRsiLongPeriod  6
#define DefaultRsiLongWidth   2
#define DefaultRsiLongColor   RGBAlpha(168.0, 32.0, 32.0, 255.0)

#define DefaultkdjPeriod 9
#define DefaultkLineWidth  2
#define DefaultkLineColor RGBAlpha(168.0, 0.0, 0.0, 255.0)
#define DefaultdLineWidth  2
#define DefaultdLineColor RGBAlpha(168.0, 168.0, 0.0, 255.0)
#define DefaultjLineWidth  2
#define DefaultjLineColor RGBAlpha(0.0, 168.0, 0.0, 255.0)

#define DefaultmacdShortPeriod 12
#define DefaultmacdLongPeriod  26
#define DefaultmacdPeriodSignal  9
#define DefaultmacdDiffLineWidth 2
#define DefaultmacdDiffLineColor RGBAlpha(64.0, 220.0, 0.0, 255.0)
#define DefaultmacdDemLineWidth  2
#define DefaultmacdDemLineColor RGBAlpha(220.0, 220.0, 64.0, 255.0)
#define DefaultmacdPositiveColor  RGBAlpha(64.0, 640.0, 255.0, 255.0)
#define DefaultmacdNegativeColor  RGBAlpha(220.0, 64.0, 64.0, 255.0)

#define DefaultbollingerBandPeriod 20
#define DefaultbollingerBandK  2
#define DefaultbollingerBandLineWidth  1
#define DefaultbollingerBandLineColor RGBAlpha(96.0, 140.0, 255.0, 255.0)
#define DefaultbollingerBandFillColor RGBAlpha(64.0, 128.0, 32.0, 20.0)

#endif /* TiDefaultArgument_h */
