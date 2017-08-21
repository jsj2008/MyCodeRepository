//
//  TitleDetailCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "TitleDetailCell.h"

@interface TitleDetailCell ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *descLabel;
@property (nonatomic, strong)UIImageView *moreImageView;
@property (nonatomic, strong)UIView *line;
@end

@implementation TitleDetailCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.descLabel];
    [self cellAddSubView:self.moreImageView];
    [self cellAddSubView:self.line];
    
    weakify(self);
    [self bk_whenTapped:^{
        strongify(self);
        NSDictionary *model = (NSDictionary*)self.cellData;
        [[TTNavigationService sharedService] openUrl:model[@"link"]];
    }];
}

- (void)reloadData
{
    if (self.cellData) {
        NSDictionary *model = (NSDictionary*)self.cellData;
        
        self.titleLabel.text = model[@"title"]?model[@"title"]:@"";
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = [[self class]heightForCell:self.cellData]/2;
        
        self.moreImageView.centerY = self.height/2;
        self.moreImageView.right = SCREEN_WIDTH -12;
        
        self.descLabel.text = model[@"desc"]?model[@"desc"]:@"";
        [self.descLabel sizeToFit];
        self.descLabel.centerY = self.titleLabel.centerY;
        self.descLabel.right = self.showMore?self.moreImageView.left-4:SCREEN_WIDTH-12;
    }
    self.line.hidden = !self.showLine;
    self.moreImageView.hidden = !self.showMore;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.line.bottom = self.height;
    self.moreImageView.centerY = self.height/2;
    self.titleLabel.centerY = self.height/2;
    self.descLabel.centerY = self.height/2;
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 52;
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

- (UILabel*)descLabel
{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.textColor = Color_Gray166;
        _descLabel = label;
    }
    return _descLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
    }
    
    return _moreImageView;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        _line = view;
    }
    return _line;
}
@end
