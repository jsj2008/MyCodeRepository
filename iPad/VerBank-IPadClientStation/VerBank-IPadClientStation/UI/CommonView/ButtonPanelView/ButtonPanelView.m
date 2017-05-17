//
//  ButtonPanel.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ButtonPanelView.h"
#import "LangCaptain.h"

@implementation ButtonPanelView

@synthesize modifyButtonPanel;
@synthesize modifyCommitButton;
@synthesize modifyDeleteButton;
@synthesize modifyCancelButton;

@synthesize addButtonPanel;
@synthesize addCommitButton;
@synthesize addCancelButton;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"ButtonPanelView" owner:self options:nil];
    [self addSubview:self.addButtonPanel];
    [self addSubview:self.modifyButtonPanel];
    [self.addButtonPanel setBackgroundColor:[UIColor clearColor]];
    [self.modifyButtonPanel setBackgroundColor:[UIColor clearColor]];
    [self.addButtonPanel    setHidden:true];
    [self.modifyButtonPanel setHidden:true];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setDefault];
}

- (void)setDefault {
    [self.modifyCommitButton    setTitle:[[LangCaptain getInstance] getLangByCode:@"TradeModify"] forState:UIControlStateNormal];
    [self.modifyDeleteButton    setTitle:[[LangCaptain getInstance] getLangByCode:@"Delete"] forState:UIControlStateNormal];
    [self.modifyCancelButton    setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    
    [self.addCommitButton       setTitle:[[LangCaptain getInstance] getLangByCode:@"TradeCommit"] forState:UIControlStateNormal];
    [self.addCancelButton       setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.addButtonPanel setFrame:self.bounds];
    [self.modifyButtonPanel setFrame:self.bounds];
}


@end
