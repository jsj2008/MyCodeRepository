//
//  ODConsigneeInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODConsigneeInfoCell.h"
#import "ODConsigneeInfoModel.h"

@interface ODConsigneeInfoCell ()
@property (nonatomic, strong) UIImageView *locationImageView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UILabel *contactLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation ODConsigneeInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.locationImageView];
    [self addSubview:self.topLineView];
    //[self addSubview:self.bottomLineView];
    [self addSubview:self.contactLabel];
    [self addSubview:self.addressLabel];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ODConsigneeInfoModel *consigneeInfo = (ODConsigneeInfoModel *)self.cellData;
        
        //consigneeInfo.address = @"df";
        //self.bottomLineView.bottom = [ODConsigneeInfoCell heightForCell:consigneeInfo];
        
        self.contactLabel.text = [NSString stringWithFormat:@"%@ %@", consigneeInfo.name, consigneeInfo.phone];
        [self.contactLabel sizeToFit];
        self.contactLabel.left = 40;
        self.contactLabel.top = 15;
        self.contactLabel.width = SCREEN_WIDTH -10- self.contactLabel.left;
        
        self.addressLabel.text = [NSString stringWithFormat:@"%@", consigneeInfo.address];
        self.addressLabel.left = 40;
        self.addressLabel.top = self.contactLabel.bottom + 7;
        self.addressLabel.width = SCREEN_WIDTH - 10 -self.addressLabel.left;
        [self.addressLabel sizeToFit];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        ODConsigneeInfoModel *consigneeInfo = (ODConsigneeInfoModel *)cellData;
        CGSize textSize = [consigneeInfo.address?consigneeInfo.address:@"" sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 50];
        return textSize.height + 54;
    }
    return 0;
}

#pragma mark - Getters And Setters
- (UIImageView*)locationImageView
{
    if (!_locationImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 28, 15, 21)];
        imageView.image = [UIImage imageNamed:@"cart_consignee_location"];
        _locationImageView = imageView;
    }
    return _locationImageView;
}

- (UIView *)topLineView {
    
    if ( !_topLineView ) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _topLineView.backgroundColor = Color_Gray233;
    }
    
    return _topLineView;
}

- (UIView *)bottomLineView {
    
    if ( !_bottomLineView ) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _bottomLineView.backgroundColor = Color_Gray209;
    }
    
    return _bottomLineView;
}

- (UILabel *)contactLabel {
    
    if ( !_contactLabel ) {
        _contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _contactLabel.textColor = Color_Gray66;
        _contactLabel.font = FONT(16);
        _contactLabel.numberOfLines = 1;
    }
    
    return _contactLabel;
}

- (UILabel *)addressLabel {
    
    if ( !_addressLabel ) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _addressLabel.textColor = Color_Gray140;
        _addressLabel.font = FONT(14);
        _addressLabel.numberOfLines = 0;
    }
    
    return _addressLabel;
}

@end
