//
//  SearchTermLabel.h
//  YouCai
//
//  Created by marco on 5/28/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTermLabel : UIView


@property (nonatomic, strong) NSString *text;

- (void)resizeToFit;
@end
