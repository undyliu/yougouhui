//
//  ZKHPullRefreshTableViewController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface ZKHPullRefreshTableViewController : UIViewController <UITableViewDataSource, PullTableViewDelegate>
@property (strong, nonatomic) IBOutlet PullTableView *pullTableView;

@end
