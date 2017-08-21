//
//  ConsigneeCell.m
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ConsigneeCell.h"

@interface ConsigneeCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation ConsigneeCell

- (void)drawCell{
    
    [self addSubview:self.bgView];
    [self addSubview:self.lineView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.defaultButton];
    [self addSubview:self.editButton];
    [self addSubview:self.deleteButton];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ConsigneeModel *consignee = (ConsigneeModel *)self.cellData;
        CGFloat cellHeight = [ConsigneeCell heightForCell:consignee];
        
        self.bgView.height = cellHeight - 20;
        
        self.nameLabel.text = consignee.name;
        [self.nameLabel sizeToFit];
        self.nameLabel.left = 22;
        self.nameLabel.top = 35;
        
        self.phoneLabel.text = consignee.phone;
        [self.phoneLabel sizeToFit];
        self.phoneLabel.left = self.nameLabel.right + 10;
        self.phoneLabel.top = 35;
        
        NSString *district = consignee.district?consignee.district:@"";
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", consignee.province, consignee.city, district,consignee.address];
        self.addressLabel.width = SCREEN_WIDTH - 22 * 2;
        [self.addressLabel sizeToFit];
        self.addressLabel.left = 22;
        self.addressLabel.top = self.nameLabel.bottom + 5;
        
        self.lineView.top = cellHeight - 40;
        
        self.defaultButton.left = 4;
        self.defaultButton.centerY = cellHeight - 20;
        self.defaultButton.selected = consignee.isDefault;
        
        self.deleteButton.right = SCREEN_WIDTH - 10;
        self.deleteButton.centerY = cellHeight - 20;
        
        self.editButton.right = self.deleteButton.left - 0;
        self.editButton.centerY = cellHeight - 20;
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        
        ConsigneeModel *consignee = (ConsigneeModel *)cellData;
        
        CGSize textSize = [[NSString stringWithFormat:@"%@ %@ %@", consignee.province, consignee.city, consignee.address] sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 22 * 2];
        
        return ceil(textSize.height) + 110;
    }
    return 0;
}

#pragma mark - Getters And Setters

- (UIView *)bgView {
    
    if ( !_bgView ) {
        _bgView = [[UILabel alloc] initWithFrame:CGRectMake(12, 20, SCREEN_WIDTH - 12 * 2, 100)];
        _bgView.backgroundColor = Color_White;
        _bgView.layer.borderWidth = LINE_WIDTH;
        _bgView.layer.borderColor = Color_Gray209.CGColor;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 2.f;
        
    }
    
    return _bgView;
    
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        _lineView = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12 * 2, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray209;
        
    }
    
    return _lineView;
    
}

- (UILabel *)nameLabel {
    
    if ( !_nameLabel ) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _nameLabel.textColor = Color_Gray26;
        _nameLabel.font = FONT(16);
    }
    
    return _nameLabel;
    
}

- (UILabel *)phoneLabel {
    
    if ( !_phoneLabel ) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _phoneLabel.textColor = Color_Gray26;
        _phoneLabel.font = FONT(16);
    }
    
    return _phoneLabel;
    
}

- (UILabel *)addressLabel {
    
    if ( !_addressLabel ) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _addressLabel.textColor = Color_Gray153;
        _addressLabel.font = FONT(14);
        _addressLabel.numberOfLines = 0;
    }
    
    return _addressLabel;
    
}

- (UIButton *)defaultButton {
    
    if ( !_defaultButton ) {
        _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _defaultButton.frame = CGRectMake(0, 0, 120, 40);
        [_defaultButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_defaultButton setTitle:@" 设为默认" forState:UIControlStateNormal];
        [_defaultButton setTitleColor:Color_Gray153 forState:UIControlStateNormal];
        [_defaultButton setImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
        [_defaultButton setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
        _defaultButton.titleLabel.font = FONT(14);
        //[_defaultButton sizeToFit];
        [_defaultButton addTarget:self action:@selector(handleDefaultButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _defaultButton;
}

- (UIButton *)editButton {
    
    if ( !_editButton ) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(0, 0, 80, 40);
        [_editButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_editButton setTitle:@" 编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:Color_Gray153 forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
        _editButton.titleLabel.font = FONT(14);
        //[_editButton sizeToFit];
        [_editButton addTarget:self action:@selector(handleEditButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _editButton;
}

- (UIButton *)deleteButton {
    
    if ( !_deleteButton ) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(0, 0, 80, 40);
        [_deleteButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_deleteButton setTitle:@" 删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:Color_Gray153 forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = FONT(14);
        //[_deleteButton sizeToFit];
        [_deleteButton addTarget:self action:@selector(handleDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deleteButton;
}

#pragma mark - Event Response

- (void)handleDefaultButton {
    
    if ( [self.delegate respondsToSelector:@selector(defaultButtonDidTappedWithConsignee:)]) {
        ConsigneeModel *consignee = (ConsigneeModel *)self.cellData;
        [self.delegate defaultButtonDidTappedWithConsignee:consignee];
    }
    
}

- (void)handleEditButton {
    
    if ( [self.delegate respondsToSelector:@selector(editButtonDidTappedWithConsignee:)]) {
        ConsigneeModel *consignee = (ConsigneeModel *)self.cellData;
        [self.delegate editButtonDidTappedWithConsignee:consignee];
    }
    
}

- (void)handleDeleteButton {
    
    if ( [self.delegate respondsToSelector:@selector(deleteButtonDidTappedWithConsignee:)]) {
        ConsigneeModel *consignee = (ConsigneeModel *)self.cellData;
        [self.delegate deleteButtonDidTappedWithConsignee:consignee];
    }
    
}

@end
