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

static NSString *CellIdentifier = @"ChannelSaleListCell";

@implementation ZKHChannelSaleMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.saleListView.dataSource = self;
    self.saleListView.delegate = self;
        
    UINib *nib = [UINib nibWithNibName:@"ZKHChannelSaleListCell" bundle:nil];
    [self.saleListView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ApplicationDelegate.zkhProcessor channels:nil completionHandler:^(NSMutableArray *channels) {
        self.channels = channels;
        [self updateToolbarItems:0];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void) updateToolbarItems:(int)activedItemTag
{
    NSArray *items = self.channelBar.items;
    for (int i = 0; i < [items count]; i++) {
        UIBarButtonItem *item = items[i];
        if (i < [self.channels count]) {
            item.title = ((ZKHChannelEntity *)self.channels[i]).name;
        }else{
            [item setStyle:UIBarButtonItemStylePlain];
            item.title = @"";
            item.enabled = FALSE;
        }
        if (i == activedItemTag) {
            [item setStyle:UIBarButtonItemStyleDone];
        }else{
            [item setStyle:UIBarButtonItemStylePlain];
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
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

@end
