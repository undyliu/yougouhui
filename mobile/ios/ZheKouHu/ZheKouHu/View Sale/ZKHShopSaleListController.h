//
//  ZKHShopSaleListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-4.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHPullRefreshTableViewController.h"
#import "ZKHEntity.h"

@interface ZKHShopSaleListController : ZKHPullRefreshTableViewController<UITableViewDelegate>

@property (strong, nonatomic) ZKHShopEntity *shop;

- (IBAction)publishSaleClick:(id)sender;

@end
