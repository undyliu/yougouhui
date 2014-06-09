//
//  ZKHFreindShareListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHPullRefreshTableViewController.h"

@interface ZKHFriendShareListController : ZKHPullRefreshTableViewController<UITableViewDelegate>
{
    NSMutableArray *shares;
    NSMutableDictionary *sharePicControllers;
    NSMutableDictionary *commentControllers;
    int offset;
}
- (IBAction)shareClick:(id)sender;

@end
