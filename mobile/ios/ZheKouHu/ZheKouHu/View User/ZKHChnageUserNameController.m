//
//  ZKHChnageUserNameController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChnageUserNameController.h"
#import "ZKHChangeTextView.h"
#import "ZKHContext.h"
#import "ZKHEntity.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+User.h"

@implementation ZKHChnageUserNameController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"修改昵称";
}

- (NSString *)getOriginalTextFieldValue
{
    return [ZKHContext getInstance].user.name;
}

- (void)doSave:(NSString *)newValue
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    [ApplicationDelegate.zkhProcessor changeName:user newName:newValue completionHandler:^(Boolean result) {
        if (result) {
            user.name = newValue;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

@end
