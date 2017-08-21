//
//  RFApplyViewController.m
//  Refound
//
//  Created by marco on 6/2/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RFApplyViewController.h"

#import "RFReceiptStatusCell.h"
#import "RFReasonInputCell.h"
#import "RFSumCell.h"
#import "RFExplainCell.h"
#import "RFImagesCell.h"

#import "RefundApplyModel.h"

#import "RefundRequest.h"

@interface RFApplyViewController ()<RFImagesCell,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

//@property (nonatomic, strong)NSArray *types;
@property (nonatomic, strong)NSArray *causes;
//@property (nonatomic, strong)NSArray *ways;
@property (nonatomic, strong)NSString *maxRefundAmount;

//@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) RFApplyResultModel *resultModel;
@property (nonatomic, strong) RefundApplyModel *model;
@property (nonatomic, strong) MBProgressHUD *loadingProgressHUD;
@property (nonatomic, strong) UIButton *applyButton;
@end

@implementation RFApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    self.tableView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT - 50;
    
    self.title = @"申请退款";
    self.model = [[RefundApplyModel alloc]initModel];
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.loadingType = kInit;
    //self.images = [NSMutableArray array];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //self.orderId = @"909";
    [params setSafeObject:self.orderId forKey:@"orderId"];
    weakify(self);
    [RefundRequest getRefundApplyDataWithParams:params success:^(RFApplyResultModel *resultModel) {
        strongify(self);
        //self.types = resultModel.types;
        self.causes = resultModel.causes;
        //self.ways = resultModel.ways;
        self.resultModel = resultModel;
        self.maxRefundAmount = resultModel.maxRefundAmount;
        self.model.sum = self.maxRefundAmount;
        [self reloadData];
        [self finishRefresh];
        [self.view addSubview:self.applyButton];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
    }];
}

- (UIButton*)applyButton
{
    if (!_applyButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [button setBackgroundColor:Theme_Color];
        [button setTitle:@"提交申请" forState:UIControlStateNormal];
        [button setTitleColor:Color_White forState:UIControlStateNormal];
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = FONT(18);
        [button addTarget:self action:@selector(applyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        button.bottom = self.view.bottom;
        _applyButton = button;
    }
    return _applyButton;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 5;
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    switch (section) {
        case 0:
            if (row == 1) {
                RFReceiptStatusCell *cell = [RFReceiptStatusCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.model;
                [cell reloadData];
                return cell;
            }
            break;
        case 1:
            if (row == 1) {
                RFReasonInputCell *cell = [RFReasonInputCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.model;
                cell.reasons = self.causes;
                [cell reloadData];
                return cell;
            }
            break;
        case 2:
            if (row == 1) {
                RFSumCell *cell = [RFSumCell dequeueReusableCellForTableView:tableView];
                cell.maxRefundAmount = self.maxRefundAmount;
                cell.cellData = self.model;
                [cell reloadData];
                return cell;
            }
            break;
        case 3:
            if (row == 1) {
                RFExplainCell *cell = [RFExplainCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.model;
                [cell reloadData];
                return cell;
            }
            break;
        case 4:
            if (row == 1) {
                RFImagesCell *cell = [RFImagesCell dequeueReusableCellForTableView:tableView];
                cell.delegate = self;
                cell.cellData = self.model;
                [cell reloadData];
                return cell;
            }
            break;
        default:
            break;
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 14;
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    switch (section) {
        case 0:
            if (row == 1) {
                height = [RFReceiptStatusCell heightForCell:self.resultModel];
            }
            break;
        case 1:
            if (row == 1) {
                height = [RFReasonInputCell heightForCell:self.resultModel];
            }
            break;
        case 2:
            if (row == 1) {
                height = [RFSumCell heightForCell:self.resultModel];
            }
            break;
        case 3:
            if (row == 1) {
                height = [RFExplainCell heightForCell:self.resultModel];
            }
            break;
        case 4:
            if (row == 1) {
                height = [RFImagesCell heightForCell:self.resultModel];
            }
            break;
        default:
            height = 14;
            break;
    }
    
    return height;
}

#pragma mark - private
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

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [self showLoading];
        weakify(self);
        [BaseRequest uploadImageWithParams:nil image:image success:^(ImageUploadResultModel *resultModel) {
            strongify(self);
            [self hideLoading];
            NSString *imageUrl = resultModel.url;
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setSafeObject:imageUrl forKey:@"imageURL"];
            [dict setSafeObject:image forKey:@"imageData"];
            [self.model.imageObjs addObject:dict];
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

#pragma mark - ReviewInfoCell delegate
- (void)addImageTapped:(RFImagesCell*)cell
{
    [self.tableView endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选取", nil];
    [actionSheet showInView:self.view];
}

- (void)deleteImageTappedWithIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认删除该图片？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = index;
    [alert show];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        [self.model.imageObjs removeObjectAtIndex:alertView.tag];
        [self reloadData];
    }
}

- (void)submitRefund
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.orderId forKey:@"orderId"];
    
    if ([self.model.sum floatValue] > [self.maxRefundAmount floatValue]) {
        [self showNotice:@"退款金额超过上限"];
        return;
    }else if ([self.model.sum floatValue] == 0.) {
        [self showNotice:@"请填写退款金额"];
        return;
    }
    
    if (self.model.reason == 0) {
        [self showNotice:@"请选择退款原因"];
        return;
    }
    
    [params setSafeObject:self.model.receiptStatus forKey:@"isReceived"];
    [params setSafeObject:@(self.model.reason) forKey:@"reasonId"];
    [params setSafeObject:self.model.sum forKey:@"price"];
    [params setSafeObject:self.model.desc forKey:@"desc"];
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (NSDictionary *dict in self.model.imageObjs) {
        [imageUrls addSafeObject:[dict objectForKey:@"imageURL"]];
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:imageUrls
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *images = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [params setSafeObject:images forKey:@"images"];
    
    weakify(self);
    [RefundRequest submitRefundWithParams:params success:^() {
        strongify(self);
        [self showNotice:@"退款申请已提交"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self clickback];
        });
    } failure:^(StatusModel *status) {
        strongify(self);
        [self showNotice:@"退款申请提交失败"];
    }];
}

- (void)applyButtonTapped
{
    [self submitRefund];
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
