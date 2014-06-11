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
#import "ZKHShareChangedDelegate.h"

@interface ZKHFriendShareListController : ZKHPullRefreshTableViewController<UITableViewDelegate, FaceToolBarDelegate, ZKHCommentChangedDelegate>
{
    NSMutableDictionary *sharePicControllers;
    NSMutableDictionary *commentControllers;
    int offset;
    
    FaceToolBar *faceToolBar;
    int currentProcessShareIndex;
}

@property (nonatomic) Boolean publishButtonVisible;
@property (nonatomic) Boolean popWhenshareDeleted;
@property (strong, nonatomic) id<ZKHShareChangedDelegate> shareChangedDelegate;

@property (strong, nonatomic) NSMutableArray *shares;
- (IBAction)shareClick:(id)sender;

@end
