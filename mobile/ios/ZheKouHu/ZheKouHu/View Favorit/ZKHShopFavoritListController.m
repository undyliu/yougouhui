//
//  ZKHShopFavoritListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopFavoritListController.h"
#import "ZKHProcessor+Favorit.h"
#import "ZKHProcessor+Shop.h"
#import "ZKHAppDelegate.h"
#import "ZKHContext.h"
#import "ZKHImageLoader.h"
#import "ZKHFavoritListCell.h"
#import "ZKHShopInfoController.h"

static NSString *CellIdentifier = @"FavoritListCell";

@implementation ZKHShopFavoritListController

- (id)init
{
    if (self = [super init]) {
        [[NSBundle mainBundle] loadNibNamed:@"ZKHBaseTableView" owner:self options:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHFavoritListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ApplicationDelegate.zkhProcessor shopFavorits:[ZKHContext getInstance].user.uuid completionHandler:^(NSMutableArray *favorits) {
        self.shopFavorits = favorits;
        [self.tableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shopFavorits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHFavoritListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHFavoritEntity *favorit = self.shopFavorits[indexPath.row];
    cell.cellTitleLabel.text = favorit.title;
    [ZKHImageLoader showImageForName:favorit.image imageView:cell.cellImageView];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHFavoritEntity *favorit = self.shopFavorits[indexPath.row];
    
    [ApplicationDelegate.zkhProcessor shop:favorit.code completionHandler:^(ZKHShopEntity *shop) {
        if (shop != nil) {
            ZKHShopInfoController *controller = [[ZKHShopInfoController alloc] init];
            controller.shop = shop;
            controller.readonly = true;
            [self.navigationController pushViewController:controller animated:YES];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
