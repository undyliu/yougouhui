//
//  ZKHChannelSaleMainController.m
//

//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChannelSaleMainController.h"
#import "ZKHAppDelegate.h"

@implementation ZKHChannelSaleMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.saleListController == nil) {
        self.saleListController = [[ZKHChannelSaleListController alloc] init];
        self.saleListView.dataSource = self.saleListController;
        self.saleListView.delegate = self.saleListController;
    }
    
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
        self.saleListController.channel = self.channels[activedItemTag];
        [self.saleListController.tableView reloadData];
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
