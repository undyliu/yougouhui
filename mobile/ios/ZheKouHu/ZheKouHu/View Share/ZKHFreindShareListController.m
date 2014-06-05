//
//  ZKHFreindShareListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHFreindShareListController.h"
#import "ZKHShareController.h"
#import "ZKHContext.h"

@implementation ZKHFreindShareListController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"购物圈";
    
    self.pullTableView.dataSource = self;
    self.pullTableView.pullDelegate = self;
    
    if (![[ZKHContext getInstance] isAnonymousUserLogined]) {
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(shareClick:)];
        self.navigationItem.rightBarButtonItem = shareButton;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)shareClick:(id)sender
{
    ZKHShareController *controller = [[ZKHShareController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
