//
//  UpDownView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "DropDownView.h"

#import "ScreenAuotoSizeScale.h"

#define CellHeigh 20

@interface DropDownView()<UITableViewDataSource, UITableViewDelegate>{
    
    UIButton *_senderButton;
    
    Boolean _direction;
    
    UITableView *_dropDownTable;
    NSArray *_contentArray;
    
    CGRect _dropDownRect;
    
    CGFloat _tableViewHeigh;
    
    id<DropDownViewDelegate> _delegate;
    
    int _selectIndex;
}

@end


@implementation DropDownView

@synthesize delegate = _delegate;

@synthesize isShowState;

- (id)initWithRect:(UIButton *)button array:(NSArray *)array direction:(Boolean)direction {
    if (self = [super init]) {
        
        _direction = direction;
        _dropDownRect = button.frame;
        _senderButton = button;
        _contentArray = array;
        _tableViewHeigh = [array count] * CellHeigh;
        
        _dropDownTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _dropDownRect.size.width, 0)];
        if (direction) {
            self.frame = CGRectMake(_dropDownRect.origin.x, _dropDownRect.origin.y, 0, 0);
        } else {
            self.frame = CGRectMake(_dropDownRect.origin.x, _dropDownRect.origin.y + _dropDownRect.size.height, 0, 0);
        }
        
        _dropDownTable.delegate = self;
        _dropDownTable.dataSource = self;
        _dropDownTable.layer.cornerRadius = 5;
        _dropDownTable.bounces = NO;
//        _dropDownTable.backgroundColor = [UIColor redColor];
        _dropDownTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _dropDownTable.separatorColor = [UIColor grayColor];
        [self setSelectIndex:0];
        [self addSubview:_dropDownTable];
    }
    return self;
}

- (void)setSelectIndex:(int)selectIndex {
    _selectIndex = selectIndex;
    [_senderButton setTitle:[_contentArray objectAtIndex:selectIndex] forState:UIControlStateNormal];
}

- (int)getSelectIndex {
    return _selectIndex;
}

- (void)hideDropDown {
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        if (_direction) {
                            self.frame = CGRectMake(_dropDownRect.origin.x, _dropDownRect.origin.y, _dropDownRect.size.width, 0);
                        } else {
                            self.frame = CGRectMake(_dropDownRect.origin.x, _dropDownRect.origin.y + _dropDownRect.size.height, _dropDownRect.size.width, 0);
                        }
                        _dropDownTable.frame = CGRectMake(0, 0, _dropDownRect.size.width, 0);
                    }
                    completion:^(BOOL finished){
                        //                        [self removeFromSuperview];
                        isShowState = false;
                    }];
}

- (void)showDropDown {
    if (_direction) {
        self.frame = CGRectMake(_dropDownRect.origin.x, _dropDownRect.origin.y, _dropDownRect.size.width, 0);
    } else {
        self.frame = CGRectMake(_dropDownRect.origin.x, _dropDownRect.origin.y + _dropDownRect.size.height, _dropDownRect.size.width, 0);
    }
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        if (_direction) {
                            self.frame = CGRectMake(_dropDownRect.origin.x, _dropDownRect.origin.y - _tableViewHeigh, _dropDownRect.size.width, _tableViewHeigh);
                        } else {
                            self.frame = CGRectMake(_dropDownRect.origin.x, _dropDownRect.origin.y + _dropDownRect.size.height, _dropDownRect.size.width, _tableViewHeigh);
                        }
                        _dropDownTable.frame = CGRectMake(0, 0, _dropDownRect.size.width, _tableViewHeigh);
                    }
                    completion:^(BOOL finished) {
                        isShowState = true;
                    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeigh;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_contentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    
    
    NSString *title = [_contentArray objectAtIndex:[indexPath row]];
    [cell.textLabel setText:title];
    [cell setBackgroundColor:[UIColor darkGrayColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_delegate && [_delegate respondsToSelector:@selector(otherAction:atView:)]) {
        [_delegate otherAction:(int)[indexPath row] atView:self];
    }
    
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.5];
    
    [self hideDropDown];
}

-(void)unselectCell:(id)sender{
    [_dropDownTable deselectRowAtIndexPath:[_dropDownTable indexPathForSelectedRow] animated:YES];
}


@end
