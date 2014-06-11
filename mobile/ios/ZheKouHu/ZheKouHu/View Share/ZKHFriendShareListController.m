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
	
    self.title = @"购物圈";
    
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
    return [ZKHFriendShareListCell cellHeight:self.shares[indexPath.row]];
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
