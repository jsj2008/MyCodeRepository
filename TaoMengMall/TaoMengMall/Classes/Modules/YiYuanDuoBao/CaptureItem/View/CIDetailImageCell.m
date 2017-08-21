//
//  ITImageCell.m
//  YouCai
//
//  Created by marco on 5/28/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CIDetailImageCell.h"

#import "CIDetailContentModel.h"

@interface CIDetailImageCell ()

@property (nonatomic, strong) UIImageView *itemImageView;

@end

@implementation CIDetailImageCell

- (void)drawCell{
    //self.backgroundColor = Color_White;
    self.backgroundColor = Color_Gray245;

    [self addSubview:self.itemImageView];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        CIDetailContentModel *imageUnit = (CIDetailContentModel *)self.cellData;
        
        [self.itemImageView setOnlineImage:imageUnit.image];
        
        self.itemImageView.height = ( SCREEN_WIDTH - 20 ) / imageUnit.ar;
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if ( cellData ) {
        
        CIDetailContentModel *imageUnit = (CIDetailContentModel *)cellData;
        
        return ( SCREEN_WIDTH - 20 ) / imageUnit.ar;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)itemImageView {
    
    if ( !_itemImageView ) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCREEN_WIDTH)];
    }
    
    return _itemImageView;
}


@end
