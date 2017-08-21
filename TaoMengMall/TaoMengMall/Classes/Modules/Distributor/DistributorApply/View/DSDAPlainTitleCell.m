//
//  PlainTitleCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSDAPlainTitleCell.h"

@interface DSDAPlainTitleCell ()

@property (nonatomic, strong)UILabel *titleLabel;

@end


@implementation DSDAPlainTitleCell

- (void)drawCell
{
    [self cellAddSubView:self.titleLabel];
}

- (void)reloadData
{
    if (self.cellData) {
        NSDictionary *model = (NSDictionary*)self.cellData;
        self.titleLabel.text = model[@"title"]?model[@"title"]:@"";
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = [[self class]heightForCell:self.cellData]/2;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.centerY = self.height/2;
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 46;
    }
    return height;
}

#pragma mark - Subviews
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
