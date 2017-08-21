//
//  CSConsigneeInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CSConsigneeInfoCell.h"
#import "CSConsigneeInfoModel.h"

@interface CSConsigneeInfoCell ()

@property (nonatomic, strong) UIImageView *locationImageView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UILabel *contactLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation CSConsigneeInfoCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self addSubview:self.locationImageView];
    [self addSubview:self.topLineView];
    [self addSubview:self.bottomLineView];
    [self addSubview:self.contactLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.noticeLabel];
    [self addSubview:self.moreImageView];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        self.noticeLabel.hidden = YES;
        //self.moreImageView.hidden = YES;
        
        CSConsigneeInfoModel *consigneeInfo = (CSConsigneeInfoModel *)self.cellData;
        
        self.bottomLineView.bottom = [CSConsigneeInfoCell heightForCell:consigneeInfo];
        
        self.contactLabel.text = [NSString stringWithFormat:@"%@ %@", consigneeInfo.name, consigneeInfo.phone];
        [self.contactLabel sizeToFit];
        self.contactLabel.left = 40;
        self.contactLabel.top = 15;
        self.contactLabel.width = self.moreImageView.left -10- self.contactLabel.left;
        
        self.addressLabel.text = [NSString stringWithFormat:@"%@", consigneeInfo.address];
        self.addressLabel.left = 40;
        self.addressLabel.top = self.contactLabel.bottom + 7;
        self.addressLabel.width = self.moreImageView.left - 10 -self.addressLabel.left;
        [self.addressLabel sizeToFit];

    } else {
        
        self.noticeLabel.hidden = NO;
        self.contactLabel.text = @"";
        self.addressLabel.text = @"";
        //self.moreImageView.hidden = NO;
        
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        CSConsigneeInfoModel *consigneeInfo = (CSConsigneeInfoModel *)cellData;
        CGSize textSize = [consigneeInfo.address?consigneeInfo.address:@"" sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 50];
        return 54 + textSize.height;

    }
    return 70;
}

#pragma mark - Getters And Setters

- (UIImageView*)locationImageView
{
    if (!_locationImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 28, 15, 21)];
        imageView.image = [UIImage imageNamed:@"cart_consignee_location"];
        imageView.centerY = 35;
        _locationImageView = imageView;
    }
    return _locationImageView;
}

- (UIView *)topLineView {
    
    if ( !_topLineView ) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _topLineView.backgroundColor = Color_Gray209;
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

- (UILabel *)noticeLabel {
    
    if ( !_noticeLabel ) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH - 40, 70)];
        _noticeLabel.textColor = Color_Gray113;
        _noticeLabel.font = FONT(16);
        _noticeLabel.text = @"请点击添加联系方式";
        _noticeLabel.numberOfLines = 1;
    }
    
    return _noticeLabel;
    
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = 35;
        _moreImageView.right = SCREEN_WIDTH - 15;
    }
    
    return _moreImageView;
}

@end
