//
//  HedgingTableViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "HedgingTableViewCell.h"
#import "ZLKeyboardView.h"

@interface HedgingTableViewCell() {}

@end

@implementation HedgingTableViewCell

@synthesize ticketLabel;
@synthesize amountLabel;
@synthesize openPriceLabel;
@synthesize openAmountTextField;

@synthesize inputView;

@synthesize isAddListener;

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor blackColor]];
    self.isAddListener = false;
    [self.contentView setBackgroundColor:[UIColor blackColor]];
    
    [self.openAmountTextField setBorderStyle:UITextBorderStyleRoundedRect];
    CGFloat radio = self.openAmountTextField.frame.size.height / 2 - 4.0f;
    self.openAmountTextField.layer.cornerRadius = radio;
    self.openAmountTextField.layer.borderWidth = 1.0f;
    self.openAmountTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.openAmountTextField setBackgroundColor:[UIColor clearColor]];
    [self.openAmountTextField setTextColor:[UIColor whiteColor]];
    
    inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLeftTradeNumber];
    self.openAmountTextField.inputView = inputView;
    [TextFieldUtil removeShortCutItem:self.openAmountTextField];
    [self.openAmountTextField  setDelegate:(id)inputView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//#pragma keyboard delegate
//- (void)textFieldEndEdit:(UITextField *)textField {
//    
//    NSString *text = textField.text;
//    
//}

@end
