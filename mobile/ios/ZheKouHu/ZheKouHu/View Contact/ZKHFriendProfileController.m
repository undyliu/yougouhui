//
//  ZKHFriendProfileController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHFriendProfileController.h"
#import "NSString+Utils.h"
#import "ZKHImageLoader.h"
#import "ZKHContext.h"
#import "ZKHProcessor+User.h"
#import "ZKHAppDelegate.h"

@interface ZKHFriendProfileController ()

@end

@implementation ZKHFriendProfileController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.user.name;
    
    ZKHFileEntity *photo = self.user.photo;
    if (photo == nil || [NSString isNull:photo.aliasName]) {
        self.photoView.image = [UIImage imageNamed:@"default_user_photo.png"];
    }else{
        [ZKHImageLoader showImageForName:photo.aliasName imageView:self.photoView];
    }
    
    delFriendButton = [[UIBarButtonItem alloc] initWithTitle:@"删除朋友" style:UIBarButtonItemStyleBordered target:self action:@selector(delFriend:)];
    addFriendButton = [[UIBarButtonItem alloc] initWithTitle:@"加为朋友" style:UIBarButtonItemStyleBordered target:self action:@selector(addFriend:)];
    
    if ([[ZKHContext getInstance].user.friends containsObject:self.user]) {
        self.navigationItem.rightBarButtonItem = delFriendButton;
    }else{
        self.navigationItem.rightBarButtonItem = addFriendButton;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)addFriend:(id)sender
{
    ZKHUserEntity *currentUser = [ZKHContext getInstance].user;
    [ApplicationDelegate.zkhProcessor addFriend:currentUser uFriend:self.user completionHander:^(Boolean result) {
        if (result) {
            self.navigationItem.rightBarButtonItem = delFriendButton;
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)delFriend:(id)sender
{
    ZKHUserEntity *currentUser = [ZKHContext getInstance].user;
    [ApplicationDelegate.zkhProcessor deleteFriend:currentUser.uuid friendId:self.user.uuid completionHander:^(Boolean result) {
        if (result) {
            [currentUser.friends removeObject:self.user];
            self.navigationItem.rightBarButtonItem = addFriendButton;
            
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

@end
