//
//  RssResourceAddOrModifyView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/16.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssResourcePopView.h"

@interface RssResourceAddOrModifyView : UIView {
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_rssLabel;
    IBOutlet UITextField *_inputTextField;
    IBOutlet UIButton *_yesButton;
    IBOutlet UIButton *_noButton;
    int _index;
    NSString *_titleString;
}

@property int index;
@property NSString *titleString;

+ (RssResourceAddOrModifyView *)newInstance;

- (void)returnKeyboard;
- (void)setTarget:(RssResourcePopView *)rssResourcePopView;

@end
