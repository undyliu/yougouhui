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
#import "ZKHShareListCommentsController.h"
#import "NSString+Utils.h"
#import "ZKHImageLoader.h"
#import "ZKHFriendProfileController.h"

static NSString *CellIdentifier = @"FriendShareListCell";

@implementation ZKHFriendShareListController

- (id)init
{
    if (self = [super init]) {
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
    
    if (![[ZKHContext getInstance] isAnonymousUserLogined]) {
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(shareClick:)];
        self.navigationItem.rightBarButtonItem = shareButton;
    }
    
    UINib *nib = [UINib nibWithNibName:@"ZKHFriendShareListCell" bundle:nil];
    [self.pullTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ApplicationDelegate.zkhProcessor friendShares:[ZKHContext getInstance].user.uuid offset:offset completionHandler:^(NSMutableArray *sharesValue) {
        shares = sharesValue;
        [self.pullTableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)shareClick:(id)sender
{
    ZKHShareController *controller = [[ZKHShareController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) friendProfileClick:(UITapGestureRecognizer *)sender
{
    int index = sender.view.tag;
    ZKHShareEntity *share  = shares[index];
    
    ZKHFriendProfileController *controller = [[ZKHFriendProfileController alloc] init];
    controller.user = share.publisher;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shares count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKHFriendShareListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    int row = indexPath.row;
    ZKHShareEntity *share = shares[row];
    
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
            
            [commentControllers setObject:commentsController forKey:indexPath];
        }
    }
    [cell updateViews:share shareListPicController:picController commentsController:commentsController];
    cell.parentController = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZKHFriendShareListCell cellHeight:shares[indexPath.row]];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.pullTableView reloadData];
}

@end
