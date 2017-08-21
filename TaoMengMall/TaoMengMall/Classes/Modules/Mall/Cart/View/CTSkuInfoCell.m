//
//  CTSkuInfoCell.m
//  HongBao
//
//  Created by Ivan on 16/2/17.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CTSkuInfoCell.h"
#import "TTAmountView.h"
#import "TTCheckButton.h"
#import "CTSkuInfoModel.h"

NSString *const kNOTIFY_CART_SELECT_CHANGE = @"kNOTIFY_CART_SELECT_CHANGE";


@interface CTSkuInfoCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) TTCheckButton *checkButton;
@property (nonatomic, strong) UIImageView *skuImageView;
@property (nonatomic, strong) UILabel *invalidLabel;

@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, strong) UILabel *skuInfoLabel;
@property (nonatomic, strong) UILabel *skuStatusLabel;

//@property (nonatomic, strong) TTAmountView *amountView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oPriceLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UIButton *findButton;

@property (nonatomic, strong) MGSwipeButton *similarButton;
@property (nonatomic, strong) MGSwipeButton *deleteButton;


#pragma mark - Edit
@property (nonatomic, strong) UIView *editBackgroundView;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UIView *pipe1;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIView *pipe2;
@property (nonatomic, strong) UITextField *amountView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *dropdownButton;
@property (nonatomic, strong) UILabel *skuInfoEditLabel;
@property (nonatomic, strong) UIButton *deleteEditButton;

@end

@implementation CTSkuInfoCell

- (void)drawCell{
    
    self.backgroundColor = Color_Gray(248);
    
    [self cellAddSubView:self.checkButton];
    [self cellAddSubView:self.skuImageView];
    [self cellAddSubView:self.skuStatusLabel];
    [self cellAddSubView:self.itemTitleLabel];
    [self cellAddSubView:self.skuInfoLabel];
    [self cellAddSubView:self.priceLabel];
    [self cellAddSubView:self.oPriceLabel];
    [self cellAddSubView:self.amountLabel];
    [self cellAddSubView:self.findButton];

    [self cellAddSubView:self.editBackgroundView];
    [self cellAddSubView:self.deleteEditButton];
    [self cellAddSubView:self.bottomLineView];
}

- (void)reloadData{
    
    if ( self.cellData ) {
        
        CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
        
        //skuInfo.status = @"2";
        //skuInfo.oPrice = @"$9000000";
        //skuInfo.title = @"啥啥啥看看书可松开啥看看思考思考思考思考思考方法方法付付付付付付付付付可松开肯定肯定肯定肯定肯定肯定";
        //self.isEditing = NO;
        //self.isShopEditing = YES;
        
        self.bottomLineView.bottom = [CTSkuInfoCell heightForCell:self.cellData];
        if ( self.isLast ) {
            self.bottomLineView.hidden = YES;
        } else {
            self.bottomLineView.hidden = NO;
        }
        
        self.checkButton.selected = self.selected;
        self.checkButton.centerY = [CTSkuInfoCell heightForCell:self.cellData] / 2;
       
        [self.skuImageView setOnlineImage:skuInfo.image];
        self.skuImageView.centerY = self.checkButton.centerY;
        
        self.skuStatusLabel.hidden = YES;
        self.findButton.hidden = YES;
        self.invalidLabel.hidden = YES;
        self.deleteEditButton.hidden = YES;
        self.editBackgroundView.hidden = YES;
        
        self.priceLabel.hidden = NO;
        self.oPriceLabel.hidden = NO;
        self.amountLabel.hidden = NO;
        self.checkButton.hidden = NO;

        if (!IsEmptyString(skuInfo.warning)) {
            
            self.skuStatusLabel.hidden = NO;
            self.skuStatusLabel.text = skuInfo.warning;
            self.skuStatusLabel.textColor = RGB(255, 40, 66);
            [self.skuStatusLabel sizeToFit];
            
            self.rightButtons = @[self.deleteButton,self.similarButton];

        }else if (!IsEmptyString(skuInfo.error)){
            
            self.skuStatusLabel.hidden = NO;
            self.skuStatusLabel.text = skuInfo.error;
            self.skuStatusLabel.textColor = Color_Gray(178);
            [self.skuStatusLabel sizeToFit];
            
            self.findButton.hidden = NO;
            self.invalidLabel.hidden = NO;
            
            self.priceLabel.hidden = YES;
            self.oPriceLabel.hidden = YES;
            self.amountLabel.hidden = YES;
            self.checkButton.hidden = YES;
            
            self.rightButtons = @[self.deleteButton];
        }else{
            self.skuStatusLabel.hidden = YES;
            self.rightButtons = @[self.deleteButton,self.similarButton];
        }
        
        self.itemTitleLabel.text = skuInfo.title;
        self.itemTitleLabel.left = self.skuImageView.right + 10;
        self.itemTitleLabel.width = SCREEN_WIDTH - self.itemTitleLabel.left - 12;
        [self.itemTitleLabel sizeToFit];
        
        self.skuInfoLabel.text = skuInfo.skuDesc;
        [self.skuInfoLabel sizeToFit];
        self.skuInfoLabel.left = self.itemTitleLabel.left;
        self.skuInfoLabel.width = SCREEN_WIDTH - self.skuInfoLabel.left - 12;

        self.skuStatusLabel.left = self.skuInfoLabel.left;
        
        self.priceLabel.text = skuInfo.price;
        [self.priceLabel sizeToFit];
        self.priceLabel.left = self.skuInfoLabel.left;
        
        NSAttributedString *oPriceWithLine =
        [[NSAttributedString alloc]initWithString:skuInfo.oPrice ? skuInfo.oPrice : @""                                       attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSBaselineOffsetAttributeName: @(0)}];
        
        self.oPriceLabel.attributedText = oPriceWithLine;
        [self.oPriceLabel sizeToFit];
        self.oPriceLabel.centerY = self.priceLabel.centerY;
        self.oPriceLabel.left = self.priceLabel.right + 2;
        
        self.findButton.left = self.skuInfoLabel.left;
        self.findButton.bottom = self.skuImageView.bottom;
        
        self.amountLabel.text = [NSString stringWithFormat:@"x%@",skuInfo.amount];
        [self.amountLabel sizeToFit];
        self.amountLabel.bottom = self.priceLabel.bottom;
        self.amountLabel.right = SCREEN_WIDTH - 12;
        
        if (IsEmptyString(skuInfo.error)){
            if (self.xxEditing) {
                self.editBackgroundView.hidden = NO;
                self.editBackgroundView.width = SCREEN_WIDTH - 136;
                self.deleteEditButton.hidden = YES;
            }else{
                if (self.isShopEditing) {
                    self.editBackgroundView.hidden = NO;
                    self.editBackgroundView.width = SCREEN_WIDTH - 55 - 136;
                    self.deleteEditButton.hidden = NO;
                    
                    self.rightButtons = @[];
                }else{
                    self.editBackgroundView.hidden = YES;
                    self.deleteEditButton.hidden = YES;
                }
            }
            self.amountView.text = [NSString stringWithFormat:@"%@",skuInfo.amount];
            [self checkAmountButtons];
            
            self.skuInfoEditLabel.text = skuInfo.skuDesc;
            
            self.pipe1.left = 50;
            self.pipe2.right = self.editBackgroundView.width - 50;
            self.line.width = self.editBackgroundView.width;
            
            self.decreaseButton.left = 0;
            self.increaseButton.right = self.editBackgroundView.width;
            
            self.amountView.left = self.pipe1.right + 2;
            self.amountView.width = self.pipe2.left - 2 - self.amountView.left;
            
            self.dropdownButton.right = self.editBackgroundView.width;
            self.skuInfoEditLabel.width = self.amountView.right;
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData {
    
    if (cellData) {
        return 124;
    }
    return 0;
}


#pragma mark - Getters And Setters

- (UIView *)topLineView {
    
    if ( !_topLineView ) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12 * 2, LINE_WIDTH)];
        _topLineView.backgroundColor = Color_Gray230;
    }
    
    return _topLineView;
}

- (UIView *)bottomLineView {
    
    if ( !_bottomLineView ) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        _bottomLineView.backgroundColor = Color_White;
    }
    
    return _bottomLineView;
}

- (TTCheckButton *)checkButton {
    
    if ( !_checkButton ) {
        _checkButton = [[TTCheckButton alloc] init];
        _checkButton.centerY = 62;
        _checkButton.left = 4;
        [_checkButton addTarget:self action:@selector(handleCheckButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _checkButton;
}

- (UIImageView *)skuImageView {
    
    if ( !_skuImageView ) {
        _skuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 16, 76, 100)];
        _skuImageView.userInteractionEnabled = YES;
        self.invalidLabel.width = _skuImageView.width;
        self.invalidLabel.bottom = _skuImageView.height;
        [_skuImageView addSubview:self.invalidLabel];
        
        weakify(self);
        [_skuImageView bk_whenTapped:^{
            strongify(self);
            if (self.cellData) {
                CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
                [[TTNavigationService sharedService] openUrl:skuInfo.link];
            }

        }];
    }
    
    return _skuImageView;
}

- (UILabel*)invalidLabel
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

- (UILabel *)skuStatusLabel {
    
    if ( !_skuStatusLabel ) {
        _skuStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(136, 66, 55, 20)];
        _skuStatusLabel.textColor = RGB(255, 40, 66);
        _skuStatusLabel.font = FONT(12);
        _skuStatusLabel.numberOfLines = 1;
        _skuStatusLabel.userInteractionEnabled = YES;
        weakify(self);
        [_skuStatusLabel bk_whenTapped:^{
            strongify(self);
            if (self.cellData) {
                CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
                [[TTNavigationService sharedService] openUrl:skuInfo.link];
            }
        }];
    }
    
    return _skuStatusLabel;
}

- (UILabel *)itemTitleLabel {
    
    if ( !_itemTitleLabel ) {
        _itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 0, 0)];
        _itemTitleLabel.textColor = Color_Gray(62);
        _itemTitleLabel.font = FONT(12);
        _itemTitleLabel.numberOfLines = 2;
    }
    
    return _itemTitleLabel;
}

- (UILabel *)skuInfoLabel {
    
    if ( !_skuInfoLabel ) {
        _skuInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(136, 47, 0, 0)];
        _skuInfoLabel.textColor = Color_Gray(178);
        _skuInfoLabel.font = FONT(12);
        _skuInfoLabel.numberOfLines = 1;
    }
    
    return _skuInfoLabel;
}

- (UILabel *)priceLabel {
    
    if ( !_priceLabel ) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(136, 90, 0, 0)];
        _priceLabel.textColor = Color_Gray(62);
        _priceLabel.font = FONT(16);
        _priceLabel.numberOfLines = 1;
    }
    
    return _priceLabel;
}

- (UILabel *)oPriceLabel {
    
    if ( !_oPriceLabel ) {
        _oPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _oPriceLabel.textColor = Color_Gray182;
        _oPriceLabel.font = FONT(12);
        _oPriceLabel.numberOfLines = 1;
    }
    
    return _oPriceLabel;
}

- (UILabel*)amountLabel
{
    if (!_amountLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray(167);
        _amountLabel = label;
    }
    return _amountLabel;
}


- (UIButton *)findButton {
    
    if ( !_findButton ) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(136, 90, 60, 22)];
        [button setTitle:@"找相似" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(12);
        [button setTitleColor:Color_Gray(62) forState:UIControlStateNormal];
        button.layer.borderColor = Color_Gray(62).CGColor;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = 2.;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(handleFindButton) forControlEvents:UIControlEventTouchUpInside];
        _findButton = button;
    }
    
    return _findButton;
}

#pragma mark - Edit subviews
- (UIView*)editBackgroundView
{
    if (!_editBackgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(136, 0, SCREEN_WIDTH-136, 124)];
        view.backgroundColor = self.backgroundColor;
        view.userInteractionEnabled = YES;
        view.hidden = YES;
        
        [view addSubview:self.decreaseButton];
        [view addSubview:self.increaseButton];
        [view addSubview:self.dropdownButton];
        [view addSubview:self.pipe1];
        [view addSubview:self.pipe2];
        [view addSubview:self.line];
        [view addSubview:self.amountView];
        [view addSubview:self.skuInfoEditLabel];
        
        _editBackgroundView = view;
    }
    return _editBackgroundView;
}

- (UIButton*)decreaseButton
{
    if (!_decreaseButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 50, 60)];
        [button setImage:[UIImage imageNamed:@"icon_decrease"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleDecreaseButton) forControlEvents:UIControlEventTouchUpInside];
        _decreaseButton = button;
    }
    return _decreaseButton;
}

- (UIButton*)increaseButton
{
    if (!_increaseButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 50, 60)];
        [button setImage:[UIImage imageNamed:@"icon_increase"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleIncreaseButton) forControlEvents:UIControlEventTouchUpInside];
        _increaseButton = button;
    }
    return _increaseButton;
}

- (UITextField*)amountView
{
    if (!_amountView) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 7, 0, 48)];
        textField.font = FONT(16);
        textField.textColor = Color_Gray(62);
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.delegate = self;
        //[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        _amountView = textField;
    }
    return _amountView;
}

- (UIView*)pipe1
{
    if (!_pipe1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 14, 1, 31)];
        view.backgroundColor = Color_White;
        _pipe1 = view;
    }
    return _pipe1;
}

- (UIView*)pipe2
{
    if (!_pipe2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 14, 1, 31)];
        view.backgroundColor = Color_White;
        _pipe2 = view;
    }
    return _pipe2;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 61.5, SCREEN_WIDTH-136, 1)];
        view.backgroundColor = Color_White;
        _line = view;
    }
    return _line;
}

- (UIButton*)dropdownButton
{
    if (!_dropdownButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 63, 50, 60)];
        [button setImage:[UIImage imageNamed:@"icon_dropdown"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleDropdownButton) forControlEvents:UIControlEventTouchUpInside];
        _dropdownButton = button;
    }
    return _dropdownButton;
}

- (UILabel*)skuInfoEditLabel
{
    if (!_skuInfoEditLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 63, 0, 60)];
        label.font = FONT(12);
        label.textColor = Color_Gray(178);
        _skuInfoEditLabel = label;
    }
    return _skuInfoEditLabel;
}

- (UIButton*)deleteEditButton
{
    if (!_deleteEditButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 124)];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        [button setBackgroundColor:RGB(254,58,50)];
        button.right = SCREEN_WIDTH;
        button.hidden = YES;
        [button addTarget:self action:@selector(handleDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        _deleteEditButton = button;
    }
    return _deleteEditButton;
}

#pragma mark -swipe buttons
- (MGSwipeButton*)similarButton
{
    if (!_similarButton) {
        MGSwipeButton *button = [MGSwipeButton buttonWithTitle:@"找相似" backgroundColor:RGB(254,148,2) padding:0];
        button.titleLabel.font = FONT(14);
        button.buttonWidth = 55;
        _similarButton = button;
        button.callback = [self callbackForButton:button];
    }
    return _similarButton;
}

- (MGSwipeButton*)deleteButton
{
    if (!_deleteButton) {
        MGSwipeButton *button = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:RGB(254,58,50) padding:0];
        button.titleLabel.font = FONT(14);
        button.buttonWidth = 55;
        _deleteButton = button;
        button.callback = [self callbackForButton:button];
    }
    return _deleteButton;
}

#pragma mark -Button actions

- (MGSwipeButtonCallback)callbackForButton:(MGSwipeButton*)sender
{
    if (sender == _similarButton) {
        
        return ^BOOL(MGSwipeTableCell * cell){
            [self handleFindButton];
            return YES;
        };
        
    }else if (sender == _deleteButton) {
        
        return ^BOOL(MGSwipeTableCell * cell){
//            if ([self.actionDelegate respondsToSelector:@selector(deleteWithModel:)]) {
//                [self.actionDelegate deleteWithModel:self.cellData];
//            }
            [self handleDeleteButton];
            return NO;
        };
        
    }
    return ^BOOL(MGSwipeTableCell * cell){
        
        return NO;
    };
    
}

#pragma mark - Event Response

- (void) handleCheckButton {
    
    CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
    
    //if ( [@"0" isEqualToString:skuInfo.status] || [@"3" isEqualToString:skuInfo.status] ) {
    if ( IsEmptyString(skuInfo.error)){
    
        self.checkButton.selected = !self.checkButton.isSelected;
        
        [self notify];
        
    }
}

- (void) handleDeleteButton {
    
    DBG(@"handleDeleteButton");
    
    CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
    
    NSDictionary *userInfo = @{@"type":@"skuDelete", @"id":skuInfo.cartId};
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_SELECT_CHANGE object:nil userInfo:userInfo];
}

- (void)handleFindButton
{
    CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
    [[TTNavigationService sharedService] openUrl:skuInfo.similarLink];
}

- (void)handleIncreaseButton
{
    NSInteger toValue = [self.amountView.text integerValue]+1;
    [self setAmount:toValue];
}

- (void)handleDecreaseButton
{
    NSInteger toValue = [self.amountView.text integerValue]-1;
    [self setAmount:toValue];
}

- (void)handleDropdownButton
{
    if ([self.actionDelegate respondsToSelector:@selector(dropdownButtonTappedWithModel:)]) {
        [self.actionDelegate dropdownButtonTappedWithModel:self.cellData];
    }
}

#pragma mark - Private
- (void)setAmount:(NSInteger)amount
{
    NSUInteger toValue = amount;
//    NSUInteger current = [self.amountView.text integerValue];
//    if (toValue == current) {
//        return;
//    }
    
    self.amountView.text = [NSString stringWithFormat:@"%lu",toValue];
    [self checkAmountButtons];
    
    [self notifyAmountChange];
}

- (void)checkAmountButtons
{
    NSUInteger current = [self.amountView.text integerValue];
    CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;

    self.decreaseButton.enabled = YES;
    self.increaseButton.enabled = YES;
    
    if (current >= skuInfo.quantity) {
        self.increaseButton.enabled = NO;
    }
    
    if (current <= 1) {
        self.decreaseButton.enabled = NO;
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger toValue = [textField.text integerValue];
    [self setAmount:toValue];
}

#pragma mark - Private Methods
- (void)notifyAmountChange
{
    
    CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
//    if ([skuInfo.status isEqualToString:@"3"]) {
//        self.skuStatusLabel.hidden = skuInfo.quantity >= self.amountView.amount;
//    }
    
    skuInfo.amount = [NSString stringWithFormat:@"%@", self.amountView.text];
    
    NSDictionary *userInfo = @{@"type":@"amount", @"id":skuInfo.cartId, @"amount":[NSString stringWithFormat:@"%@",self.amountView.text]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_SELECT_CHANGE object:nil userInfo:userInfo];
}

- (void)notify {
    
    CTSkuInfoModel *skuInfo = (CTSkuInfoModel *)self.cellData;
    
    NSDictionary *userInfo = @{@"type":@"cart", @"selected":self.checkButton.selected?@YES:@NO, @"id":skuInfo.cartId, @"amount":[NSString stringWithFormat:@"%@", self.amountView.text]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_SELECT_CHANGE object:nil userInfo:userInfo];
    
}

@end
