//
//  ITRecommendCell.m
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ITRecommendCell.h"
#import "ITRecommendModel.h"
#import "ITRecommendView.h"

#define PADDING 10.f
#define ICON_WIDTH ((SCREEN_WIDTH - 3 * PADDING) / 2)

@interface ITRecommendCell ()
@property (nonatomic, strong) ITRecommendView *leftItemView;
@property (nonatomic, strong) ITRecommendView *rightItemView;
@end

@implementation ITRecommendCell

- (void)drawCell
{
    [self cellAddSubView:self.leftItemView];
    [self cellAddSubView:self.rightItemView];
}

- (void)reloadData {
    
    if ( self.cellData ) {
        NSDictionary *items = self.cellData;
        
        ITRecommendModel *model = [items objectForKey:@"leftItem"];
        self.leftItemView.height = ICON_WIDTH/model.ar + 60;
        self.rightItemView.height = self.leftItemView.height;
        
        [self.leftItemView reloadData:[items objectForKey:@"leftItem"]];
        [self.rightItemView reloadData:[items objectForKey:@"rightItem"]];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        
        ITRecommendModel *itemModel = cellData;
        
        if (itemModel) {
            height = (ICON_WIDTH / itemModel.ar + 60);
        }
        
    }
    return height;
}

- (ITRecommendView *)leftItemView
{
    if ( !_leftItemView ) {
        _leftItemView = [[ITRecommendView alloc] initWithFrame:CGRectMake(PADDING, 0, CELL_WIDTH, CELL_WIDTH + 60)];
    }
    return _leftItemView;
}

- (ITRecommendView *)rightItemView
{
    if ( !_rightItemView ) {
        _rightItemView = [[ITRecommendView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + PADDING, 0, CELL_WIDTH, CELL_WIDTH + 60)];
    }
    return _rightItemView;
}
@end
