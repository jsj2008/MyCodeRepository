//
//  MHModule10Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule10Cell.h"
#import "MHModuleModel.h"
#import "MHSingleImageView.h"

#define PADDING     10

@interface MHModule10Cell ()
@property (nonatomic, strong) NSMutableArray *moduleViews;
@end

@implementation MHModule10Cell



- (void)reloadData
{
    
    if (self.cellData) {
        
        self.backgroundColor = Color_White;
        
        MHModuleModel *model = self.cellData;
        
        for (int i = 0; i<model.items.count; i++) {
            
            MHItemModel *item = [model.items safeObjectAtIndex:i];
            
            NSString *link = item.link?item.link:@"";
            NSString *image = item.image?item.image:@"";
            
            MHSingleImageView *module = [self.moduleViews safeObjectAtIndex:i];
            [module reloadData:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_s"}];
            
            [self cellAddSubview:module];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        CGFloat width = (SCREEN_WIDTH-3*PADDING) * 0.4275;
        if (item) {
            height = width / item.ar + 2*PADDING;
        }else{
            height = width / 0.77 +2*PADDING;
        }
        
    }
    return height;
}

- (NSMutableArray*)moduleViews
{
    if (!_moduleViews) {
        
        CGFloat width = (SCREEN_WIDTH-3*PADDING) * 0.4275;
        MHModuleModel *model = self.cellData;
        MHItemModel *item = [model.items safeObjectAtIndex:0];
        CGFloat height = 0.77;
        if (item) {
            height = width/item.ar;
        }
        
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:model.items.count];
        //CGFloat moduleView2Height = 0.0;
        
        for (int i = 0; i<4; i++) {
            //MHItemModel *item = [model.items safeObjectAtIndex:i];
            MHSingleImageView *moduleView ;
            if (i == 0) {
                moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(PADDING, PADDING, width, height)];
                
            }else if (i == 1){
                moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(width+2*PADDING, PADDING, SCREEN_WIDTH - width - 3*PADDING, (height-PADDING)/2)];
                //moduleView2Height = (SCREEN_WIDTH - width)/item.ar;
            }else if (i == 2){
                moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(width+2*PADDING, (height-PADDING)/2+2*PADDING, (height-PADDING)/2, (height-PADDING)/2)];
            }else if (i == 3){
                moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - (height-PADDING)/2 - PADDING, (height-PADDING)/2+2*PADDING, (height-PADDING)/2, (height-PADDING)/2)];
            }
            
            [modules addObject:moduleView];
        }
        
        _moduleViews = modules;
    }
    return _moduleViews;
}
@end

