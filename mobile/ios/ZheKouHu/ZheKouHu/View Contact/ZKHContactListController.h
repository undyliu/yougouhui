//
//  ZKHContactListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHContactListActionDelegate.h"

@interface ZKHContactListController : UITableViewController<UIActionSheetDelegate>
{
    NSArray *_indexKeys;
    NSMutableDictionary *_friends;
    UIToolbar *navToolBar;
    NSMutableArray *selectedIndexes;
}

@property (nonatomic) Boolean readonly;
@property (strong, nonatomic) NSMutableArray *selectedUsers;
@property (strong,nonatomic) id <ZKHContactListActionDelegate> actionDelegate;

- (IBAction)addFriendClick:(id)sender;

- (IBAction)addButtonClick:(id)sender;
- (IBAction)confButtonClick:(id)sender;
- (IBAction)cellSwitchChanged:(id)sender;

@end
