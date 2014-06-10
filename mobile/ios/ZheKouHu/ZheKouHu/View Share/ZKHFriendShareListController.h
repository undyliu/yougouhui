//
//  ZKHFreindShareListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHPullRefreshTableViewController.h"
#import "FaceToolBar.h"
#import "ZKHShareListCommentsController.h"

@interface ZKHFriendShareListController : ZKHPullRefreshTableViewController<UITableViewDelegate, FaceToolBarDelegate, ZKHCommentChangedDelegate>
{
    NSMutableArray *shares;
    NSMutableDictionary *sharePicControllers;
    NSMutableDictionary *commentControllers;
    int offset;
    
    FaceToolBar *faceToolBar;
    int currentProcessShareIndex;
}

- (IBAction)shareClick:(id)sender;

@end
