//
//  ZKHFreindShareListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHFriendShareListController.h"
#import "ZKHShareController.h"
#import "ZKHContext.h"
#import "ZKHProcessor+Share.h"
#import "ZKHAppDelegate.h"
#import "ZKHFriendShareListCell.h"
#import "ZKHShareListPicsController.h"
#import "NSString+Utils.h"
#import "ZKHImageLoader.h"
#import "ZKHFriendProfileController.h"
#import "TSActionSheet.h"
#import "ZKHEntity.h"
#import "NSString+Utils.h"

static NSString *CellIdentifier = @"FriendShareListCell";

@implementation ZKHFriendShareListController

- (id)init
{
    if (self = [super init]) {
        self.publishButtonVisible = true;
        offset = 0;
        sharePicControllers = [[NSMutableDictionary alloc] init];
        commentControllers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	if (!self.title) {
        self.title = @"购物圈";
    }
    
    self.pullTableView.dataSource = self;
    self.pullTableView.delegate = self;
    self.pullTableView.pullDelegate = self;
    
    if (self.publishButtonVisible && ![[ZKHContext getInstance] isAnonymousUserLogined]) {
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(shareClick:)];
        self.navigationItem.rightBarButtonItem = shareButton;
    }
    
    UINib *nib = [UINib nibWithNibName:@"ZKHFriendShareListCell" bundle:nil];
    [self.pullTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    //设置输入键盘
    faceToolBar = [[FaceToolBar alloc]initWithFrame:CGRectMake(0.0f,self.view.frame.size.height - toolBarHeight,self.view.frame.size.width,toolBarHeight) superView:self.view];
    faceToolBar.fToolBarDelegate = self;
    //[self.view addSubview:faceToolBar];
    
    //主视图的点击事件
    [self.pullTableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroupTap:)]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    faceToolBar.hidden = true;
    [faceToolBar resignFirstResponder];
    
    if (!self.shares || [self.shares count] == 0) {
        [ApplicationDelegate.zkhProcessor friendShares:[ZKHContext getInstance].user.uuid offset:offset completionHandler:^(NSMutableArray *sharesValue) {
            self.shares = sharesValue;
            [self.pullTableView reloadData];
        } errorHandler:^(NSError *error) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)backgroupTap:(id)sender
{
    [faceToolBar resignFirstResponder];
    faceToolBar.hidden = true;
}

- (void)shareClick:(id)sender
{
    ZKHShareController *controller = [[ZKHShareController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) friendProfileClick:(UITapGestureRecognizer *)sender
{
    int index = sender.view.tag;
    ZKHShareEntity *share  = self.shares[index];
    
    ZKHFriendProfileController *controller = [[ZKHFriendProfileController alloc] init];
    controller.user = share.publisher;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) commentImageClick:(UIButton *)sender forEvent:(UIEvent*)event
{
    currentProcessShareIndex = sender.tag;
    ZKHShareEntity *share  = self.shares[currentProcessShareIndex];
    
    if (self.doShopReply) {
        [self shopReplyClick:share];
        return;
    }
    
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:nil];
    [actionSheet addButtonWithTitle:@"评论" block:^{
        faceToolBar.hidden = false;
        [faceToolBar becomeFirstResponder];
    }];
    
    if ([[ZKHContext getInstance].user isEqual:share.publisher]) {
        [actionSheet addButtonWithTitle:@"删除" block:^{
            [ApplicationDelegate.zkhProcessor deleteShare:share completionHandler:^(Boolean result) {
                if (result) {
                    if (self.shareChangedDelegate) {
                        [self.shareChangedDelegate shareDeleted:share];
                    }
                    if (self.popWhenshareDeleted) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                    [self.shares removeObject:share];
                    [self.pullTableView reloadData];
                }
            } errorHandler:^(NSError *error) {
                
            }];
        }];
    }
    actionSheet.cornerRadius = 5;
        
    [actionSheet showWithTouch:event];
}

- (void)shopReplyClick:(ZKHShareEntity *)share
{
    if (share.shopReply) {
        return;
    }
    
    NSString *message;
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown){//竖屏
        message = @" \n ";
    }else{
        message = @" \n  \n ";
    }
    
    if (shopReplyAlertView) {
        shopReplyAlertView.message = message;
        gradeField.text = @"";
        replyContentField.text = @"";
    }else{
    shopReplyAlertView = [[ZKHShopReplyAlertView alloc] initWithTitle:@"请输入" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    UILabel *gradeLabel = [[UILabel alloc] init];
    gradeLabel.text = @"赠送积分:";
    gradeLabel.textAlignment = NSTextAlignmentRight;
    gradeLabel.textColor = [UIColor whiteColor];
    gradeLabel.font = [UIFont systemFontOfSize:15];
    gradeLabel.backgroundColor = [UIColor clearColor];
    
    gradeLabel.frame = CGRectMake(12, 42, 70, 25);
    
    [shopReplyAlertView addSubview:gradeLabel];
    
    gradeField = [[UITextField alloc]
                                initWithFrame:CGRectMake(90, 42, 180, 25)];
    [gradeField setBackgroundColor:[UIColor whiteColor]];
    [gradeField setKeyboardType:UIKeyboardTypeNumberPad];
    [gradeField setBorderStyle:UITextBorderStyleRoundedRect];
    gradeField.font = [UIFont systemFontOfSize:14];
    gradeField.placeholder = @"0~20积分";
    
    [shopReplyAlertView addSubview:gradeField];
    
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"反馈:";
    contentLabel.textAlignment = NSTextAlignmentRight;
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.backgroundColor = [UIColor clearColor];
    
    contentLabel.frame = CGRectMake(12, 70, 70, 25);
    
    [shopReplyAlertView addSubview:contentLabel];
    
    replyContentField = [[UITextField alloc]
                                  initWithFrame:CGRectMake(90, 72, 180, 25)];
    [replyContentField setBackgroundColor:[UIColor whiteColor]];
    [replyContentField setBorderStyle:UITextBorderStyleRoundedRect];
    replyContentField.font = [UIFont systemFontOfSize:14];
    
    [shopReplyAlertView addSubview:replyContentField];
    }
    [shopReplyAlertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1://确定
            [self shopReply];
            break;
            
        default:
            break;
    }
}

- (void)shopReply
{
    NSString *grade = gradeField.text;
    NSString *content = replyContentField.text;
    
    if ([NSString isNull:grade] || [NSString isNull:content]) {
        return;
    }
    
    [shopReplyAlertView dismissWithClickedButtonIndex:AlertViewButtonIndexSuccess animated:YES];
    
    ZKHShareEntity *share = self.shares[currentProcessShareIndex];
    ZKHShareShopReplyEntity *shopReply = [[ZKHShareShopReplyEntity alloc] init];
    shopReply.shopId = share.shop.uuid;
    shopReply.shareId = share.uuid;
    shopReply.content = content;
    shopReply.grade = [grade intValue];
    shopReply.replier = [ZKHContext getInstance].user.uuid;
    
    [ApplicationDelegate.zkhProcessor saveShareShopReply:shopReply completionHandler:^(Boolean result){
        if (result) {
            
            share.shopReply = shopReply;
            [self.pullTableView reloadData];
        }
    } errorHandler:^(NSError *error) {
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shares count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKHFriendShareListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    int row = indexPath.row;
    
    ZKHShareEntity *share = self.shares[row];
    
    ZKHUserEntity *publisher = share.publisher;
    if (publisher && publisher.photo && ![NSString isNull:publisher.photo.aliasName]) {
        [ZKHImageLoader showImageForName:publisher.photo.aliasName imageView:cell.userPhotoView];
    }
    
    cell.userPhotoView.tag = indexPath.row;
    cell.userPhotoView.userInteractionEnabled = true;
    [cell.userPhotoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(friendProfileClick:)]];
    
    cell.userNameLabel.text = publisher.name;
    
    cell.userNameLabel.tag = indexPath.row;
    cell.userNameLabel.userInteractionEnabled = true;
    [cell.userNameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(friendProfileClick:)]];
    
    if (self.showShopReplyInfo) {
        cell.replyStatusLabel.hidden = false;
        ZKHShareShopReplyEntity *reply =  share.shopReply;
        if (reply) {
            NSString *status = reply.status;
            if ([@"0" isEqualToString:status]) {
                cell.replyStatusLabel.text = @"商户反馈未生效";
            }else if ([@"1" isEqualToString:status]){
                cell.replyStatusLabel.text = @"商户反馈已生效";
            }else{
                cell.replyStatusLabel.text = @"商户尚未反馈";
            }
        }else{
            cell.replyStatusLabel.text = @"商户尚未反馈";
        }
    }else{
        cell.replyStatusLabel.hidden = true;
    }
    
    cell.showShopReplyInfo = self.showShopReplyInfo;
    
    ZKHShareListPicsController *picController = nil;
    if ([share.imageFiles count] > 0) {
        picController = sharePicControllers[indexPath];
        if (!picController) {
            picController = [[ZKHShareListPicsController alloc] init];
            [sharePicControllers setObject:picController forKey:indexPath];
            picController.share = share;
            picController.parentController = self;
        }
    }
    
    ZKHShareListCommentsController *commentsController = nil;
    if ([share.comments count] > 0) {
        commentsController = commentControllers[indexPath];
        if (!commentsController) {
            commentsController = [[ZKHShareListCommentsController alloc] init];
            commentsController.comments = share.comments;
            commentsController.commentDelegate = self;
            
            [commentControllers setObject:commentsController forKey:indexPath];
        }
    }
    [cell updateViews:share shareListPicController:picController commentsController:commentsController];
    cell.parentController = self;
    
    cell.commentImageView.tag = indexPath.row;
    [cell.commentImageView addTarget:self action:@selector(commentImageClick:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKHShareEntity *share = self.shares[indexPath.row];
    CGFloat height = [ZKHFriendShareListCell cellHeight:share];
    if (self.showShopReplyInfo) {
        height += [ZKHFriendShareListCell shopReplyHeight:share];
    }
    return height;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.pullTableView reloadData];
}

#pragma mark - FaceToolBarDelegate
-(void)sendTextAction:(NSString *)inputText{
    [faceToolBar resignFirstResponder];
    faceToolBar.hidden = true;
    
    ZKHShareEntity *share = self.shares[currentProcessShareIndex];
    
    ZKHShareCommentEntity *comment = [[ZKHShareCommentEntity alloc] init];
    comment.content = inputText;
    comment.shareId = share.uuid;
    comment.pulisher = [ZKHContext getInstance].user;
    
    [ApplicationDelegate.zkhProcessor addComment:comment completionHandler:^(Boolean result) {
        if (result) {
            [share.comments addObject:comment];
            [self.pullTableView reloadData];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

#pragma mark - ZKHCommentChangedDelegate
- (void)updateComments:(NSMutableArray *)comments
{
    [self.pullTableView reloadData];
}

@end


@implementation ZKHShopReplyAlertView

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    switch (buttonIndex) {
        case AlertViewButtonIndexSuccess:
            [super dismissWithClickedButtonIndex:AlertViewButtonIndexDismiss animated:animated];
            break;
        case AlertViewButtonIndexDismiss:
            [super dismissWithClickedButtonIndex:AlertViewButtonIndexDismiss animated:animated];
            break;
        default:
            break;
    }
    
}

@end