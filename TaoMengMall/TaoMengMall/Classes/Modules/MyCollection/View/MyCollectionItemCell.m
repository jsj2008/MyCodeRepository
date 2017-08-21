//
//  MyCollectionItemCell.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//



#import "MyCollectionItemCell.h"
#import "MCItemModel.h"

NSString *const kNOTIFY_COLLECTION_ITEM_SELECT_CHANGE = @"kNOTIFY_COLLECTION_ITEM_SELECT_CHANGE";

@interface MyCollectionItemCell()
@property (nonatomic, strong) TTCheckButton *checkButton;
@property (nonatomic,strong) UIImageView *coverImage;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *oPriceLabel;
@property (nonatomic,strong) UIButton *similarity;
@property (nonatomic,strong) UILabel *invalidLabel;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation MyCollectionItemCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.checkButton];
	[self cellAddSubView:self.coverImage];
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.priceLabel];
	[self cellAddSubView:self.oPriceLabel];
	[self cellAddSubView:self.similarity];
    [self cellAddSubView:self.lineView];
}

- (void)reloadData
{
	if (self.cellData) {
        MCItemModel *model = self.cellData;
//        MCItemModel *model = [[MCItemModel alloc] init];
//        model.image = @"http://s13.mogujie.cn/b7/bao/131012/vud8_kqywordekfbgo2dwgfjeg5sckzsew_310x426.jpg_200x999.jpg";
//        model.name = @"好额凤飞飞好额凤飞飞好额凤飞飞好额凤飞飞好额凤飞飞好额凤飞飞好额凤飞飞好额凤飞飞";
//        model.price = @"¥123";
//        model.oPrice = @"¥34";
        
        [self.coverImage setOnlineImage:model.image placeHolderImage:[UIImage imageNamed:@"placeholder_s"]];

        if (self.isEditing) {
            self.checkButton.hidden = NO;
            self.coverImage.left = self.checkButton.right + 4;
            
        }else {
            self.checkButton.hidden = YES;
            self.coverImage.left = 12;
        }
        self.titleLabel.text = model.name;
        self.titleLabel.left = self.coverImage.right + 10;
        self.titleLabel.top = self.coverImage.top;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.width = SCREEN_WIDTH - self.titleLabel.left - 14;
        [self.titleLabel sizeToFit];
        
        self.priceLabel.text = model.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.left = self.coverImage.right + 10;
        self.priceLabel.bottom = 140-22;
        
        
        NSAttributedString *oPriceWithLine =
        [[NSAttributedString alloc]initWithString:model.oPrice ? model.oPrice : @""
                                       attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSBaselineOffsetAttributeName: @(0)}];
        
        self.oPriceLabel.attributedText = oPriceWithLine;
        [self.oPriceLabel sizeToFit];
        self.oPriceLabel.left = self.priceLabel.right + 4;
        self.oPriceLabel.centerY = self.priceLabel.centerY;
        
        self.similarity.right = SCREEN_WIDTH - 12;
        self.similarity.centerY = self.priceLabel.centerY;
        
        if (model.error) {
            self.invalidLabel.hidden = NO;
        }else{
            self.invalidLabel.hidden = YES;
        }
        
        self.checkButton.selected = model.xxSelected;
        
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 140;
	}
    return height;
}

#pragma mark - Subviews
- (TTCheckButton *)checkButton
{
    if ( !_checkButton ) {
        _checkButton = [[TTCheckButton alloc] init];
        _checkButton.centerY = 70;
        _checkButton.left = 4;
        [_checkButton addTarget:self action:@selector(handleCheckButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _checkButton;
}

- (UIImageView *)coverImage
{
	if (!_coverImage) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
		imageView.centerY = 70;
        self.invalidLabel.width = imageView.width;
        self.invalidLabel.bottom = imageView.height;
        [imageView addSubview:self.invalidLabel];
		_coverImage = imageView;
	}
	return _coverImage;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(62);
		label.text = @"";
		[label sizeToFit];
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UILabel *)priceLabel
{
	if (!_priceLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray(62);
		label.text = @"";
		[label sizeToFit];
		_priceLabel = label;
	}
	return _priceLabel;
}

- (UILabel *)oPriceLabel
{
	if (!_oPriceLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray182;
		label.text = @"";
		[label sizeToFit];
		_oPriceLabel = label;
	}
	return _oPriceLabel;
}

- (UIButton *)similarity
{
	if (!_similarity) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 59, 22)];
		button.layer.cornerRadius = 3;
		button.layer.masksToBounds = YES;
		button.backgroundColor = Color_White;
		[button setTitleColor:RGB(62, 62, 62) forState:UIControlStateNormal];
        button.layer.borderColor = RGB(62, 62, 62).CGColor;
        button.layer.borderWidth = 0.5;
		button.titleLabel.font = FONT(12);
		[button setTitle:@"找相似" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(handleSimilarity:) forControlEvents:UIControlEventTouchUpInside];
		_similarity = button;
	}
	return _similarity;
}

- (UILabel *)invalidLabel
{
    if (!_invalidLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 27)];
        label.font = FONT(12);
        label.textColor = Color_White;
        label.backgroundColor = RGBA(62, 62, 62, 0.7);
        label.text = @"失效";
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        _invalidLabel = label;
    }
    return _invalidLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 139, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray(235);
        _lineView  = view;
    }
    return _lineView;
}

#pragma mark - Actions
- (void)handleSimilarity:(UIButton*)button
{
    MCItemModel *model = self.cellData;
    [[TTNavigationService sharedService] openUrl:model.similarLink];
}

- (void)handleCheckButton
{
    MCItemModel *model = self.cellData;
    model.xxSelected = !model.xxSelected;
    
//    MCItemModel *model = [[MCItemModel alloc] init];
//    model.id = @"1";
    
    self.checkButton.selected = !self.checkButton.isSelected;
//    NSString *selectType;
//    if (self.checkButton.selected) {
//        selectType = @"delete";
//    }else {
//        selectType = @"cancle";
//    }
//    NSDictionary *dic = @{@"type":selectType,@"ID":model.id};
//    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_COLLECTION_ITEM_SELECT_CHANGE object:nil];
}

@end
