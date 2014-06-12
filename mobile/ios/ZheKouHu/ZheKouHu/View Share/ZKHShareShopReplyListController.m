//
//  ZKHShareShopReplyListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShareShopReplyListController.h"
#import "ZKHShareShopReplyCell.h"
#import "ZKHImageLoader.h"
#import "NSString+Utils.h"
#import "ZKHProcessor+Share.h"
#import "ZKHAppDelegate.h"
#import "ZKHFriendShareListController.h"

static NSString *CellIdentifier = @"ShareShopReplyCell";

@implementation ZKHShareShopReplyListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"分享互动";
    
    self.pullTableView.dataSource = self;
    self.pullTableView.pullDelegate = self;
    self.pullTableView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHShareShopReplyCell" bundle:nil];
    [self.pullTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ApplicationDelegate.zkhProcessor sharesByShop:nil shopId:self.shop.uuid offset:offset completionHandler:^(NSMutableArray *shareList) {
        shares = shareList;
        [self.pullTableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    ZKHShareShopReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    int row = indexPath.row;
    
    ZKHShareEntity *share = shares[row];
    
    ZKHUserEntity *publisher = share.publisher;
    ZKHFileEntity *photo = publisher.photo;
    if (!photo || [NSString isNull:photo.aliasName]) {
        cell.photoView.image = [UIImage imageNamed:@"default_user_photo.png"];
    }else{
        [ZKHImageLoader showImageForName:photo.aliasName imageView:cell.photoView];
    }
    cell.userNameLabel.text = publisher.name;
    
    ZKHShareReplyEntity *reply = share.shopReply;
    if (reply) {
        NSString *status = reply.status;
        if ([@"1" isEqualToString:status]) {
            cell.statusLabel.text = @"反馈未生效";
        }else if ([@"2" isEqualToString:status]){
            cell.statusLabel.text = @"反馈已生效";
        }else{
            cell.statusLabel.text = @"尚未反馈";
        }
    }else{
        cell.statusLabel.text = @"尚未反馈";
    }
    
    [cell updateViews:share];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZKHShareShopReplyCell cellHeight:shares[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHShareEntity *share = shares[indexPath.row];
    
    ZKHFriendShareListController *controller = [[ZKHFriendShareListController alloc] init];
    controller.shares = [[NSMutableArray alloc] initWithObjects:share, nil];
    controller.popWhenshareDeleted = true;
    controller.publishButtonVisible = false;
    controller.title = @"商户反馈";
    controller.doShopReply = true;
    controller.showShopReplyInfo = true;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.pullTableView reloadData];
}


@end
