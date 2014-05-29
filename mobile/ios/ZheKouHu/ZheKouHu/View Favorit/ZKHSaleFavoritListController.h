//
//  ZKHSaleFavoritListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHPullRefreshTableViewController.h"

@interface ZKHSaleFavoritListController : ZKHPullRefreshTableViewController<UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *saleFavorits;

@end
