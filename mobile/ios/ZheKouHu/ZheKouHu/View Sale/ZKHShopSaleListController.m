//
//  ZKHShopSaleListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-4.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopSaleListController.h"
#import "ZKHSalePublishController.h"
#import "NSDate+Utils.h"
#import "ZKHProcessor+Sale.h"
#import "ZKHAppDelegate.h"
#import "ZKHImageLoader.h"
#import "ZKHShopSaleListCell.h"
#import "ZKHContext.h"

static NSString *CellIdentifier = @"ShopSaleListCell";

@implementation ZKHShopSaleListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        offset = 0;
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
    
    UINib *nib = [UINib nibWithNibName:@"ZKHShopSaleListCell" bundle:nil];
    [self.pullTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    Boolean shopLogined = [ZKHContext getInstance].shopLogined;
    if (shopLogined) {
        UIBarButtonItem *publishButton = [[UIBarButtonItem alloc] initWithTitle:@"发布新活动" style:UIBarButtonItemStyleBordered target:self action:@selector(publishSaleClick:)];
        self.navigationItem.rightBarButtonItem = publishButton;
    }
    
    [ApplicationDelegate.zkhProcessor salesGroupByPublishDate:nil shopId:self.shop.uuid offset:offset completionHandler:^(NSMutableArray *sales) {
        saleCountList = sales;
        [self.pullTableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.pullTableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [saleCountList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKHShopSaleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHDateIndexedEntity *entity = saleCountList[indexPath.row];
    cell.publishDateLabel.text = [entity.date toddMMString];
    cell.countLabel.text = [NSString stringWithFormat:@"%d笔", entity.count];
    
    cell.shop = self.shop;
    cell.saleList = entity.items;
    cell.parentController = self;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     ZKHDateIndexedEntity *entity = saleCountList[indexPath.row];
    return [ZKHShopSaleListCell cellHeight:entity.items];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.pullTableView reloadData];
}
@end
