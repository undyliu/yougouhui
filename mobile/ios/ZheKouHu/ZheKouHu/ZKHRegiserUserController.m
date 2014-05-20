//
//  ZKHRegiserUserController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRegiserUserController.h"

@interface ZKHRegiserUserController ()

@end

@implementation ZKHRegiserUserController

- (id)init
{
    if (self = [super init]) {
        self.title = NSLocalizedString(@"LABEL_REGISTER_USER", @"register user");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
