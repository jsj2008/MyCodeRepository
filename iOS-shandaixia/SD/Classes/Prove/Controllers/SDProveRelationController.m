//
//  SDProveRelationController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDProveRelationController.h"
#import "SDProveRelationView.h"
#import "SDProveHeaderView.h"
#import "SDImageRightButton.h"
#import "SDInputView.h"
#import "SDProveOperatorsController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TKAddressBook.h"
#import "SDAccount.h"

#define blueH  (314 * SCALE)

@interface SDProveRelationController ()<ABPeoplePickerNavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak) SDProveRelationView *relationView1;

@property (nonatomic, weak) SDProveRelationView *relationView2;

@property (nonatomic, weak) UIPickerView *pickerView;

@property (nonatomic, weak) UIView *relationView;

@property (nonatomic, strong) NSArray *relationArray;

@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UIView *backView;

@property (nonatomic, strong) NSMutableArray *addressBookTemp;

@property (nonatomic, copy) NSString *relation1String;

@property (nonatomic, copy) NSString *relation2String;

@end

@implementation SDProveRelationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.relationArray = @[@"亲戚",@"朋友",@"配偶",@"父母",@"同学",@"同事"];
    
    [self addContent];
    
    [self addHeaderWithImage:@"progress-bar2"];
    
    [self addPickerView];
    
//    [SDNotificationCenter addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [SDNotificationCenter addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];

    [SDNotificationCenter addObserver:self selector:@selector(endEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    
}


- (void)getContactsInfo:(UIButton *)button{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
    });
    
    _relationView1.nameInputView.rightButton.selected = _relationView2.nameInputView.rightButton.selected = NO;
    button.selected = YES;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            
            if (self.addressBookTemp.count == 0) {
             
                [self getAllContacts];
                
            }
            
            ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
            peoplePicker.peoplePickerDelegate = self;
            [self presentViewController:peoplePicker animated:YES completion:nil];
            
            
            
        }else{
            
            FDLog(@"用户未授权");
            
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [@"用户未授权, 请在设置->隐私->通讯录中打开授权" showNotice];
            });
            
        }
        
    });
}

// Called after the user has pressed cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    
    FDLog(@"index - %@",@(index));
    
    if ([@(index) isEqual:@(-1)]) index = 0;
    
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    
    NSString *firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    if (!firstName) {
        
        firstName = @"";
    }
    
    if (!lastName) {
        
        lastName = @"";
    }
    
    NSString *name = [NSString stringWithFormat:@"%@%@",firstName,lastName];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSString *phone = (__bridge NSString*)value;
        if (_relationView1.nameInputView.rightButton.selected) {
            
            if ([_relationView2.phoneInputView.inputTextField.text isEqualToString:phone]) {
                [FDReminderView showWithString:@"不能添加相同联系人"];
            }else{
                _relationView1.nameInputView.inputTextField.text = name;
                _relationView1.phoneInputView.inputTextField.text = phone;
                _relationView1.nameInputView.inputTextField.enabled = YES;
            }
        }else{
            if ([_relationView1.phoneInputView.inputTextField.text isEqualToString:phone]) {
                [FDReminderView showWithString:@"不能添加相同联系人"];
            }else{
                _relationView2.nameInputView.inputTextField.text = name;
                _relationView2.phoneInputView.inputTextField.text = phone;
                _relationView2.nameInputView.inputTextField.enabled = YES;
            }
        }
    }];
}


- (void)endEditing:(UITextField *)textField{
 
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.y = blueH;
    }];
}

- (void)dealloc{

    [SDNotificationCenter removeObserver:self];
}

- (void)keyboardChanged:(NSNotification *)note{

//    FDLog(@"userInfo - %@",note.userInfo);
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    CGFloat height = 100 * SCALE;
    
    FDLog(@"rectY - %@,rectH - %@",@(rect.origin.y),@(rect.origin.y + rect.size.height));
    
    if (self.relationView2.nameInputView.inputTextField.editing) {
        
        CGFloat diff = blueH + 540 * SCALE - rect.origin.y;
        
        if (diff > 0) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.backView.y = blueH - diff;
            }];
        }
        
    }
    
    else if (self.relationView2.phoneInputView.inputTextField.editing) {
        
        CGFloat diff = blueH + 640 * SCALE - rect.origin.y;
        
        if (diff > 0) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.backView.y = blueH - diff;
            }];
        }
        
        
    }
    else{
    
        self.backView.y = blueH;
    }
    
}

- (void)addContent{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, blueH, SCREENWIDTH, SCREENHEIGHT - blueH)];
    
    self.backView = backView;
    backView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:backView];
    
    CGFloat relationY =  20 * SCALE;
    CGFloat relationH = 300 * SCALE;

    //第一个紧急联系人
    SDProveRelationView *relationView1 = [[SDProveRelationView alloc] initWithFrame:CGRectMake(0, relationY, SCREENWIDTH, relationH)];
    self.relationView1 = relationView1;
    [backView addSubview:relationView1];
    relationView1.nameInputView.inputTextField.enabled = NO;
    relationView1.phoneInputView.inputTextField.enabled = NO;
    [relationView1.nameInputView.rightButton addTarget:self action:@selector(getContactsInfo:) forControlEvents:UIControlEventTouchUpInside];
    
//    [relationView1.getContactButton addTarget:self action:@selector(getContactsInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    relationView1.rightButton.tag = 1;
    relationView1.nameInputView.rightButton.tag = 2;
    
    [relationView1.rightButton addTarget:self action:@selector(rightButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //第二个紧急联系人
    SDProveRelationView *relationView2 = [[SDProveRelationView alloc] initWithFrame:CGRectMake(0, relationY + relationH + 20 * SCALE, SCREENWIDTH, relationH)];
    self.relationView2 = relationView2;
    [backView addSubview:relationView2];
    relationView2.nameInputView.inputTextField.enabled = NO;
    relationView2.phoneInputView.inputTextField.enabled = NO;
    relationView2.rightButton.tag = 2;
    relationView2.nameInputView.rightButton.tag = 2;
    [relationView2.nameInputView.rightButton addTarget:self action:@selector(getContactsInfo:) forControlEvents:UIControlEventTouchUpInside];
//    [relationView2.getContactButton addTarget:self action:@selector(getContactsInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    [relationView2.rightButton addTarget:self action:@selector(rightButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //保障文本
    UILabel *safeLabel = [UILabel labelWithText:@"请提供真实有效的联系信息, 否则将导致借款失败" textColor:FDColor(153,153,153) font:24 * SCALE textAliment:0];
    safeLabel.frame = CGRectMake(30 * SCALE, CGRectGetMaxY(relationView2.frame) + 32 * SCALE, SCREENWIDTH, 24 * SCALE);
    [backView addSubview:safeLabel];
    
    //下一步
    CGFloat buttonY = CGRectGetMaxY(relationView2.frame) + 96 * SCALE;
    CGFloat buttonX = 30 * SCALE;
    CGFloat buttonW = SCREENWIDTH - 2 * buttonX;
    CGFloat buttonH = 100 * SCALE   ;
    
    UIButton *nextButton = [UIButton roundButtonWithTitle:@"下一步" titleColor:[UIColor whiteColor] titleFont:36 * SCALE backgroundColor:FDColor(70, 151, 251) frame:CGRectMake(buttonX,buttonY,buttonW,buttonH)];
    [backView addSubview:nextButton];
    
    [nextButton addTarget:self action:@selector(nextButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)nextButtonDidClicked{
    
    if ([self.relationView1.rightButton.titles.text isEqualToString:@"请选择"]) {
        
        [@"请选择第一个联系人的关系" showNotice];
        
        return;
    }else if (!self.relationView1.phoneInputView.inputTextField.text.length){
    
        [@"请点击姓名右侧蓝色按钮选择联系人信息" showNotice];
        return;
    }else if ([self.relationView2.rightButton.titles.text isEqualToString:@"请选择"]) {
        
        [@"请选择第二个联系人的关系" showNotice];
        return;
    }else if (!self.relationView2.phoneInputView.inputTextField.text.length){
        
        [@"请点击姓名右侧蓝色按钮选择联系人信息" showNotice];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交联系人信息"];
    
    FDLog(@"self.relationView1.rightButton.titleLabel.text - %@",self.relationView1.rightButton.titles.text);
    
    NSArray *society = @[
                         @{@"userName":self.relationView1.nameInputView.inputTextField.text,
                           @"phone":self.relationView1.phoneInputView.inputTextField.text,
                           @"appellation":self.relationView1.rightButton.titles.text
                           },
                         @{@"userName":self.relationView2.nameInputView.inputTextField.text,
                           @"phone":self.relationView2.phoneInputView.inputTextField.text,
                           @"appellation":self.relationView2.rightButton.titles.text
                           }
                         ];
    
    self.view.userInteractionEnabled = NO;
    
    [SDAccount updateContacts:self.addressBookTemp society:society finishedBlock:^(id object) {
        
        
        
        [SVProgressHUD dismiss];
        
        [FDReminderView showWithString:@"提交联系人信息成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.view.userInteractionEnabled = YES;
            
            [self.navigationController pushViewController:[[SDProveOperatorsController alloc] init] animated:YES];
        });
        
    } failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        [FDReminderView showWithString:@"提交联系人信息失败"];
        
        self.view.userInteractionEnabled = YES;
    }];
    
    
}

- (void)rightButtonDidClicked:(SDImageRightButton *)button{
    
    
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        button.enabled = YES;
    });
    
    self.relation1String = self.relationView1.rightButton.titles.text;
    
    self.relation2String = self.relationView2.rightButton.titles.text;
    
    button.selected = YES;
    
    [_pickerView selectRow:0 inComponent:0 animated:NO];
    
    if (self.relationView1.rightButton.selected) {
        
        self.relationView1.rightButton.titles.text = self.relationArray[0];
    }else{
        
        self.relationView2.rightButton.titles.text = self.relationArray[0];
    }
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.relationView.y = SCREENHEIGHT - 420 * SCALE;
    } completion:^(BOOL finished) {
        
        UIButton *shadowButton = [[UIButton alloc] initWithFrame:self.view.bounds];
        self.shadowButton = shadowButton;
        shadowButton.backgroundColor = [UIColor blackColor];
        shadowButton.alpha = 0.5;
        shadowButton.tag = 0;
        [self.view addSubview:shadowButton];
        
        [shadowButton addTarget:self action:@selector(shadowButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    
}

- (void)shadowButtonDidClicked:(UIButton *)button{

    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.relationView.y = SCREENHEIGHT;
        
    } completion:^(BOOL finished) {
        
        [self.shadowButton removeFromSuperview];
        
        switch (button.tag) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
            
                self.relationView1.rightButton.titles.text = self.relation1String;
                
                self.relationView2.rightButton.titles.text = self.relation2String;
            }
                break;
            case 2:
            {
            
                
            }
                break;
                
            default:
                break;
        }
        
        self.relationView1.rightButton.selected = self.relationView2.rightButton.selected = NO;
        
    }];
    
    

}


- (void)addPickerView{

    CGFloat height = 420 * SCALE;
    
    UIView *relationView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, height)];
    relationView.backgroundColor = [UIColor whiteColor];
    self.relationView = relationView;
    
    //取消按钮
    CGFloat cancelX = 30 * SCALE;
    CGFloat cancelW = [@"取消" sizeOfMaxScreenSizeInFont:cancelX].width;
    CGFloat cancelY = 20 * SCALE;
    UIButton *cancelButton = [UIButton buttonWithTitle:@"取消" titleColor:FDColor(70, 151, 251) titleFont:cancelX];
    cancelButton.frame = CGRectMake(cancelX, cancelY, cancelW, cancelX);
    [relationView addSubview:cancelButton];
    cancelButton.tag = 1;
    [cancelButton addTarget:self action:@selector(shadowButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //确定按钮
    UIButton *sureButton = [UIButton buttonWithTitle:@"确定" titleColor:FDColor(70, 151, 251) titleFont:cancelX];
    sureButton.frame = CGRectMake(SCREENWIDTH - cancelW - cancelX, cancelY, cancelW, cancelX);
    [relationView addSubview:sureButton];
    sureButton.tag = 2;
    [sureButton addTarget:self action:@selector(shadowButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //1.创建pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 70 * SCALE, SCREENWIDTH, 350 * SCALE)];
    pickerView.backgroundColor = FDColor(242, 242, 242);
    
    self.pickerView = pickerView;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    [relationView addSubview:pickerView];
    [[UIApplication sharedApplication].keyWindow addSubview:relationView];
    
}

#pragma mark - 数据源方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.relationArray.count;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    
//    FDLog(@"self.relationArray[row] - %@",self.relationArray[row]);
//    
//    return self.relationArray[row];
//}

#pragma mark - 代理方法

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    FDLog(@"-------- %@",self.relationArray[row]);
    
    if (self.relationView1.rightButton.selected) {
        
        self.relationView1.rightButton.titles.text = self.relationArray[row];
    }else{
    
        self.relationView2.rightButton.titles.text = self.relationArray[row];
    }

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{

    return 80 * SCALE;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{

    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.relationArray[row]];
    //设置字号
    
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20 * SCALE] range:NSMakeRange(0, 2)];
    //设置文字颜色
    
    return attributedText;

}

- (void)getAllContacts{

    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        
        
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        TKAddressBook *addressBook = [[TKAddressBook alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
                
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = (__bridge NSString*)value;
                        
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        
        if (addressBook.name == nil || [addressBook.name isEqualToString:@""]) {
            
            addressBook.name = @"未知联系人";
        }
        
        if (addressBook.tel == nil || [addressBook.tel isEqualToString:@""]) {
            
            addressBook.tel = @"未知号码";
        }

        NSDictionary *dict = @{@"userName":addressBook.name,
                               @"phone":addressBook.tel
                               };
        
        [_addressBookTemp addObject:dict];
        
        FDLog(@"dict - %@",dict);
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    
}

- (NSMutableArray *)addressBookTemp{

    if (_addressBookTemp == nil){
        
        _addressBookTemp = [NSMutableArray array];
    }
    
    return _addressBookTemp;
}

- (void)leftBtnDidTouch{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.relationView.y = SCREENHEIGHT;
    
}

@end






