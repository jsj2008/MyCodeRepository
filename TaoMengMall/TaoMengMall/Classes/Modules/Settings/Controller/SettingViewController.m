//
//  SettingViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "SettingViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "STSettingCell.h"
#import "STSingleButtonCell.h"
#import "MineRequest.h"
#import "UserService.h"

@interface SettingViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *menu;

@end

@implementation SettingViewController

#pragma mark - Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"设置";
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self initData];
}

#pragma mark - Private Methods

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    self.menu = @[
                  @{@"type":@"avatar", @"title":@"头像", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"name", @"title":@"昵称", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"gender", @"title":@"性别", @"line":@NO, @"arrow":@YES},
                  @{@"type":@"empty"},
                  @{@"type":@"consignee", @"title":@"管理收货地址", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"empty"},
                  @{@"type":@"contact", @"title":@"联系我们", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"about", @"title":@"关于我们", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"protocol", @"title":@"用户协议", @"line":@YES, @"arrow":@YES}
                ];
    [self reloadData];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ( 1 == section ) {
        return 1;
    }
    
    return self.menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( 1 == indexPath.section ) {
        
        STSingleButtonCell *cell = [STSingleButtonCell dequeueReusableCellForTableView:tableView];
        [cell reloadData];
        return cell;
        
    }
    
    NSDictionary *itemData = [self.menu safeObjectAtIndex:indexPath.row];
    
    if ( ![@"empty" isEqualToString:itemData[@"type"]]) {
        
        STSettingCell *cell = [STSettingCell dequeueReusableCellForTableView:tableView];
        cell.cellData = itemData;
        [cell reloadData];
        return cell;
        
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height = 0;
    
    if ( 1 == indexPath.section ) {
        
        height = [STSingleButtonCell heightForCell:nil];
        
    } else {
        height = [STSettingCell heightForCell:[self.menu safeObjectAtIndex:indexPath.row]];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ( 0 == indexPath.section ) {
        
        NSDictionary *itemData = [self.menu safeObjectAtIndex:indexPath.row];
        
        if ( [@"avatar" isEqualToString:itemData[@"type"]] ) {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择头像来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选取", nil];
            actionSheet.tag = 1;
            [actionSheet showInView:self.view];
            
        } else if ( [@"name" isEqualToString:itemData[@"type"]] ) {
            
            [[TTNavigationService sharedService] openUrl:@"xiaoma://changeName"];
            
        } else if ( [@"gender" isEqualToString:itemData[@"type"]] ) {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
            actionSheet.tag = 2;
            [actionSheet showInView:self.view];
            
            //[[TTNavigationService sharedService] openUrl:@"xiaoma://changeGender"];
            
        }else if ([@"consignee" isEqualToString:itemData[@"type"]]) {
            
            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"consigneeSelect")];

        }else if ([@"contact" isEqualToString:itemData[@"type"]]) {
            NSString *supportLink = [[NSUserDefaults standardUserDefaults] objectForKey:@"supportLink"];
            [[TTNavigationService sharedService] openUrl:supportLink];
            
        }else if ([@"about" isEqualToString:itemData[@"type"]]) {
            
            NSString *aboutLink = [[NSUserDefaults standardUserDefaults] objectForKey:@"aboutLink"];
            [[TTNavigationService sharedService] openUrl:aboutLink];
            
        }else if ([@"protocol" isEqualToString:itemData[@"type"]]) {
            
            NSString *protocolLink = [[NSUserDefaults standardUserDefaults] objectForKey:@"protocolLink"];
            [[TTNavigationService sharedService] openUrl:protocolLink];
            
        }

    }
    
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: // 拍照
        {
            if (actionSheet.tag == 2) {
                [self genderAction:@"1"];
            }else{
                [self avatarFromSourceType:UIImagePickerControllerSourceTypeCamera];
            }
        }
            break;
        case 1: // 从手机相册选取
        {
            if (actionSheet.tag == 2) {
                [self genderAction:@"2"];
            }else{
                [self avatarFromSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            }
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
    
        UIImage *avatarImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        weakify(self);
        [MineRequest changeAvatarWithParams:nil image:avatarImage success:^(MIChangeAvatarResultModel *resultModel){
            
            [[UserService sharedService] updateInfo:resultModel.avatar for:@"avatar"];
            
            strongify(self);
            [self reloadData];
            
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

#pragma mark -
- (void) genderAction:(NSString*)gender
{
//    NSString *gender = @"1";//男
//    gender = @"2";//女
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafeObject:gender forKey:@"gender"];
    
    weakify(self);
    
    [MineRequest changeGenderWithParams:params success:^{
        
        [[UserService sharedService] updateInfo:gender for:@"gender"];
        
        strongify(self);
        
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        
        strongify(self);
        [self showNotice:status.msg];
        
    }];
    
}
@end
