//
//  ZKHSaleDiscussListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-29.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHSaleDiscussListController.h"
#import "ZKHSaleDiscussListCell.h"
#import "ZKHEntity.h"
#import "ZKHContext.h"
#import "ZKHProcessor+Sale.h"
#import "ZKHAppDelegate.h"

static NSString *SaleDiscussCellIdentifier = @"SaleDiscussListCell";

@implementation ZKHSaleDiscussListController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)registerTableViewCell
{
    UINib *nib = [UINib nibWithNibName:@"ZKHSaleDiscussListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:SaleDiscussCellIdentifier];
}

- (void)deleteDidcuss:(UITapGestureRecognizer *)tap
{
    int index = tap.view.tag;
    ZKHSaleDiscussEntity *discuss = self.discusses[index];
    [ApplicationDelegate.zkhProcessor deleteDiscuss:discuss completionHandler:^(Boolean result) {
        if (result) {
            if (self.saleDelegate) {
                [self.saleDelegate updateSale:discuss.sale];
            }
            [self.discusses removeObject:discuss];
            [self.tableView reloadData];
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.discusses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKHSaleDiscussListCell *cell = [tableView dequeueReusableCellWithIdentifier:SaleDiscussCellIdentifier forIndexPath:indexPath];
    
    ZKHSaleDiscussEntity *dis = self.discusses[indexPath.row];
    ZKHUserEntity *publisher = dis.publisher;
    NSString *content = [NSString stringWithFormat:@"%@ 回复:%@", publisher.name, dis.content];
    cell.contentLabel.text = content;
    
    cell.delelteImageView.tag = indexPath.row;
    if ([publisher isEqual:[ZKHContext getInstance].user]) {
        cell.delelteImageView.hidden = false;
        
        cell.delelteImageView.userInteractionEnabled = true;
        [cell.delelteImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteDidcuss:)]];
    }else{
        cell.delelteImageView.hidden = true;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

#pragma mark - Refresh and load more methods

- (void) refreshTable
{
    self.tableView.pullLastRefreshDate = [NSDate date];
    self.tableView.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    self.tableView.pullTableIsLoadingMore = NO;
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}

@end
