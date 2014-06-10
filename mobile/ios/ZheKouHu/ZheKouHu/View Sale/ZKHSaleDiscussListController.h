//
//  ZKHSaleDiscussListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-29.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "ZKHSaleValueChangedDelegate.h"

@interface ZKHSaleDiscussListController : UIViewController<UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate>

@property (strong, nonatomic) NSMutableArray *discusses;
@property (strong, nonatomic) PullTableView *tableView;
@property (strong, nonatomic) id<ZKHSaleValueChangedDelegate> saleDelegate;

- (void) registerTableViewCell;
@end
