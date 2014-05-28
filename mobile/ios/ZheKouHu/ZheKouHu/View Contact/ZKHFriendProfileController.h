//
//  ZKHFriendProfileController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"

@interface ZKHFriendProfileController : UIViewController
{
    UIBarButtonItem *addFriendButton;
    UIBarButtonItem *delFriendButton;
}
@property (copy, nonatomic) ZKHUserEntity *user;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

- (IBAction)addFriend:(id)sender;
- (IBAction)delFriend:(id)sender;

@end
