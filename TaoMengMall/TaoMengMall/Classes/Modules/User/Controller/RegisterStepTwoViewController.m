//
//  RegisterStepTwoViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/4.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "RegisterStepTwoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UserRequest.h"
#import "UserService.h"
#import "MBProgressHUD.h"
#import "XMAppThemeHelper.h"
#import "AMUserLocationManager.h"
#import "XMAppThemeHelper.h"

#import "CityListModel.h"
#import "ProvinceModel.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "ConsigneeRequest.h"

#define PROVINCE_COLUMN 0
#define CITY_COLUMN     1
#define DISTRICT_COLUMN 2

@interface RegisterStepTwoViewController () <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *avatarLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *lineView1;

@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UILabel *genderValueLabel;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIImageView *moreImageView;

@property (nonatomic, strong) UIButton *completeButton;

//@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) MBProgressHUD *loadingProgressHUD;

@property (nonatomic,strong) UILabel *provinceLabel;
@property (nonatomic,strong) UIView *lineView3;
@property (nonatomic,strong) UIView *lineView31;
@property (nonatomic, strong) UIButton *locateMeButton;

@property (nonatomic, strong) UILabel *pcdValueLabel;
@property (nonatomic, strong) UIPickerView *pcdPickerView;
@property (nonatomic, strong) NSArray *cityArra;;
@property (nonatomic, assign) NSInteger selectedIndex_province;
@property (nonatomic, assign) NSInteger selectedIndex_city;
@property (nonatomic, assign) NSInteger selectedIndex_area;

@property (nonatomic, assign) BOOL showPickerView;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *address;
//@property (nonatomic, copy) NSString *cityCode;
//@property (nonatomic, copy) NSString *proviceCode;
@property (nonatomic, copy) NSString *districtCode;
@property (nonatomic, strong) AMUserLocationManager *locationManager;
@end

@implementation RegisterStepTwoViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_White;
    
    [self addNavigationBar];
    
    self.title = @"完善用户信息";
    
    [self render];
    
    [self loadPCDData];
    
    self.province = @"";
    self.city = @"";
    self.district = @"";
    self.address = @"";

}
- (void)loadPCDData
{
    weakify(self);
    [ConsigneeRequest getRegionWithParams:nil success:^(CityListModel *resultModel) {
        strongify(self);
        
        self.cityArra = resultModel.citylist;
        [self.pcdPickerView reloadAllComponents];
        
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

- (void)pcdSelectUpdate
{
    ProvinceModel *pmodel = [self.cityArra safeObjectAtIndex:self.selectedIndex_province];
    CityModel *cmodel = [pmodel.c safeObjectAtIndex:self.selectedIndex_city];
    AreaModel *amodel = [cmodel.a safeObjectAtIndex:self.selectedIndex_area];
    NSString *area = amodel?amodel.name:@"";
    
    self.pcdValueLabel.textColor = Color_Gray(45);
    
    self.pcdValueLabel.text = [NSString stringWithFormat:@"%@ %@ %@",pmodel.p.name,cmodel.n.name,area];
    self.province = pmodel.p.name;
    self.city = cmodel.n.name;
    self.district = area;
    //self.cityCode = cmodel.n.code;
    //self.proviceCode = amodel.code;
    if (amodel) {
        self.districtCode = amodel.code;
    }else{
        self.districtCode = cmodel.n.code;
    }
    [self checkCompleteButton];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self dismissKeyBoard];
}

#pragma mark - Private Methods

- (void) render
{
    [self.view addSubview:self.avatarImageView];
    [self.view addSubview:self.avatarLabel];
    
    [self.view addSubview:self.lineView1];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.nameTextField];
    
    [self.view addSubview:self.genderLabel];
    [self.view addSubview:self.genderValueLabel];
    [self.view addSubview:self.lineView2];
    [self.view addSubview:self.moreImageView];
    
    [self.view addSubview:self.lineView3];
    [self.view addSubview:self.provinceLabel];
    [self.view addSubview:self.locateMeButton];
    [self.view addSubview:self.lineView31];
    [self.view addSubview:self.pcdValueLabel];
    [self.view addSubview:self.pcdPickerView];

    [self.view addSubview:self.completeButton];
    
    if (self.avatar) {
        [self.avatarImageView setOnlineImage:self.avatar];
    }
    if (self.gender) {
        self.genderValueLabel.text = [self.gender isEqualToString:@"1"]?@"男":@"女";
        self.genderValueLabel.textColor = Color_Gray(45);
    }
    if (self.name) {
        self.nameTextField.text = self.name;
    }
    [self checkCompleteButton];
}

- (void)avatarFromSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = sourceType;
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)setCompleteButtonEnabled: (BOOL)enabled {
    
    if ( enabled ) {
        self.completeButton.enabled = YES;
        self.completeButton.backgroundColor = [XMAppThemeHelper defaultTheme].mainThemeColor;
        self.completeButton.layer.borderColor = [XMAppThemeHelper defaultTheme].mainThemeColor.CGColor;
    } else {
        self.completeButton.enabled = NO;
        self.completeButton.backgroundColor = Color_Gray230;
        self.completeButton.layer.borderColor = Color_Gray230.CGColor;
    }
}

#pragma mark - Getters And Setters

- (UIImageView *)avatarImageView
{
    if ( !_avatarImageView ) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 96, 96, 96)];
        _avatarImageView.image = [UIImage imageNamed:@"register_add_avatar"];
        _avatarImageView.centerX = SCREEN_WIDTH / 2;
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 48;
        weakify(self);
        [_avatarImageView bk_whenTapped:^{
            strongify(self);
            [self handleAvatarImageViewTapped];
        }];
    }
    
    return _avatarImageView;
}

- (UILabel*)avatarLabel
{
    if (!_avatarLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"点击上传头像";
        label.textColor = Color_Gray(159);
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/2;
        label.top = self.avatarImageView.bottom + 2;
        _avatarLabel = label;
    }
    return _avatarLabel;
}

- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 0, 32)];
        label.font = FONT(16);
        label.text = @"昵称";
        label.textColor = Color_Gray(45);
        [label sizeToFit];
        label.height = 32;
        label.bottom = self.lineView1.top;
        _nameLabel = label;
    }
    return _nameLabel;
}


- (UITextField *)nameTextField {
    
    if ( !_nameTextField ) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 50 - 110, 32)];
        _nameTextField.borderStyle = UITextBorderStyleNone;
        _nameTextField.placeholder = @"请输入";
        _nameTextField.font = FONT(16);
        _nameTextField.delegate = self;
        _nameTextField.textColor = Color_Gray42;
        _nameTextField.bottom = self.lineView1.top;
    }
    
    return _nameTextField;
    
}

- (UIView*)lineView1
{
    if (!_lineView1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(32, 0, SCREEN_WIDTH-64, LINE_WIDTH)];
        view.backgroundColor = Color_Gray(229);
        view.top = self.avatarLabel.bottom + 70;
        _lineView1 = view;
    }
    return _lineView1;
}

- (UILabel*)genderLabel
{
    if (!_genderLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 0, 32)];
        label.font = FONT(16);
        label.text = @"性别";
        label.textColor = Color_Gray(45);
        [label sizeToFit];
        label.height = 32;
        label.bottom = self.lineView2.top;
        _genderLabel = label;
    }
    return _genderLabel;
}

- (UILabel*)genderValueLabel
{
    if (!_genderValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 100 - 50, 40)];
        label.font = FONT(16);
        label.text = @"请选择";
        label.textColor = Color_Gray(194);
        label.centerY = self.genderLabel.centerY;
        label.userInteractionEnabled = YES;
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
            actionSheet.tag = 1;
            [actionSheet showInView:self.view];
        }];
        _genderValueLabel = label;
    }
    return _genderValueLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.right = self.lineView2.right;
        _moreImageView.centerY = self.genderLabel.centerY;
    }
    
    return _moreImageView;
}

- (UIView*)lineView2
{
    if (!_lineView2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(32, 0, SCREEN_WIDTH-64, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.top = self.lineView1.bottom + 54;
        _lineView2 = view;
    }
    return _lineView2;
}

- (UIView *)lineView3
{
    if (!_lineView3) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(32, 0, SCREEN_WIDTH-64, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.top = self.lineView2.bottom + 54;
        _lineView3 = view;
    }
    return _lineView3;
}

- (UILabel *)provinceLabel {
    
    if ( !_provinceLabel ) {
        _provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,0, 0, 32)];
        _provinceLabel.textColor = Color_Gray(45);
        _provinceLabel.font = FONT(16);
        _provinceLabel.text = @"居住地";
        [_provinceLabel sizeToFit];
        _provinceLabel.height = 32;
        _provinceLabel.bottom = self.lineView3.top;
        _provinceLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _provinceLabel;
}

- (UIView *)lineView31 {
    
    if ( !_lineView31 ) {
        
        _lineView31 = [[UIView alloc] initWithFrame:CGRectMake( SCREEN_WIDTH-60, self.lineView2.bottom+10, LINE_WIDTH, 34)];
        _lineView31.right = self.locateMeButton.left;
        _lineView31.backgroundColor = Color_Gray230;
    }
    
    return _lineView31;
}

- (UIButton *)locateMeButton
{
    if (!_locateMeButton) {
        _locateMeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 58, 44)];
        [_locateMeButton setTitle:@"定位" forState:UIControlStateNormal];
        [_locateMeButton setTitleColor:Color_Gray(157) forState:UIControlStateNormal];
        _locateMeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_locateMeButton.titleLabel sizeToFit];
        _locateMeButton.titleLabel.font = FONT(12);
        _locateMeButton.centerY = self.lineView3.bottom-27;
        _locateMeButton.right = SCREEN_WIDTH-32;
        [_locateMeButton setImage:[UIImage imageNamed:@"consignee_location"] forState:UIControlStateNormal];
        
        [_locateMeButton setContentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft];
        [_locateMeButton setContentVerticalAlignment: UIControlContentVerticalAlignmentTop];
        
        [_locateMeButton setImageEdgeInsets: UIEdgeInsetsMake(6, (_locateMeButton.bounds.size.width-_locateMeButton.imageView.bounds.size.width)*0.5, 0, 0)];
        [_locateMeButton setTitleEdgeInsets: UIEdgeInsetsMake(_locateMeButton.imageView.bounds.size.height+5, (_locateMeButton.bounds.size.width-_locateMeButton.titleLabel.bounds.size.width)*0.5-_locateMeButton.imageView.bounds.size.width, 0, 0)];
        
        [_locateMeButton addTarget:self action:@selector(handleLocationButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _locateMeButton;
}

- (UILabel*)pcdValueLabel
{
    if (!_pcdValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-32-58, 40)];
        label.font = FONT(16);
        NSString *p = self.province?self.province:@"";
        NSString *c = self.city?self.city:@"";
        NSString *a = self.district?self.district:@"";
        label.text = [NSString stringWithFormat:@"%@ %@ %@",p,c,a];
        label.text = @"选择";
        label.textColor = Color_Gray(194);
        label.centerY = self.provinceLabel.centerY;
        label.userInteractionEnabled = YES;

        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            [self showPCDPicker:!self.showPickerView];
        }];
        _pcdValueLabel = label;
    }
    return _pcdValueLabel;
}

- (UIPickerView*)pcdPickerView
{
    if (!_pcdPickerView) {
        _pcdPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 180)];
        _pcdPickerView.tag = 0;
        _pcdPickerView.backgroundColor = Color_Gray245;
        _pcdPickerView.delegate = self;
        _pcdPickerView.dataSource = self;
    }
    return _pcdPickerView;
}


- (UIButton *)completeButton {
    
    if ( !_completeButton ) {
        _completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeButton.frame = CGRectMake(30, 340 + NAVBAR_HEIGHT, SCREEN_WIDTH - 60, 44);
        [_completeButton setTitle:@"确认" forState:UIControlStateNormal];
        [_completeButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_completeButton setTitleColor:Color_Gray148 forState:UIControlStateDisabled];
        _completeButton.titleLabel.font = FONT(16);
        _completeButton.layer.masksToBounds = YES;
        _completeButton.layer.cornerRadius = 4;
//        _completeButton.layer.borderWidth = 1;
//        _completeButton.layer.borderColor = Color_Gray230.CGColor;
        _completeButton.backgroundColor = Color_Gray(229);
        _completeButton.enabled = NO;
        _completeButton.top = self.lineView3.bottom + 38;
        [_completeButton addTarget:self action:@selector(handleCompleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _completeButton;
}

- (AMUserLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [AMUserLocationManager sharedInstance];
    }
    return _locationManager;
}

#pragma mark - Event Response

- (void) dismissKeyBoard {
    [self.nameTextField resignFirstResponder];
}

- (void) handleAvatarImageViewTapped
{
    [self dismissKeyBoard];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择头像来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选取", nil];
    [actionSheet showInView:self.view];
    
}

- (void) handleCompleteButton
{
    [self.nameTextField resignFirstResponder];
    
    if ( IsEmptyString(self.nameTextField.text) ) {
        [self showNotice:@"请输入昵称"];
        return;
    }
    NSString *gender = @"1";
    if ([self.genderValueLabel.text isEqualToString:@"男"]) {
        gender = @"1";
    }else if ([self.genderValueLabel.text isEqualToString:@"女"]) {
        gender = @"2";
    }else if ( IsEmptyString(self.province)) {
        [self showNotice:@"请选择地址"];
    }else{
        [self showNotice:@"请选择性别"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setSafeObject:[self.nameTextField.text trim] forKey:@"name"];
    [params setSafeObject:self.districtCode forKey:@"district"];
    [params setSafeObject:self.avatar forKey:@"avatar"];
    [params setSafeObject:self.phone forKey:@"phone"];
    [params setSafeObject:self.code forKey:@"code"];
    [params setSafeObject:gender forKey:@"gender"];

    weakify(self);
    if (IsEmptyString(self.thirdpartType)) {
        
        [UserRequest registerWithParams:params success:^(LRUserInfoResultModel *resultModel) {
            
            BDUserInfoModel *model = resultModel.user;
            [UserService sharedService].userId = model.userId;
            [UserService sharedService].name = model.name;
            [UserService sharedService].avatar = model.avatar;
            [UserService sharedService].phone = model.phone;
            [UserService sharedService].sign = model.sign;
            [UserService sharedService].gender = model.gender;
            [UserService sharedService].isLogin = YES;
            [[UserService sharedService] saveLoginInfo];
            
            [self showNotice:@"注册成功"];
            
            NSMutableDictionary *p = [NSMutableDictionary dictionary];
            [p setSafeObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forKey:@"deviceToken"];
            [UserRequest uploadPushTokenWithParams:p success:^{
                NSLog(@"success upload");
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lastUploadToken"];
            } failure:^(StatusModel *status) {
                NSLog(@"failed upload");
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"lastUploadToken"];
            }];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } failure:^(StatusModel *status) {
            
            strongify(self);
            DBG(@"%@", status);
            [self showNotice:status.msg];
        }];
    }else{
        
        [params setSafeObject:self.thirdpartType forKey:@"type"];
        [params setSafeObject:self.openId forKey:@"openId"];
        
        [UserRequest thirdBindingWithParams:params success:^(LRUserInfoResultModel *resultModel) {
            
            strongify(self);
            BDUserInfoModel *model = resultModel.user;
            [UserService sharedService].userId = model.userId;
            [UserService sharedService].name = model.name;
            [UserService sharedService].avatar = model.avatar;
            [UserService sharedService].phone = model.phone;
            [UserService sharedService].sign = model.sign;
            [UserService sharedService].gender = model.gender;
            [UserService sharedService].isLogin = YES;
            [[UserService sharedService] saveLoginInfo];
            
            [self showNotice:@"登录成功"];
            
            NSMutableDictionary *p = [NSMutableDictionary dictionary];
            [p setSafeObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forKey:@"deviceToken"];
            [UserRequest uploadPushTokenWithParams:p success:^{
                NSLog(@"success upload");
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lastUploadToken"];
            } failure:^(StatusModel *status) {
                NSLog(@"failed upload");
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"lastUploadToken"];
            }];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } failure:^(StatusModel *status) {
            [self showNotice:@"登录失败"];
        }];
    }
}

- (void)checkCompleteButton
{
    if (!IsEmptyString(self.genderValueLabel.text)&&!IsEmptyString(self.nameTextField.text)&&!IsEmptyString(self.districtCode)) {
        [self setCompleteButtonEnabled:YES];
    }else{
        [self setCompleteButtonEnabled:NO];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self handleCompleteButton];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *nameText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *gender = self.genderValueLabel.text;
    if (!IsEmptyString(nameText)&& gender.length==1&&!IsEmptyString(self.districtCode)) {
        [self setCompleteButtonEnabled:YES];
    } else {
        [self setCompleteButtonEnabled:NO];
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self showPCDPicker:NO];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 0) {
        switch (buttonIndex) {
                
            case 0: // 拍照
            {
                [self avatarFromSourceType:UIImagePickerControllerSourceTypeCamera];
            }
                break;
            case 1: // 从手机相册选取
            {
                [self avatarFromSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            }
                break;
            default:
                break;
        }

    }else if(actionSheet.tag == 1){
        if (buttonIndex == 0) {
            self.genderValueLabel.text = @"男";
        }else{
            self.genderValueLabel.text = @"女";
        }
        self.genderValueLabel.textColor = Color_Gray(45);
        [self checkCompleteButton];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        UIImage *avatarImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        self.avatarImageView.image = avatarImage;
        
        [self showLoading];
        weakify(self);
        [UserRequest uploadImageWithParams:nil image:avatarImage success:^(ImageUploadResultModel *resultModel) {
            strongify(self);
            [self hideLoading];
            self.avatar = resultModel.url;
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
        }];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Loading

- (void)showLoading {
    //初始化进度框，置于当前的View当中
    self.loadingProgressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.loadingProgressHUD];
    
    //如果设置此属性则当前的view置于后台
    self.loadingProgressHUD.dimBackground = YES;
    
    //设置对话框文字
    self.loadingProgressHUD.labelText = @"请稍等";
    
    //显示对话框
    [self.self.loadingProgressHUD show:YES];
}

- (void)hideLoading
{
    if (self.loadingProgressHUD) {
        [self.loadingProgressHUD hide:YES];
        [self.loadingProgressHUD removeFromSuperview];
        self.loadingProgressHUD = nil;
        
    }
}


- (void)showPCDPicker:(BOOL)show
{
    if (self.cityArra.count == 0) {
        return;
    }
    CGRect frame = self.pcdPickerView.frame;
    
    if (show) {
        if (frame.origin.y < SCREEN_HEIGHT && frame.origin.y > SCREEN_HEIGHT-180) {
            return;
        }
        [self dismissKeyBoard];
        
        //定位
        if (!IsEmptyString(self.districtCode)) {
            NSString *provinceCode = [self.districtCode substringToIndex:2];
            NSString *cityCode = [self.districtCode substringToIndex:4];
            
            self.selectedIndex_province = 0;
            self.selectedIndex_city = 0;
            self.selectedIndex_area = 0;
            for (int i = 0; i < self.cityArra.count; i++) {
                ProvinceModel *province = [self.cityArra safeObjectAtIndex:i];
                
                if ([province.p.code hasPrefix:provinceCode]) {
                    self.selectedIndex_province = i;
                    
                    for (int j = 0; j < province.c.count; j++) {
                        CityModel *city = [province.c safeObjectAtIndex:j];
                        
                        if (city.a.count > 0) {
                            if ([city.n.code hasPrefix:cityCode]) {
                                self.selectedIndex_city = j;
                                
                                for (int k = 0; k < city.a.count; k++) {
                                    AreaModel *area = [city.a safeObjectAtIndex:k];
                                    if ([area.code isEqualToString:self.districtCode]) {
                                        self.selectedIndex_area = k;
                                    }
                                }
                                break;
                            }
                        }else{
                            if ([city.n.code isEqualToString:self.districtCode]) {
                                self.selectedIndex_city = j;
                                self.selectedIndex_area = -1;
                                break;
                            }
                        }
                    }
                    break;
                }
            }
            [self.pcdPickerView selectRow:self.selectedIndex_province inComponent:0 animated:NO];
            [self.pcdPickerView reloadComponent:1];
            [self.pcdPickerView selectRow:self.selectedIndex_city inComponent:1 animated:NO];
            [self.pcdPickerView reloadComponent:2];
            [self.pcdPickerView selectRow:self.selectedIndex_area inComponent:2 animated:NO];
        }
        
        [self pcdSelectUpdate];
        frame.origin.y = SCREEN_HEIGHT - 180;
    }else{
        if (frame.origin.y > SCREEN_HEIGHT-180 && frame.origin.y < SCREEN_HEIGHT) {
            return;
        }
        frame.origin.y = SCREEN_HEIGHT;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pcdPickerView.frame = frame;
    } completion:^(BOOL finished) {
        self.showPickerView = show;
    }];
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (PROVINCE_COLUMN == component) {
        
        return self.cityArra.count;
        
    }else if (CITY_COLUMN == component) {
        ProvinceModel *pmodel = [self.cityArra safeObjectAtIndex:self.selectedIndex_province];
        return pmodel.c.count;
        
    }else if (DISTRICT_COLUMN == component) {
        ProvinceModel *pmodel = [self.cityArra safeObjectAtIndex:self.selectedIndex_province];
        if (pmodel.c.count == 0) {
            return 0;
        }
        CityModel *cmodel = [pmodel.c safeObjectAtIndex:self.selectedIndex_city];
        return cmodel.a.count;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
-(NSString*)pickerView:(UIPickerView *)pickerView
           titleForRow:(NSInteger)row
          forComponent:(NSInteger)component
{
    if (PROVINCE_COLUMN == component) {
        ProvinceModel *pmodel = [self.cityArra safeObjectAtIndex:row];
        return pmodel.p.name;
        
    }else if (CITY_COLUMN == component) {
        ProvinceModel *pmodel = [self.cityArra safeObjectAtIndex:self.selectedIndex_province];
        CityModel *cmodel = [pmodel.c safeObjectAtIndex:row];
        return cmodel.n.name;
        
    }else if (DISTRICT_COLUMN == component) {
        ProvinceModel *pmodel = [self.cityArra safeObjectAtIndex:self.selectedIndex_province];
        CityModel *cmodel = [pmodel.c safeObjectAtIndex:self.selectedIndex_city];
        AreaModel *amodel = [cmodel.a safeObjectAtIndex:row];
        return amodel.name;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            self.selectedIndex_province = row;
            self.selectedIndex_city = 0;
            self.selectedIndex_area = 0;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 1:
            self.selectedIndex_city = row;
            self.selectedIndex_area = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 2:
            self.selectedIndex_area = row;
            break;
        default:
            break;
    }
    [self pcdSelectUpdate];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = FONT(16);
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)handleLocationButton
{
    [self endEditing];
    weakify(self);
    [self.locationManager startLocation:YES locationCompletion:nil addressCompletion:^(NSError *error, AMapAddressComponent *address) {
        strongify(self);
        self.pcdValueLabel.textColor = Color_Gray(45);
        self.pcdValueLabel.text = [NSString stringWithFormat:@"%@ %@ %@",address.province,address.city,address.district];
        
        self.province = address.province;
        self.city = address.city;
        self.district = address.district;
        
        self.districtCode = address.adcode;
        [self checkCompleteButton];
    }];
}
- (void)endEditing
{
    [self dismissKeyBoard];
    [self showPCDPicker:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing];
}

@end
