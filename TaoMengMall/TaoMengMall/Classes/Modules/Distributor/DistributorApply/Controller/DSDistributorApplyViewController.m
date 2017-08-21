//
//  DSDistributorApplyViewController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSDistributorApplyViewController.h"
#import "DistributorRequest.h"
#import "DSDistributorApplyModel.h"
#import "DSDAPlainTitleCell.h"
#import "DSDACertificateCell.h"
#import "DSDAInfomationCell.h"
#import "DSDASubmitCell.h"
#import "DistributorHeader.h"

@interface DSDistributorApplyViewController ()<DSDACertificateCellDelegate,DSDAInfomationCellDelegate,DSDASubmitCellDelegate>
@property (nonatomic, strong) MBProgressHUD *loadingProgressHUD;
@property (nonatomic, strong) DSDistributorApplyModel *applyModel;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, assign) NSInteger tmpIndex;
@end

@implementation DSDistributorApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"申请为分销商";
    self.applyModel = [[DSDistributorApplyModel alloc]init];
    self.applyModel.name = [UserService sharedService].name;
    self.applyModel.phone = [UserService sharedService].phone;
    [self reloadData];
    [self checkSubmitButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitButtonTapped
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.applyModel.frontImageObj[@"imageURL"] forKey:@"idFront"];
    [params setSafeObject:self.applyModel.backImageObj[@"imageURL"] forKey:@"idBack"];
    [params setSafeObject:self.applyModel.name forKey:@"name"];
    [params setSafeObject:self.applyModel.phone forKey:@"phone"];

    [DistributorRequest applyDistributorWithParams:params success:^{
        [self clickback];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if (row == 0) {
            DSDAPlainTitleCell *cell = [DSDAPlainTitleCell dequeueReusableCellForTableView:tableView];
            cell.titleLabel.font = FONT(12);
            cell.titleLabel.textColor = Color_Gray100;
            cell.cellData = @{@"title":@"身份证信息"};
            [cell reloadData];
            return cell;
        }else if (row == 1) {
            DSDACertificateCell *cell = [DSDACertificateCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.applyModel;
            cell.delegate = self;
            [cell reloadData];
            return cell;
        }
    }else if (section == 1) {
        if (row == 0) {
            DSDAPlainTitleCell *cell = [DSDAPlainTitleCell dequeueReusableCellForTableView:tableView];
            cell.titleLabel.font = FONT(12);
            cell.titleLabel.textColor = Color_Gray100;
            cell.cellData = @{@"title":@"个人信息"};
            [cell reloadData];
            return cell;
        }else if (row == 1) {
            DSDAInfomationCell *cell = [DSDAInfomationCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.applyModel;
            cell.delegate = self;
            [cell reloadData];
            return cell;
        }else if (row == 2) {
            DSDASubmitCell *cell = [DSDASubmitCell dequeueReusableCellForTableView:tableView];
            cell.delegate = self;
            self.submitButton = cell.submitButton;
            [cell reloadData];
            return cell;
        }
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if (row == 0) {
            height = 30;
        }else if (row == 1) {
            height = [DSDACertificateCell heightForCell:@""];
        }
    }else if (section == 1) {
        if (row == 0) {
            height = 30;
        }else if (row == 1) {
            height = [DSDAInfomationCell heightForCell:@""];
        }else if (row == 2) {
            height = [DSDASubmitCell heightForCell:@""];
        }else if (row == 3) {
            height = 60;
        }
    }
    return height;
}

#pragma mark -
- (void)textFieldDidChanged
{
    [self checkSubmitButton];
}

- (void)checkSubmitButton
{
    DSDistributorApplyModel *model = self.applyModel;
    BOOL enable = !IsEmptyString(model.name)&&!IsEmptyString(model.phone)&&model.frontImageObj&&model.backImageObj;
    [self setSubmitButtonEnable:enable];
}

- (void)setSubmitButtonEnable:(BOOL)enable
{
    self.submitButton.enabled = enable;
    if (enable) {
        self.submitButton.backgroundColor = Theme_Color;
    }else{
        self.submitButton.backgroundColor = Disable_Gray;
    }
}

#pragma mark -ALPictureAddCellDelegate
- (void)addButtonTappedAtIndex:(NSInteger)index
{
    self.tmpIndex = index;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选取", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        
        UIImage *avatarImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        weakify(self);
        [self showLoading];
        [BaseRequest uploadImageWithParams:nil image:avatarImage success:^(ImageUploadResultModel *resultModel) {
            strongify(self);
            [self hideLoading];
            if (self.tmpIndex == 0) {
                self.applyModel.frontImageObj = @{@"imageURL":resultModel.url,@"imageData":avatarImage};
            }else{
                self.applyModel.backImageObj = @{@"imageURL":resultModel.url,@"imageData":avatarImage};
            }
            [self checkSubmitButton];
            [self reloadData];
        } failure:^(StatusModel *status) {
            [self hideLoading];
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
    
    if (!_loadingProgressHUD) {
        
        //初始化进度框，置于当前的View当中
        self.loadingProgressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.loadingProgressHUD];
        
        //如果设置此属性则当前的view置于后台
        self.loadingProgressHUD.dimBackground = YES;
        
        //设置对话框文字
        self.loadingProgressHUD.labelText = @"正在上传图片...";
    }
    
    //显示对话框
    [self.loadingProgressHUD show:YES];
}

- (void)hideLoading
{
    if (self.loadingProgressHUD) {
        [self.loadingProgressHUD hide:YES];
        [self.loadingProgressHUD removeFromSuperview];
        self.loadingProgressHUD = nil;
        
    }
}
@end
