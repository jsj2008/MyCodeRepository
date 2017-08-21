//
//  MHModule13Cell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModule13Cell.h"

#import "MHModuleModel.h"
#import "MHSingleImageView.h"

#define PADDING     10


@interface MHModule13Cell ()
@property (nonatomic, strong) NSMutableArray *moduleViews;
@end

@implementation MHModule13Cell



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
            [module reloadData:@{@"icon":image,@"link":link,@"placeholder":@"placeholder_w"}];
            
            [self cellAddSubview:module];
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        MHModuleModel *model = cellData;
        MHItemModel *item = [model.items safeObjectAtIndex:3];
        CGFloat width = (SCREEN_WIDTH-3*PADDING) * 0.4275;
        if (item) {
            height = width / item.ar +2*PADDING;
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
        NSMutableArray *modules = [NSMutableArray arrayWithCapacity:model.items.count];
        MHItemModel *item = [model.items safeObjectAtIndex:3];
        CGFloat height = 0.77;
        if (item) {
            height = width/item.ar;
        }
        
        for (int i = 0; i<4; i++) {
            MHSingleImageView *moduleView ;
            if (i == 0) {
                moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(PADDING, PADDING, (height - PADDING)/2, (height - PADDING)/2)];
                
            }else if (i == 1){
                moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - width -2*PADDING -(height - PADDING)/2, PADDING, (height - PADDING)/2, (height - PADDING)/2)];
            }else if (i == 2){
                moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(PADDING, (height - PADDING)/2+2*PADDING, SCREEN_WIDTH - width - 3*PADDING, (height - PADDING)/2)];
            }else if (i == 3){
                moduleView = [[MHSingleImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - width - PADDING, PADDING, width, height)];
            }
            
            [modules addObject:moduleView];
        }

        
        _moduleViews = modules;
    }
    return _moduleViews;
}
@end



