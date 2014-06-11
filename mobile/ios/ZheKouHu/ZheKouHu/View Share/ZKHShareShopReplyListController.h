//
//  ZKHShareShopReplyListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"
#import "ZKHPullRefreshTableViewController.h"

@interface ZKHShareShopReplyListController : ZKHPullRefreshTableViewController<UITableViewDelegate>
{
    NSMutableArray *shares;
    int offset;
}

@property (strong, nonatomic) ZKHShopEntity *shop;

@end
