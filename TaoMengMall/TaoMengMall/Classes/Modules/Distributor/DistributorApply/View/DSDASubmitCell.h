//
//  DSDASubmitCell.h
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol DSDASubmitCellDelegate <NSObject>

- (void)submitButtonTapped;

@end


@interface DSDASubmitCell : BaseTableViewCell
@property (nonatomic, strong,readonly) UIButton *submitButton;
@property (nonatomic, weak)id<DSDASubmitCellDelegate> delegate;

//- (void)setSubmitButtonEnable:(BOOL)enable;

@end
