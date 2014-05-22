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

static NSString *CellIdentifier = @"ChannelSaleListCell";

@implementation ZKHChannelSaleMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.saleListController == nil) {
        self.saleListController = [[ZKHChannelSaleListController alloc] init];
        self.saleListView.dataSource = self.saleListController;
        self.saleListView.delegate = self.saleListController;
        self.saleListController.tableView = self.saleListView ;
        
        UINib *nib = [UINib nibWithNibName:@"ZKHChannelSaleListCell" bundle:nil];
        [self.saleListController.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        //[self setExtraCellLineHidden:self.saleListView];
    }
    
    [ApplicationDelegate.zkhProcessor channels:nil completionHandler:^(NSMutableArray *channels) {
        self.channels = channels;
        [self updateToolbarItems:0];
    } errorHandler:^(NSError *error) {
        
    }];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
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
            self.saleListController.saleList = sales;
            [self.saleListController.tableView reloadData];
            
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


@end
