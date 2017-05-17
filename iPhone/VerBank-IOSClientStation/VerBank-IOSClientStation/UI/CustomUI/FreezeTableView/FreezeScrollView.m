//
//  FreezeScrollView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "FreezeScrollView.h"
#import "UIView+FreezeTableView.h"

@implementation FreezeScrollView{
    NSMutableArray *lines;
}

@synthesize parent;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)reDraw {
    if (lines == nil) lines = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (UIView *view in lines) {
        [view removeFromSuperview];
    }
    
    [lines removeAllObjects];
    
    UIView *hidView = [[UIView alloc] initWithFrame:CGRectMake(0.0f - parent.normalSeperatorVLineWidth, 0, parent.normalSeperatorVLineWidth, self.bounds.size.height)];
    hidView.backgroundColor = parent.normalSeperatorLineColor;
    hidView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    [self addSubview:hidView];
    [lines addObject:hidView];
    
    UIView *line = nil;
    CGFloat x = 0.0f;
    NSUInteger columnCount = [parent.datasource arrayDataForTopHeader].count;
    for (int i = 0; i < columnCount; i++) {
        CGFloat width;
        if ([parent.datasource respondsToSelector:@selector(tableView:contentTableCellWidth:)]) {
            width = [parent.datasource tableView:parent contentTableCellWidth:i];
        }else {
            width = parent.cellWidth;
        }
        
        x += width + parent.normalSeperatorVLineWidth;
        
        line = [self addVerticalLineWithWidth:parent.normalSeperatorVLineWidth bgColor:parent.normalSeperatorLineColor atX:x];
        [lines addObject:line];
    }
}

- (void)dealloc {
    lines = nil;
}

@end
