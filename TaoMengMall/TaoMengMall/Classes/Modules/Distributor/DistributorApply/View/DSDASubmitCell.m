//
//  DSDASubmitCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSDASubmitCell.h"
#import "DSDistributorApplyModel.h"
#import "DistributorHeader.h"


@interface DSDASubmitCell ()
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation DSDASubmitCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.submitButton];
}

//- (void)reloadData
//{
//    if (self.cellData) {
//        DSDistributorApplyModel *model = (DSDistributorApplyModel*)self.cellData;
//        
//        BOOL enable = !IsEmptyString(model.name)&&!IsEmptyString(model.phone)&&model.frontImageObj&&model.backImageObj;
//        [self setSubmitButtonEnable:enable];
//    }
//}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 112;
    }
    return height;
}

#pragma mark  -Subviews
- (UIButton*)submitButton
{
    if (!_submitButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(42, 36, SCREEN_WIDTH-42*2, 40)];
        [button setTitle:@"提交" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(16);
        button.backgroundColor = Disable_Gray;
        button.enabled = NO;
        button.layer.cornerRadius = 4.f;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(handleSubmitButton) forControlEvents:UIControlEventTouchUpInside];
        _submitButton = button;
    }
    return _submitButton;
}

#pragma mark -
//- (void)setSubmitButtonEnable:(BOOL)enable
//{
//    self.submitButton.enabled = enable;
//    if (enable) {
//        self.submitButton.backgroundColor = Enable_BLUE;
//    }else{
//        self.submitButton.backgroundColor = Disable_Gray;
//    }
//}

- (void)handleSubmitButton
{
    if ([self.delegate respondsToSelector:@selector(submitButtonTapped)]) {
        [self.delegate submitButtonTapped];
    }
}
@end
