//
//  ITTextCell.m
//  YouCai
//
//  Created by marco on 5/28/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CIDetailTextCell.h"

@interface CIDetailTextCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CIDetailTextCell

- (void)drawCell{
    //self.backgroundColor = Color_White;
    self.backgroundColor = Color_Gray245;

    [self addSubview:self.contentLabel];
    
}

- (void)reloadData{
    
    NSString *content = (NSString *)self.cellData;
    
    self.contentLabel.text = content;
    [self.contentLabel sizeToFit];
    self.contentLabel.width = SCREEN_WIDTH - 10 * 2;
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    NSString *text = (NSString *)cellData;
    
    CGSize textSize = [text sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 10 * 2];
    
    return ceil(textSize.height) + 15; // 文字高度 加 上下padding
}

#pragma mark - Getters And Setters

- (UILabel *)contentLabel {
    
    if ( !_contentLabel ) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 10 * 2, 0)];
        _contentLabel.textColor = Color_Gray148;
        _contentLabel.font = FONT(14);
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}
@end
