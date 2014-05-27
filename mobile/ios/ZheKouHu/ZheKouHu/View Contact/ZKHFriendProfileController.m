//
//  ZKHFriendProfileController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-27.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHFriendProfileController.h"

@interface ZKHFriendProfileController ()

@end

@implementation ZKHFriendProfileController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.user.name;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
