//
//  ConsigneeEditViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ConsigneeEditViewController.h"
#import "ConsigneeRequest.h"

#import "AMUserLocationManager.h"
#import "XMAppThemeHelper.h"

#import "CityListModel.h"
#import "ProvinceModel.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "ConsigneeNoMenuTextField.h"

#define PROVINCE_COLUMN 0
#define CITY_COLUMN     1
#define DISTRICT_COLUMN 2

NSString *const kNOTIFY_CART_CONSIGNEE_EDIT_CREATE = @"kNOTIFY_CART_CONSIGNEE_EDIT_CREATE";

@interface ConsigneeEditViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) AMUserLocationManager *locationManager;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *inputBgView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UIView *lineView1;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextField *phoneTextField;

@property (nonatomic, strong) UIView *lineView2;

@property (nonatomic, strong) UILabel *provinceLabel;

@property (nonatomic, strong) UILabel *pcdValueLabel;

@property (nonatomic, strong) UIButton *locateMeButton;
@property (nonatomic, strong) UIView *lineView31;

@property (nonatomic, strong) UIView *lineView3;

//@property (nonatomic, strong) UIView *lineView4;

@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UITextField *addressTextField;

@property (nonatomic, strong) UIButton *okButton;

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
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
//@property (nonatomic, copy) NSString *cityCode;
//@property (nonatomic, copy) NSString *proviceCode;
@property (nonatomic, copy) NSString *districtCode;

@end

@implementation ConsigneeEditViewController

#pragma mark - Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 56, 20);
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:[XMAppThemeHelper defaultTheme].navigationBarButtonColor forState:UIControlStateNormal];
    doneButton.titleLabel.font = FONT(16);
    [doneButton addTarget:self action:@selector(handleOKButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightBarButton = doneButton;

    self.title = @"编辑收货地址";
    [self initData];
    
    //加载省市区数据
    [self loadPCDData];
    
}

#pragma mark - Private Methods

- (void) initData {
    
    self.province = @"";
    self.city = @"";
    self.district = @"";
    self.address = @"";
    self.name = @"";
    self.phone = @"";
    
    if ( self.consigneeId ) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setSafeObject:self.consigneeId forKey:@"consigneeId"];
     
        [ConsigneeRequest getConsigneeWithParams:params success:^(ConsigneeResultModel *resultModel) {
            
            self.province = resultModel.province;
            self.city = resultModel.city;
            self.address = resultModel.address;
            self.name = resultModel.name;
            self.phone = resultModel.phone;
            
            self.district = resultModel.district;

            if (resultModel.districtCode.length >= 6) {
                self.districtCode = resultModel.districtCode;
            }else{
                self.districtCode = resultModel.cityCode;
            }
            
            [self render];
            
        } failure:^(StatusModel *status) {
            
            [self showNotice:status.msg];
            
        }];
        
    } else {
        [self render];
    }
}

- (void) render
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.inputBgView];
    
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.nameTextField];
    
    [self.scrollView addSubview:self.lineView1];
    
    [self.scrollView addSubview:self.phoneLabel];
    [self.scrollView addSubview:self.phoneTextField];
    
    [self.scrollView addSubview:self.lineView2];
    
    [self.scrollView addSubview:self.provinceLabel];
    //[self.scrollView addSubview:self.pcdTextField];
    [self.scrollView addSubview:self.pcdValueLabel];
    [self.scrollView addSubview:self.locateMeButton];
    [self.scrollView addSubview:self.lineView31];
    [self.scrollView addSubview:self.lineView3];

    [self.scrollView addSubview:self.addressLabel];
    [self.scrollView addSubview:self.addressTextField];
    
    [self.view addSubview:self.pcdPickerView];
    //[self.view addSubview:self.okButton];
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
}

#pragma mark - Getters And Setters
- (UIScrollView*)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT,SCREEN_WIDTH , SCREEN_HEIGHT-NAVBAR_HEIGHT)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
        [scrollView addGestureRecognizer:tapGesture];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIView *)inputBgView {
    
    if ( !_inputBgView ) {
        
        _inputBgView = [[UIView alloc] initWithFrame:CGRectMake( 0, 20, SCREEN_WIDTH - 0, 44 * 4)];
        _inputBgView.backgroundColor = Color_White;
        _inputBgView.layer.borderColor = Color_Gray209.CGColor;
        _inputBgView.layer.borderWidth = LINE_WIDTH;
        _inputBgView.userInteractionEnabled = YES;
    }
    
    return _inputBgView;
}

- (UILabel *)nameLabel {
    
    if ( !_nameLabel ) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.inputBgView.top, 90, 44)];
        _nameLabel.textColor = Color_Gray42;
        _nameLabel.font = FONT(16);
        _nameLabel.text = @"收货人 :";
        _nameLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _nameLabel;
}

- (UITextField *)nameTextField {
    
    if ( !_nameTextField ) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, self.nameLabel.top, self.inputBgView.width - 100, 44)];
        _nameTextField.borderStyle = UITextBorderStyleNone;
        _nameTextField.font = FONT(16);
        _nameTextField.textColor = Color_Gray42;
        _nameTextField.text = self.name;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.delegate = self;

        _nameTextField.inputAccessoryView = [self inputAccessoryView];
    }
    
    return _nameTextField;
    
}

- (UIView *)lineView1 {
    
    if ( !_lineView1 ) {
        
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake( 0, 20 + 0 + 44, SCREEN_WIDTH - 0, LINE_WIDTH)];
        _lineView1.backgroundColor = Color_Gray230;
    }
    
    return _lineView1;
}

- (UILabel *)phoneLabel {
    
    if ( !_phoneLabel ) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lineView1.top, 90, 44)];
        _phoneLabel.textColor = Color_Gray42;
        _phoneLabel.font = FONT(16);
        _phoneLabel.text = @"手机号 :";
        _phoneLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _phoneLabel;
}

- (UITextField *)phoneTextField {
    
    if ( !_phoneTextField ) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, self.phoneLabel.top, self.inputBgView.width - 100, 44)];
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.font = FONT(16);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.textColor = Color_Gray42;
        _phoneTextField.text = self.phone;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;

        _phoneTextField.inputAccessoryView = [self inputAccessoryView];
    }
    
    return _phoneTextField;
    
}

- (UIView *)lineView2 {
    
    if ( !_lineView2 ) {
        
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake( 0, 20 + 0 + 44 * 2, SCREEN_WIDTH - 0, LINE_WIDTH)];
        _lineView2.backgroundColor = Color_Gray230;
    }
    
    return _lineView2;
}

- (UILabel *)provinceLabel {
    
    if ( !_provinceLabel ) {
        _provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lineView2.top, 90, 44)];
        _provinceLabel.textColor = Color_Gray42;
        _provinceLabel.font = FONT(16);
        _provinceLabel.text = @"省市区 :";
        _provinceLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _provinceLabel;
}

//- (ConsigneeNoMenuTextField *)pcdTextField {
//    
//    if ( !_pcdTextField ) {
//        _pcdTextField = [[ConsigneeNoMenuTextField alloc] initWithFrame:CGRectMake(100, self.provinceLabel.top, self.inputBgView.width - 100 - 63, 44)];
//        NSString *p = self.province?self.province:@"";
//        NSString *c = self.city?self.city:@"";
//        NSString *a = self.district?self.district:@"";
//        _pcdTextField.text = [NSString stringWithFormat:@"%@ %@ %@",p,c,a];
//        _pcdTextField.font = FONT(16);
//        _pcdTextField.textColor = Color_Gray42;
//        //_pcdTextField.inputAccessoryView = [self inputAccessoryView];
//        _pcdTextField.inputView = self.pcdPickerView;
//        
//        _pcdTextField.delegate = self;
//
//    }
//    
//    return _pcdTextField;
//}

- (UILabel*)pcdValueLabel
{
    if (!_pcdValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, self.provinceLabel.top, self.inputBgView.width - 100 - 63, 44)];
        label.font = FONT(16);
        NSString *p = self.province?self.province:@"";
        NSString *c = self.city?self.city:@"";
        NSString *a = self.district?self.district:@"";
        label.text = [NSString stringWithFormat:@"%@ %@ %@",p,c,a];
        label.textColor = Color_Gray42;
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



- (UIView *)lineView31 {
    
    if ( !_lineView31 ) {
        
        _lineView31 = [[UIView alloc] initWithFrame:CGRectMake( self.inputBgView.right-63, 20 + 0 + 44 * 2 + 5, LINE_WIDTH, 34)];
        _lineView31.backgroundColor = Color_Gray230;
    }
    
    return _lineView31;
}

- (UIButton *)locateMeButton
{
    if (!_locateMeButton) {
        _locateMeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.inputBgView.right-61,self.provinceLabel.top , 60, 44)];
        [_locateMeButton setTitle:@"定位" forState:UIControlStateNormal];
        [_locateMeButton setTitleColor:Color_Gray(157) forState:UIControlStateNormal];
        _locateMeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_locateMeButton.titleLabel sizeToFit];
        _locateMeButton.titleLabel.font = FONT(12);
        
        [_locateMeButton setImage:[UIImage imageNamed:@"consignee_location"] forState:UIControlStateNormal];
        
        [_locateMeButton setContentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft];
        [_locateMeButton setContentVerticalAlignment: UIControlContentVerticalAlignmentTop];
        
        [_locateMeButton setImageEdgeInsets: UIEdgeInsetsMake(6, (_locateMeButton.bounds.size.width-_locateMeButton.imageView.bounds.size.width)*0.5, 0, 0)];
        [_locateMeButton setTitleEdgeInsets: UIEdgeInsetsMake(_locateMeButton.imageView.bounds.size.height+5, (_locateMeButton.bounds.size.width-_locateMeButton.titleLabel.bounds.size.width)*0.5-_locateMeButton.imageView.bounds.size.width, 0, 0)];

        [_locateMeButton addTarget:self action:@selector(handleLocationButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _locateMeButton;
}

- (UIView *)lineView3 {
    
    if ( !_lineView3 ) {
        
        _lineView3 = [[UIView alloc] initWithFrame:CGRectMake( 0, 20 + 0 + 44 * 3, SCREEN_WIDTH - 0, LINE_WIDTH)];
        _lineView3.backgroundColor = Color_Gray230;
    }
    
    return _lineView3;
}


- (UILabel *)addressLabel {
    
    if ( !_addressLabel ) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lineView3.top, 90, 44)];
        _addressLabel.textColor = Color_Gray42;
        _addressLabel.font = FONT(16);
        _addressLabel.text = @"详细地址 :";
        _addressLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _addressLabel;
}

- (UITextField *)addressTextField {
    
    if ( !_addressTextField ) {
        _addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, self.addressLabel.top, self.inputBgView.width - 100, 44)];
        _addressTextField.borderStyle = UITextBorderStyleNone;
        _addressTextField.font = FONT(16);
        _addressTextField.textColor = Color_Gray42;
        _addressTextField.text = self.address;
        _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addressTextField.delegate = self;
        _addressTextField.inputAccessoryView = [self inputAccessoryView];
    }
    
    return _addressTextField;
    
}

- (UIButton *)okButton {
    
    if ( !_okButton ) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.frame = CGRectMake(20, self.inputBgView.bottom + 30, SCREEN_WIDTH - 40, 44);
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        [_okButton setTitleColor:Color_White forState:UIControlStateNormal];
        _okButton.titleLabel.font = FONT(16);
        _okButton.layer.masksToBounds = YES;
        _okButton.layer.cornerRadius = 4;
        _okButton.backgroundColor = Theme_Color;
        [_okButton addTarget:self action:@selector(handleOKButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _okButton;
}

- (AMUserLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [AMUserLocationManager sharedInstance];
    }
    return _locationManager;
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

- (UIView *)inputAccessoryView
{
    return [UIView new];
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

#pragma  mark - UITextfieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self showPCDPicker:NO];
}


#pragma mark - Event Response

- (void) dismissKeyBoard {
    
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
}

- (void)endEditing
{
    [self dismissKeyBoard];
    [self showPCDPicker:NO];
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

                                for (int k = 0; city.a.count; k++) {
                                    AreaModel *area = [city.a safeObjectAtIndex:k];
                                    if ([area.code isEqualToString:self.districtCode]) {
                                        self.selectedIndex_area = k;
                                        break;
                                    }
                                }
                            }
                        }else{
                            if ([city.n.code isEqualToString:self.districtCode]) {
                                self.selectedIndex_city = j;
                                self.selectedIndex_area = -1;
                                break;
                            }
                        }
                    }
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

- (void) handleOKButton {
    
    NSString *name = [self.nameTextField.text trim];
    NSString *phone = [self.phoneTextField.text trim];
    NSString *address = [self.addressTextField.text trim];
    
    NSString *province = self.province;
    NSString *city = self.city;
    NSString *district = self.district;
    
    DBG(@"%@ %@ %@ %@ %@ %@ %@", name, phone, address,province, city,district, address);
    
    if (IsEmptyString(name)) {
        [self showNotice:@"请填写收货人"];
    } else if ( IsEmptyString(phone)) {
        [self showNotice:@"请填写手机号"];
    } else if ( IsEmptyString(province)) {
        [self showNotice:@"请填写省市区"];
    } else if ( IsEmptyString(address)) {
        [self showNotice:@"请填写详细地址"];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:name forKey:@"name"];
    [params setSafeObject:phone forKey:@"phone"];
    [params setSafeObject:self.districtCode forKey:@"district"];
    [params setSafeObject:address forKey:@"address"];
    
    weakify(self);
    if ( self.consigneeId ) { // 保存
        
        [params setSafeObject:self.consigneeId forKey:@"consigneeId"];
        
        [ConsigneeRequest editConsigneeWithParams:params success:^{
            
            [self showNotice:@"修改成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_CONSIGNEE_EDIT_CREATE object:nil];
            
            [self clickback];
            
        } failure:^(StatusModel *status) {
            
            strongify(self);
            if (status) {
                DBG(@"%@", status);
                [self showNotice:status.msg];
            } else {
                [self showNotice:@"修改失败"];
            }
            
        }];
        
    } else { // 添加
        
        [ConsigneeRequest addConsigneeWithParams:params success:^(ConsigneeAddResultModel *resultModel) {
            
            [self showNotice:@"添加成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_CONSIGNEE_EDIT_CREATE object:nil];
            
            [self clickback];
            
        } failure:^(StatusModel *status) {
            
            strongify(self);
            if (status) {
                DBG(@"%@", status);
                [self showNotice:status.msg];
            } else {
                [self showNotice:@"添加失败"];
            }
            
        }];
        
    }
    
}

- (void)handleLocationButton
{
    [self endEditing];
    weakify(self);
    [self.locationManager startLocation:YES locationCompletion:nil addressCompletion:^(NSError *error, AMapAddressComponent *address) {
        strongify(self);
        self.pcdValueLabel.text = [NSString stringWithFormat:@"%@ %@ %@",address.province,address.city,address.district];

        self.province = address.province;
        self.city = address.city;
        self.district = address.district;

        self.districtCode = address.adcode;
    }];
}


@end
