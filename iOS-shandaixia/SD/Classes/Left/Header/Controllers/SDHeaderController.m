//
//  SDHeaderController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDHeaderController.h"
#import "YAXSettingCell.h"
#import "SDUserInfo.h"
#import "SDBankCardController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDUserCenter.h"

#import "OliveappLivenessDetectionViewController.h"
#import "SDStartProveController.h"
#import "SDProveRelationController.h"
#import "SDUserVerifyDetail.h"
#import "SDProveOperatorsController.h"
#import "SDLoginController.h"
#import "SDSignatureSettingController.h"
#import "SDAccount.h"

@interface SDHeaderController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) SDUserInfo *userInfo;

@property (nonatomic,weak) YAXSettingCell *cell;

//头像
@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, strong) SDUserCenter *userCenter;

@property (nonatomic, strong) SDUserVerifyDetail *userVerifyDetail;

@end

@implementation SDHeaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"个人中心"];
    
    self.tableView.bounces = NO;
    
    [self loadData];
    
    [SDNotificationCenter addObserver:self selector:@selector(loadData) name:SDBankCardChangedNotification object:nil];
    
}

- (void)loadData{
    
    __weak __typeof(self)weakSelf = self;
    
    [SVProgressHUD show];
    
    [SDUserCenter getUserCenterFinishedBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        weakSelf.userCenter = object;
        [weakSelf.tableView reloadData];
        
    } failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    //创建cell
    YAXSettingCell *cell = [YAXSettingCell cellWithTableView:tableView];
    
    //获取数据
    cell.item = self.groups[indexPath.section][YAXItems][indexPath.row];
    
    if (indexPath.section == 0) {
        
        self.cell = cell;
        
        if (self.iconImage) {
            
            cell.titleIconImageView.image = self.iconImage;
        }
        
        
        else if (self.userCenter.headPortrait.length) {
            
            [cell.titleIconImageView sd_setImageWithURL:[NSURL URLWithString:self.userCenter.headPortrait]];
            
            
            
        }else{
            
            cell.titleIconImageView.image = [UIImage imageNamed:@"small_headicon"];
        }
        
    }
    
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            cell.contentLabel.text = self.userCenter.realName;
            cell.contentLabel.textColor = FDColor(153, 153, 153);
            
        }
        
        else if (indexPath.row == 1) {
            
            cell.contentLabel.text = self.userCenter.relationName;
            cell.contentLabel.textColor = FDColor(153, 153, 153);
        }
        
        else if (indexPath.row == 2) {
            
            cell.contentLabel.text = self.userCenter.phone;
            cell.contentLabel.textColor = FDColor(153, 153, 153);
        }
        else if (indexPath.row == 3) {
            
            if (self.userCenter.bankNumber.length > 0) {
                
                cell.contentLabel.text = [NSString stringWithFormat:@"%@ **** **** %@",[self.userCenter.bankNumber substringToIndex:4],[self.userCenter.bankNumber substringFromIndex:self.userCenter.bankNumber.length - 4]];
            }else{
                
                cell.contentLabel.text = @"请添加银行卡";
            }
            
            
        }
        
    }
    
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            cell.contentLabel.text = @"自动签署";
            
        }
        
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 120 * SCALE;
    }
    
    return 100 * SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20 * SCALE;
}




#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        //打开相册
        [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    else if (indexPath.section == 1) {
        
        SDUserInfo *userInfo = [SDUserInfo getUserInfo];
        
        if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
            
            [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
            
            
        }
        
        else if (![self.userVerifyDetail.autonymStatus isEqual:@(1)]) {
            
            //未验证
            SDStartProveController *startCon = [[SDStartProveController alloc] init];
            [startCon addContentWithImageNamed:@"bigicon_card"];
            [startCon addHeaderWithImage:@"progress-bar1"];
            [self.navigationController pushViewController:startCon animated:YES];
        }else if (![self.userVerifyDetail.ocrStatus isEqual:@(1)]){
            
            
            [self next];
        }else if (![self.userVerifyDetail.kinsfolkStatus isEqual:@(1)]){
            
            [self.navigationController pushViewController:[[SDProveRelationController alloc] init] animated:YES];
        }else if ([self.userVerifyDetail.operatorStatus isEqual:@(0)]){
            [self.navigationController pushViewController:[[SDProveOperatorsController alloc] init] animated:YES];
        }else if ([self.userVerifyDetail.operatorStatus isEqual:@(2)]){
            
            [@"运营商认证中" showNotice];
        }else{
            
            switch (indexPath.row) {
                case 0:
                    
                    [@"身份信息已是最新" showNotice];
                    
                    break;
                case 1:
                    
                    [@"紧急联系人信息已是最新" showNotice];
                    
                    break;
                case 2:
                    
                    break;
                    
                case 3:
                    
                {
                    SDBankCardController *bankCon = [[SDBankCardController alloc] init];
                    
                    bankCon.userCenter = self.userCenter;
                    
                    [self.navigationController pushViewController:bankCon animated:YES];
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        
        
    }
    
    else if(indexPath.section == 2){
        // 添加电子签名 自动签署
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                           message:@"您还未进行实名认证"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"去认证", nil];
        
        
        SDUserInfo *userInfo = [SDUserInfo getUserInfo];
        
        if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
            [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
        }
        else if (![self.userVerifyDetail.autonymStatus isEqual:@(1)]) {
            [alertView show];
        }else if (![self.userVerifyDetail.ocrStatus isEqual:@(1)]){
            [alertView show];
        }else if (![self.userVerifyDetail.kinsfolkStatus isEqual:@(1)]){
            [alertView show];
        }else if ([self.userVerifyDetail.operatorStatus isEqual:@(0)]){
            [alertView show];
        }else if ([self.userVerifyDetail.operatorStatus isEqual:@(2)]){
            [alertView show];
        } else {
            SDSignatureSettingController *signatureCon = [[SDSignatureSettingController alloc] init];
            signatureCon.realName = self.userCenter.realName;
            [self.navigationController pushViewController:signatureCon animated:YES];
        }
        
    }
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    image = [self imageByScalingAndCroppingForSize:CGSizeMake(400*SCALE, 400*SCALE) image:image];
    //
    self.cell.titleIconImageView.image = image;
    
    self.iconImage = image;
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    [userInfo updateHeaderImage:image];
    
    userInfo.image = image;
    
    [userInfo saveUserInfo];
    
    
}

//图片压缩到指定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage *)image
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)next{
    
    
    
    NSLog(@"开始活体检测");
    
    //获取活体检测的storyboard和viewcontroller对象
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"LivenessDetection" bundle: nil];
    
    
    /**
     对于iPad，活体检测有两种布局，竖屏和横屏。综合防hack,通过率和体验，强力推荐使用竖屏布局！
     */
    OliveappLivenessDetectionViewController* livenessViewController = (OliveappLivenessDetectionViewController*) [board instantiateViewControllerWithIdentifier: @"LivenessDetectionStoryboard"];
    
    //横屏布局的界面，如果要使用的话，请使用下面代码
    //    OliveappLivenessDetectionViewController* livenessViewController = (OliveappLivenessDetectionViewController*) [board instantiateViewControllerWithIdentifier: @"LivenessDetectionLandscapeStoryboard"];
    
    //以下样例代码展示了如何初始化活体检测
    __weak typeof(self) weakSelf = self;
    NSError *error;
    BOOL isSuccess;
    
    //Mode有两种模式，默认第二种，体验更好
    // INSTANT_CHANGE,活体检测动作成功后不等语音播放完就进入下一个动作
    // FLUENT_CHANGE,活体检测动作成功后会等语音播放完才进入下一个动作
    isSuccess = [livenessViewController setConfigLivenessDetection: weakSelf
                                                          withMode: FLUENT_CHANGE
                                                         withError: &error];
    //弹出活体检测界面，可用show,push
    [self presentViewController:livenessViewController animated:YES completion:nil];
}


/////////////////// 结果回调函数 /////////////////////

/**
 *  活体检测成功的回调
 *
 *  @param detectedFrame 返回检测到的图像
 */
- (void) onLivenessSuccess: (OliveappDetectedFrame*)detectedFrame {
    
    //detectedFrame中有4个用于比对的数据包，具体使用哪个数据包进行比对请咨询对接工作人员
    //对数据包进行Base64编码的方法，用户发送Http请求,下面以带翻拍的数据包为样例
    //NSString * data = [OliveappBase64Helper encode:detectedFrame.verificationDataFullWithFanpai];
    
    NSLog(@"活体检测成功");
    
    
    self.view.userInteractionEnabled = NO;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [SVProgressHUD showWithStatus:@"正在对比身份信息"];
        
        [SDAccount testUserWithOliveappDetectedFrame:detectedFrame finishedBlock:^(id object) {
            
            
            
            [SVProgressHUD dismiss];
            
            NSString *str = object[@"msg"];
            
            self.view.userInteractionEnabled = YES;
            
            
            if ([str containsString:@"成功"]) {
                
                [FDReminderView showWithString:object[@"msg"]];
                
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    
                    
                    SDProveRelationController *nameCon = [[SDProveRelationController alloc] init];
                    
                    //                nameCon.userInfo = self.userInfo;
                    
                    [self.navigationController pushViewController:nameCon animated:YES];
                    
                });
                
            }else{
                
                [FDReminderView showWithString:@"活体检测失败"];
            }
            
            
        } failuredBlock:^(id object) {
            
            self.view.userInteractionEnabled = YES;
            
            [FDReminderView showWithString:@"请检查网络"];
        }];
    }];
    
}


/**
 *  活体检测失败的回调
 *
 *  @param sessionState  活体检测的返回状态
 *  @param detectedFrame 返回检测到的图像
 */
- (void) onLivenessFail: (int)sessionState withDetectedFrame: (OliveappDetectedFrame*)detectedFrame {
    NSLog(@"活体检测失败");
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [@"活体检测失败,请重新检测" showNotice];
        
    }];
}

#pragma mark - cancel
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        SDUserInfo *userInfo = [SDUserInfo getUserInfo];
        
        if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
            
            [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
            
            
        }
        
        else if (![self.userVerifyDetail.autonymStatus isEqual:@(1)]) {
            
            //未验证
            SDStartProveController *startCon = [[SDStartProveController alloc] init];
            [startCon addContentWithImageNamed:@"bigicon_card"];
            [startCon addHeaderWithImage:@"progress-bar1"];
            [self.navigationController pushViewController:startCon animated:YES];
        }else if (![self.userVerifyDetail.ocrStatus isEqual:@(1)]){
            
            
            [self next];
        }else if (![self.userVerifyDetail.kinsfolkStatus isEqual:@(1)]){
            
            [self.navigationController pushViewController:[[SDProveRelationController alloc] init] animated:YES];
        }else if ([self.userVerifyDetail.operatorStatus isEqual:@(0)]){
            
            
            [self.navigationController pushViewController:[[SDProveOperatorsController alloc] init] animated:YES];
        }else if ([self.userVerifyDetail.operatorStatus isEqual:@(2)]){
            
            [@"运营商认证中" showNotice];
        }else{
        }
    }
}


/**
 *  取消按钮的操作方法
 */
- (void) onLivenessCancel {
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [SDUserVerifyDetail getUserVerifyDetailFinishedBlock:^(id object) {
        
        self.userVerifyDetail = object;
        
        
    } failuredBlock:^(id object) {
        
    }];
}

@end















