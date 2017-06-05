//
//  SDHelpAppController.m
//  SD
//
//  Created by LayZhang on 2017/5/31.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDHelpAppController.h"
#import "SDTopStatusView.h"
#import "SDQuestionCell.h"
#import "SDFeedBackView.h"
#import "SDFeedBackModel.h"

#define UnselectCellIndex -1

@interface SDHelpAppController () <UITableViewDelegate, UITableViewDataSource, TopStatusDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FeedBackImageDelegate>

@property (nonatomic, weak) SDTopStatusView *topStatusView;
@property (nonatomic, assign)SDQuestionType questionType;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSDictionary *questionDic;
@property (nonatomic, strong) NSArray *currentArray;

//@property (nonatomic, assign) NSUInteger selectIndex;

@property (nonatomic, strong) NSMutableArray *currentSelect;

@property (nonatomic, weak) SDFeedBackView *feedBackView;

@end

@implementation SDHelpAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"帮助与反馈"];
    [self initData];
    [self initContentView];
    
    [SDNotificationCenter addObserver:self
                             selector:@selector(removeFeedBackView)
                                 name:SDUserFeedBackSuccessNotification
                               object:nil];
}

- (void)initContentView {
    CGFloat statusHeight = SCREENWIDTH / 5 + 30 * SCALE;
    SDTopStatusView *statusView = [[SDTopStatusView alloc] init];
    statusView.frame = CGRectMake(0, 64, SCREENWIDTH, statusHeight);
    self.topStatusView = statusView;
    statusView.delegate = self;
    [self.view addSubview:statusView];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 64 + statusHeight, SCREENWIDTH, SCREENHEIGHT - 64 - statusHeight);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    
    [tableView registerClass:[SDQuestionCell class] forCellReuseIdentifier:@"SDQuestionCell"];
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    [self updateDataWithSDQuestionType:SDQuestionTypeNormal];
}

- (void)initData {
    if (self.questionDic == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HelpQuestion" ofType:@"plist"];
        NSDictionary *questionDic = [NSDictionary dictionaryWithContentsOfFile:path];
        self.questionDic = questionDic;
    }
}

- (void)updateDataWithSDQuestionType:(SDQuestionType)questionType {
    switch (questionType) {
        case SDQuestionTypeNormal:
            self.currentArray = self.questionDic[@"normal"];
            break;
        case SDQuestionTypeApply:
            self.currentArray = self.questionDic[@"apply"];
            break;
        case SDQuestionTypeRefundAndOverdue:
            self.currentArray = self.questionDic[@"refundAndOverdue"];
            break;
        case SDQuestionTypeUserPrivacy:
            self.currentArray = self.questionDic[@"userPrivacy"];
            break;
        default:
            break;
    }
    if (questionType != SDQuestionTypeUserFeedBack) {
        self.questionType = questionType;
        
        [self.tableView reloadData];
        //    self.selectIndex = UnselectCellIndex;
        self.currentSelect = [[NSMutableArray alloc] init];
    } else {
        [self addFeedBackView];
    }
}

- (void)addFeedBackView {
    UIButton *shadowView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    [shadowView addTarget:self
                   action:@selector(removeFeedBackView)
         forControlEvents:UIControlEventTouchUpInside];
    
    shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    //    shadowView.alpha = 0.7;
    
    //    self.shadowView = shadowView;
    [self.view addSubview:shadowView];
    
    SDFeedBackView *feedBackView = [[SDFeedBackView alloc] init];
    feedBackView.frame = CGRectMake(20 * SCALE, SCREENHEIGHT, SCREENWIDTH - 40 * SCALE, 600 * SCALE);
    self.feedBackView = feedBackView;
    [shadowView addSubview:feedBackView];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         feedBackView.y = 200 * SCALE;
                         
                     } completion:^(BOOL finished) {
                         feedBackView.delegate = self;
                         [feedBackView.cancelButton addTarget:self
                                                       action:@selector(removeFeedBackView)
                                             forControlEvents:UIControlEventTouchUpInside];
                         [feedBackView.okButton addTarget:self
                                                   action:@selector(uploadQuestion)
                                         forControlEvents:UIControlEventTouchUpInside];
                     }];
}

- (void)removeFeedBackView {
    //    [sender removeFromSuperview];
//    UIButton *backButton = (UIButton *)sender;
    [self.feedBackView.questionTextView resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        
        self.feedBackView.y = SCREENHEIGHT;
        
    } completion:^(BOOL finished) {
        [self.feedBackView.superview removeFromSuperview];
        [self.feedBackView removeFromSuperview];
    }];
}

- (void)uploadQuestion {
    NSArray *imageArray = self.feedBackView.imageArray;
    NSString *feedBackContent = self.feedBackView.questionTextView.text;
    [SDFeedBackModel commitUserFeedBackWith:imageArray
                            feedBackContent:feedBackContent
                       feedBackcontentTitle:@""];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    //    SDQuestionCell *cell = [SDQuestionCell cellWithTableView:tableView forIndexPath:indexPath];
    SDQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SDQuestionCell" forIndexPath:indexPath];
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configCell:(SDQuestionCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    //    cell.item = self.questionArray[indexPath.row];
    NSDictionary *modelDic = self.currentArray[indexPath.row];
    
    Boolean isSelect = [self.currentSelect containsObject:modelDic];
    
    if (isSelect) {
        [cell setQuestion:[NSString stringWithFormat:@"Q:%@", modelDic[@"Q"]]
                andAnswer:[NSString stringWithFormat:@"A:%@", modelDic[@"A"]]];
    } else {
        [cell setQuestion:[NSString stringWithFormat:@"Q:%@", modelDic[@"Q"]]
                andAnswer:@""];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"SDQuestionCell" configuration:^(SDQuestionCell *cell) {
        [self configCell:cell atIndexPath:indexPath];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20 * SCALE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20 * SCALE)];
    view.backgroundColor = FDColor(243, 245, 249);
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
    //    if (self.selectIndex == [indexPath row]) {
    //        self.selectIndex = UnselectCellIndex;
    //        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    //       ;
    //    } else {
    //        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    //        [reloadArray addObject:[NSIndexPath indexPathForRow:self.selectIndex inSection:0]];
    //        self.selectIndex = [indexPath row];
    //    }
    
    //    [self.currentSelect addObject:self.currentArray[indexPath.row]];
    NSDictionary *selectDic = self.currentArray[indexPath.row];
    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];

    if ([self.currentSelect containsObject:selectDic]) {
        [self.currentSelect removeObject:selectDic];
    } else {
//        [reloadArray addObjectsFromArray:self.currentSelect];
        if (self.currentSelect.count > 0) {
            NSDictionary *currentSelectDic = self.currentSelect[0];
            NSUInteger index = [self.currentArray indexOfObject:currentSelectDic];
            [reloadArray addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        }
        [self.currentSelect removeAllObjects];
        [self.currentSelect addObject:selectDic];
    }
    
    [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    [tableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma mark - topStatus delegate
- (void)didSelectAtIndex:(SDQuestionType)questionType {
    [self updateDataWithSDQuestionType:questionType];
}

#pragma mark - image pick

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type {
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
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.feedBackView addImage:image];
//    image = [self imageByScalingAndCroppingForSize:CGSizeMake(400*SCALE, 400*SCALE) image:image];
    
}
#pragma mark - imageView delegate
- (void)selectAtIndex:(NSUInteger)index {
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)dealloc {
    [SDNotificationCenter removeObserver:self];
}

@end
