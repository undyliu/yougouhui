//
//  ZKHShopSaleListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-4.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopSaleListController.h"
#import "ZKHSalePublishController.h"

@implementation ZKHShopSaleListController

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
	
    self.title = @"商铺-促销活动";
    
    self.pullTableView.delegate = self;
    self.pullTableView.dataSource = self;
    self.pullTableView.pullDelegate = self;
    
    UIBarButtonItem *publishButton = [[UIBarButtonItem alloc] initWithTitle:@"发布新活动" style:UIBarButtonItemStyleBordered target:self action:@selector(publishSaleClick:)];
    self.navigationItem.rightBarButtonItem = publishButton;
}

- (void)publishSaleClick:(id)sender
{
    ZKHSalePublishController *controller = [[ZKHSalePublishController alloc] init];
    controller.shop = self.shop;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
