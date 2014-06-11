//
//  ZKHMyShareListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHPullRefreshTableViewController.h"

@interface ZKHMyShareListController : ZKHPullRefreshTableViewController<UITableViewDelegate>
{
    NSMutableArray *shareCountList;
    int offset;
}
@end
