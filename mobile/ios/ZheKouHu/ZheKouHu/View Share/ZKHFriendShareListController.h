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

@interface ZKHFriendShareListController : ZKHPullRefreshTableViewController<UITableViewDelegate, FaceToolBarDelegate, ZKHCommentChangedDelegate, UIAlertViewDelegate>
{
    NSMutableDictionary *sharePicControllers;
    NSMutableDictionary *commentControllers;
    int offset;
    
    FaceToolBar *faceToolBar;
    int currentProcessShareIndex;
    
    UIAlertView *shopReplyAlertView;
    UITextField *gradeField;
    UITextField *replyContentField;
}

@property (nonatomic) Boolean showShopReplyInfo;
@property (nonatomic) Boolean doShopReply;
@property (nonatomic) Boolean publishButtonVisible;
@property (nonatomic) Boolean popWhenshareDeleted;
@property (strong, nonatomic) id<ZKHShareChangedDelegate> shareChangedDelegate;

@property (strong, nonatomic) NSMutableArray *shares;
- (IBAction)shareClick:(id)sender;

@end

typedef enum {
    AlertViewButtonIndexDismiss = 0,
    AlertViewButtonIndexSuccess = 10
} AlertViewButtonIndex;

@interface ZKHShopReplyAlertView : UIAlertView

@end
