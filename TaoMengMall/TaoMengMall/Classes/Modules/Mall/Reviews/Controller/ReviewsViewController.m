//
//  ReviewsViewController.m
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "ReviewsViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import "RVShopRateCell.h"
#import "RVSkuRateCell.h"

#import "RVShopRateInfoModel.h"
#import "ReviewInfoModel.h"

#import "ReviewsRequest.h"

@interface ReviewsViewController ()<RVSkuRateCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

//@property (nonatomic, strong) NSArray *skuInfos;
@property (nonatomic, strong) NSMutableArray *reviewInfos;

@property (nonatomic, strong) RVShopRateInfoModel *shopInfo;
@property (nonatomic, strong) MBProgressHUD *loadingProgressHUD;
@property (nonatomic, strong) UIButton *publishButton;

@property (nonatomic, strong) NSIndexPath *curIndexPath;
@end

@implementation ReviewsViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    self.tableView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT - 50;

    self.title = @"我要评价";
    
    [self initData];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:kNOTIFY_PROOF_IMAGE_UPDATE object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)initData
{
    self.reviewInfos = [NSMutableArray array];
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    
    [params setSafeObject:self.orderId forKey:@"orderId"];
    
    [ReviewsRequest getReviewDataWithParams:params success:^(ReviewResultModel *resultModel) {
        
        if (resultModel && resultModel.skuInfos) {
            RVShopRateInfoModel *shopModel = [[RVShopRateInfoModel alloc]init];
            shopModel.s = @"5";
            shopModel.r = @"5";
            self.shopInfo = shopModel;
            
            //self.skuInfos = [[NSArray<RVSkuInfoModel> alloc] initWithArray:resultModel.skuInfos];
            for (int i = 0; i < resultModel.skuInfos.count; i++) {
                ReviewInfoModel *reviewModel = [[ReviewInfoModel alloc]init];
                RVSkuInfoModel *skuInfo = [resultModel.skuInfos safeObjectAtIndex:i];
                reviewModel.skuId = skuInfo.skuId;
                reviewModel.image = skuInfo.image;
                reviewModel.d = @"5";
                reviewModel.anonymous = YES;
                reviewModel.imageObjs = [NSMutableArray array];
                //reviewModel.images = [NSMutableArray array];
                //reviewModel.imageDatas = [NSMutableArray array];
                [self.reviewInfos addObject:reviewModel];
            }
            [self reloadData];
            
            [self.view addSubview:self.publishButton];
        }
        
        if (!resultModel || !resultModel.skuInfos || resultModel.skuInfos.count <= 0) {
            NSString *noticeStr = @"没有可以评价的商品哦";
            [self showEmptyTips:noticeStr ownerView:self.tableView];
            self.tableView.showsInfiniteScrolling = NO;
        }
        
    } failure:^(StatusModel *status) {
        
        DBG(@"%@", status);
        
        [self showNotice:status.msg];
        //        [self showErrorTips];
        
    }];
    
}

- (UIButton*)publishButton
{
    if (!_publishButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [button setBackgroundColor:Theme_Color];
        [button setTitle:@"确认发布" forState:UIControlStateNormal];
        [button setTitleColor:Color_White forState:UIControlStateNormal];
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = FONT(18);
        [button addTarget:self action:@selector(publishButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        button.bottom = self.view.bottom;
        _publishButton = button;
    }
    return _publishButton;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 0;
    
    if ( self.reviewInfos.count ) {
        numberOfSections = 1 + self.reviewInfos.count + 1;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ( self.reviewInfos ) {

        if( [self.reviewInfos safeObjectAtIndex:section] ) {
            
            return 2;
            
        } else if (section == self.reviewInfos.count){
            
            return 1;
            
        }else {
            return 1;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if ( self.reviewInfos.count ) {
        
        if( [self.reviewInfos safeObjectAtIndex:section] ) {
            
            if (row == 0) {
                ReviewInfoModel *reviewInfo = (ReviewInfoModel *)[self.reviewInfos safeObjectAtIndex:section];
                RVSkuRateCell *cell = [RVSkuRateCell dequeueReusableCellForTableView:tableView];
                cell.delegate = self;
                cell.cellData = reviewInfo;
                [cell reloadData];
                return cell;
            }

        }else if (section == self.reviewInfos.count) {
            
            RVShopRateCell *cell = [RVShopRateCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.shopInfo;
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
    
    if ( self.reviewInfos.count ) {
        
        if( [self.reviewInfos safeObjectAtIndex:section] ) {
            
            if (row == 0) {
                ReviewInfoModel *skuInfo = (ReviewInfoModel *)[self.reviewInfos safeObjectAtIndex:section];
                height = [RVSkuRateCell heightForCell:skuInfo];

            }else{
                height = 14;
            }
            
        }else if (section == self.reviewInfos.count) {
            
            height = [RVShopRateCell heightForCell:self.shopInfo];
            
        }else {
            
            height = TOTAL_BAR_VIEW_HEIGHT;

        }
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

- (NSString *) bulidReviewInfosJson {
    
    NSMutableArray *comments = [NSMutableArray array];

    for (ReviewInfoModel *reviewInfo in self.reviewInfos) {
        
        NSMutableDictionary *reviewInfoData = [NSMutableDictionary dictionary];
        [reviewInfoData setSafeObject:reviewInfo.skuId forKey:@"skuId"];
        [reviewInfoData setSafeObject:reviewInfo.comment?reviewInfo.comment:@"" forKey:@"comment"];
        [reviewInfoData setSafeObject:reviewInfo.d forKey:@"d"];
        [reviewInfoData setObject:reviewInfo.anonymous?@"1":@"0" forKey:@"isAnonymous"];
        
        NSMutableArray *images = [NSMutableArray array];
        for (NSDictionary *imageObj in reviewInfo.imageObjs) {
            [images addSafeObject:[imageObj objectForKey:@"imageURL"]];
        }
        [reviewInfoData setSafeObject:images forKey:@"imageUrl"];
        
        [comments addSafeObject:reviewInfoData];
    }

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:comments
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
            if (self.curIndexPath) {
                ReviewInfoModel *model = [self.reviewInfos safeObjectAtIndex:self.curIndexPath.section];
                [model.imageObjs addObject:@{@"imageData":image,@"imageURL":imageUrl}];
            }
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
    self.curIndexPath = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ReviewInfoCell delegate
- (void)addImageTapped:(RVSkuRateCell*)cell
{
    [self.tableView endEditing:YES];
    self.curIndexPath = [self.tableView indexPathForCell:cell];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选取", nil];
    [actionSheet showInView:self.view];
}


#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
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

#pragma mark - button actions
- (void)publishButtonTapped
{
    //检查是否已经完成评分
    BOOL finished = YES;
    if ([self.shopInfo.s integerValue] != 0 && [self.shopInfo.r integerValue] !=0) {
        for (ReviewInfoModel *model in self.reviewInfos) {
            if ([model.d integerValue] == 0) {
                finished = NO;
                break;
            }
        }
    }else{
        finished = NO;
    }
    
    if (!finished) {
        [self showNotice:@"请完成评分"];
        return;
    }
    //发送评价
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *reviewInfosJson = [self bulidReviewInfosJson];
    
    [params setSafeObject:self.shopInfo.s forKey:@"s"];
    [params setSafeObject:self.shopInfo.r forKey:@"r"];

    [params setSafeObject:self.orderId forKey:@"orderId"];
    [params setSafeObject:reviewInfosJson forKey:@"comments"];
    weakify(self);
    [ReviewsRequest submitReviewWithParams:params success:^{
        strongify(self);
        [self showNotice:@"评价成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self clickback];
        });
    } failure:^(StatusModel *status) {
        strongify(self);
        [self showNotice:@"提交评价失败"];
    }];

}
@end
