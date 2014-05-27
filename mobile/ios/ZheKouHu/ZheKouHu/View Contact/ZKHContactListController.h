//
//  ZKHContactListController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHContactListController : UITableViewController
{
    NSArray *_indexKeys;
    NSMutableDictionary *_friends;
}

- (IBAction)addFriendClick:(id)sender;

@end
