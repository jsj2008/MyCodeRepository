//
//  MarginCallHisCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarginCallHisCellView : UIView{
    IBOutlet UILabel *_account;
    IBOutlet UILabel *_time;
    IBOutlet UILabel *_type;
    IBOutlet UILabel *_amount;
}

@property UILabel *account;
@property UILabel *time;
@property UILabel *type;
@property UILabel *amount;

+ (MarginCallHisCellView *)newInstance;

@end
