//
//  ITCommentHeadCell.m
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITCommentHeadCell.h"
#import "ITCommentInfoModel.h"

@interface ITCommentHeadCell ()

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation ITCommentHeadCell

- (void)drawCell{
    
    self.backgroundColor = Color_White;
    
    [self addSubview:self.countLabel];
    //[self addSubview:self.moreButton];
    [self addSubview:self.moreImageView];
    
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        ITCommentInfoModel *commentInfo = (ITCommentInfoModel *)self.cellData;
        
        self.countLabel.text = [NSString stringWithFormat:@"买家留言（%@）", commentInfo.cmtCount];
        [self.countLabel sizeToFit];
        self.countLabel.top = 13;
        self.countLabel.left = 12;
        
    }
    
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if ( cellData ) {
        return 44;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UILabel *)countLabel {
    
    if ( !_countLabel ) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _countLabel.textColor = Color_Gray170;
        _countLabel.font = FONT(14);
    }
    
    return _countLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = self.centerY;
        _moreImageView.right = SCREEN_WIDTH - 13;
    }
    
    return _moreImageView;
}

- (UIButton *)moreButton {
    
    if ( !_moreButton ) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(0, 0, 0, 0);
        _moreButton.titleLabel.font = FONT(14);
        [_moreButton addTarget:self action:@selector(handleMoreButton) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setTitleColor:Color_Gray100 forState:UIControlStateNormal];
        [_moreButton setTitle:@"        " forState:UIControlStateNormal];
        [_moreButton sizeToFit];
        
        _moreButton.centerY = self.centerY;
        _moreButton.right = SCREEN_WIDTH - 28;
    }
    
    return _moreButton;
}

#pragma mark - Event Response

- (void)handleMoreButton {
    
    if ( self.cellData ) {
        
        ITCommentInfoModel *commentInfo = (ITCommentInfoModel *)self.cellData;
        
        [[TTNavigationService sharedService] openUrl:commentInfo.link];
        
    }
    
}

@end
