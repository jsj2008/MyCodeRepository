//
//  MyCollectionShopCell.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "MyCollectionShopCell.h"
#import "MCShopModel.h"
#import "MCShopItemModel.h"

@interface MyCollectionShopCell()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *salesLabel;
@property (nonatomic,strong) UILabel *favLabel;
@property (nonatomic,strong) UIView *countView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *countLabel;

@property (nonatomic,strong) UIScrollView *imageScrView;
@property (nonatomic,strong) UIButton *likeButton;

@end

@implementation MyCollectionShopCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.iconView];
	[self cellAddSubView:self.nameLabel];
	[self cellAddSubView:self.salesLabel];
	[self cellAddSubView:self.favLabel];
	[self cellAddSubView:self.countView];
	
	[self cellAddSubView:self.imageScrView];
	[self cellAddSubView:self.likeButton];
}

- (void)reloadData
{
	if (self.cellData) {
        MCShopModel *model = self.cellData;
//        MCShopModel *model = [[MCShopModel alloc] init];
//        model.image = @"http://s13.mogujie.cn/b7/bao/131012/vud8_kqywordekfbgo2dwgfjeg5sckzsew_310x426.jpg_200x999.jpg";
//        model.name = @"速度解决四打飞机 防守打法是否是否是否第三方的是是否是否是否";
//        model.sales = @"12121";
//        model.favCount = @"4343434";
//        model.count = @"23";
//        MCShopItemModel *model1 = [[MCShopItemModel alloc] init];
//        model1.image =@"http://s13.mogujie.cn/b7/bao/131012/vud8_kqywordekfbgo2dwgfjeg5sckzsew_310x426.jpg_200x999.jpg";
//        NSMutableArray *arr = [NSMutableArray arrayWithObjects:model1,model1,model1,model1,model1,model1, nil];
//        model.items = arr;
        [self.imageScrView removeAllSubviews];
        [self.iconView setOnlineImage:model.image placeHolderImage:[UIImage imageNamed:@"placeholder_s"]];
        
        self.nameLabel.text = model.name;
        [self.nameLabel sizeToFit];
        self.nameLabel.left = self.iconView.right + 10;
        self.nameLabel.top = self.iconView.top;
        
        self.salesLabel.text = [NSString stringWithFormat:@"销量%@",model.sales];
        [self.salesLabel sizeToFit];
        self.salesLabel.left = self.nameLabel.left;
        self.salesLabel.top = self.nameLabel.bottom + 4;
        
       
        self.favLabel.text = [NSString stringWithFormat:@"收藏%@",model.favCount];
        [self.favLabel sizeToFit];
        self.favLabel.left = self.salesLabel.right + 4;
        self.favLabel.centerY = self.salesLabel.centerY;
        
        self.countLabel.text = [NSString stringWithFormat:@"%d",model.count];
        [self.countLabel sizeToFit];
        self.countLabel.centerX = self.titleLabel.centerX;
        self.countLabel.top = self.titleLabel.bottom+3;
        
        CGFloat margin = 15;
        CGFloat width = 110;
        CGFloat height = 110;
        for (int i = 0; i < model.items.count; i++) {
            MCShopItemModel *itemModel = [model.items safeObjectAtIndex:i];
            UIImageView *image = [[UIImageView alloc] init];
            image.top = 0;
            image.width = width;
            image.height =  height;
            image.left = i * width + i * margin;
            [image setOnlineImage:itemModel.image placeHolderImage:[UIImage imageNamed:@"placeholder_s"]];
            image.userInteractionEnabled = YES;
            [image bk_whenTapped:^{
                [[TTNavigationService sharedService] openUrl:itemModel.link];
            }];
            [self.imageScrView addSubview:image];
            
        }
        self.imageScrView.contentSize = CGSizeMake(model.items.count * width + model.items.count * margin, 0);
        
        if (self.nameLabel.right > self.likeButton.left) {
            self.nameLabel.width = self.likeButton.left-self.nameLabel.left;
        }
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 205;
	}
    return height;
}

#pragma mark - Subviews
- (UIImageView *)iconView
{
	if (!_iconView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
        imageView.layer.cornerRadius = 25;
        imageView.layer.masksToBounds = YES;
		
		_iconView = imageView;
	}
	return _iconView;
}

- (UILabel *)nameLabel
{
	if (!_nameLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray(45);
        
		_nameLabel = label;
	}
	return _nameLabel;
}

- (UILabel *)salesLabel
{
	if (!_salesLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(136);
		[label sizeToFit];
		_salesLabel = label;
	}
	return _salesLabel;
}

- (UILabel *)favLabel
{
	if (!_favLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(136);
		[label sizeToFit];
		_favLabel = label;
	}
	return _favLabel;
}

- (UIView *)countView
{
	if (!_countView) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 70, 40, 110)];
		view.backgroundColor = Color_Gray(244);
        [view addSubview:self.titleLabel];
        [view addSubview:self.countLabel];
		_countView = view;
	}
	return _countView;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 15, 15, 40)];
		label.font = FONT(14);
		label.textColor = Color_Gray(136);
		label.text = @"上\n新";
        label.numberOfLines = 2;
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UILabel *)countLabel
{
	if (!_countLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = RGB(255, 40, 66);
		[label sizeToFit];
		_countLabel = label;
	}
	return _countLabel;
}

- (UIScrollView *)imageScrView
{
	if (!_imageScrView) {
        UIScrollView *imageScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(55, 70, SCREEN_WIDTH - 55, 110)];
        imageScrView.showsHorizontalScrollIndicator = NO;
		_imageScrView = imageScrView;
	}
	return _imageScrView;
}

- (UIButton *)likeButton
{
	if (!_likeButton) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 59, 22)];
		button.layer.cornerRadius = 3;
		button.layer.masksToBounds = YES;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = Color_Gray(62).CGColor;
		button.backgroundColor = Color_White;
		[button setTitleColor:Color_Gray(62) forState:UIControlStateNormal];
		button.titleLabel.font = FONT(12);
		[button setTitle:@"找相似" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(handleLikeButton:) forControlEvents:UIControlEventTouchUpInside];
        button.centerY = 30;
        button.right = SCREEN_WIDTH - 12;
		_likeButton = button;
	}
	return _likeButton;
}

#pragma mark - Actions
- (void)handleLikeButton:(UIButton*)button
{
    MCShopModel *model = self.cellData;
    [[TTNavigationService sharedService] openUrl:model.similarLink];
}




@end
