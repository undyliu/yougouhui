//
//  ZKHChannelSaleMainController.m
//

//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChannelSaleMainController.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+Sale.h"
#import "ZKHProcessor+Sync.h"
#import "ZKHData.h"
#import "NSDate+Utils.h"
#import "ZKHChannelSaleListCell.h"
#import "ZKHImageLoader.h"
#import "ZKHViewUtils.h"
#import "ZKHSaleDetailController.h"

static NSString *CellIdentifier = @"ChannelSaleListCell";

@implementation ZKHChannelSaleMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.saleListView.pullDelegate = self;
    self.saleListView.dataSource = self;
    self.saleListView.delegate = self;
        
    UINib *nib = [UINib nibWithNibName:@"ZKHChannelSaleListCell" bundle:nil];
    [self.saleListView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.saleListView];
    
    [ApplicationDelegate.zkhProcessor channels:nil completionHandler:^(NSMutableArray *channels) {
        self.channels = channels;
        [self initializeToolbarItems];
        [self updateToolbarItems:0];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void) initializeToolbarItems
{
    int index = 0;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (ZKHChannelEntity *channel in self.channels) {
        CGRect frame_1= CGRectMake(0, 0, 50, 30);
        UIButton* channelButton= [[UIButton alloc] init];
        channelButton.frame = frame_1;
        [channelButton setBackgroundColor:[UIColor clearColor]];
        [channelButton setTitle:channel.name forState:UIControlStateNormal];
        [channelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        channelButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [channelButton addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
        channelButton.tag = index++;
        
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:channelButton];
        [items addObject:item];
    }
    self.channelBar.items = items;
}

- (void) updateToolbarItems:(int)activedItemTag
{
    for (UIBarButtonItem *item in self.channelBar.items) {
        UIButton* channelButton = (UIButton*)[item customView];
        int tag = channelButton.tag;
        if (tag == activedItemTag) {
            [channelButton setBackgroundColor:[UIColor darkGrayColor]];
            //[channelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            //channelButton.titleLabel.font=[UIFont systemFontOfSize:16];
        }else{
            [channelButton setBackgroundColor:[UIColor clearColor]];
            //[channelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //channelButton.titleLabel.font=[UIFont systemFontOfSize:14];
        }
    }
    
    if (activedItemTag < [self.channels count]) {
        ZKHSyncEntity *sync = [ApplicationDelegate.zkhProcessor getSyncEntity: SALE_TABLE itemId:@"*"];
        if (sync == nil) {
            sync = [[ZKHSyncEntity alloc] init];
            NSString *currentTime = [NSDate currentTimeString];
            sync.updateTime = @"-1";
            sync.uuid = [currentTime copy];
            sync.tableName = SALE_TABLE;
            sync.itemId = @"*";
        }
        
        ZKHChannelEntity *channel = self.channels[activedItemTag];
        [ApplicationDelegate.zkhProcessor salesForChannel:channel.uuid updateTime:sync completionHandler:^(NSMutableArray *sales) {
            saleList = sales;
            [self.saleListView reloadData];
            
        } errorHandler:^(NSError *error) {
            
        }];
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)changeChannel:(UIBarButtonItem *)sender {
    [self updateToolbarItems:sender.tag];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [saleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKHChannelSaleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHSaleEntity *sale = saleList[indexPath.row];
    cell.titelLabel.text = sale.title;
    
    cell.contentLabel.text = sale.content;
    cell.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.contentLabel.numberOfLines = 0;
    
    cell.shopLabel.text = sale.shop.name;
    
    NSString *hitCount = [NSString stringWithFormat:@"共%@次浏览 %@条评论", sale.visitCount, sale.discussCount];
    cell.visitCountLabel.text = hitCount;
    
    cell.statusLabel.hidden = true;//TODO:
    
    [ZKHImageLoader showImageForName:sale.img imageView:cell.saleImageView];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHSaleDetailController *controller = [[ZKHSaleDetailController alloc] init];
    controller.sale = saleList[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

#pragma mark - Refresh and load more methods

- (void) refreshTable
{
    self.saleListView.pullLastRefreshDate = [NSDate date];
    self.saleListView.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    self.saleListView.pullTableIsLoadingMore = NO;
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
