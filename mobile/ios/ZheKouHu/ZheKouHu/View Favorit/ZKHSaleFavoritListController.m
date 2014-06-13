//
//  ZKHSaleFavoritListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHSaleFavoritListController.h"
#import "ZKHProcessor+Favorit.h"
#import "ZKHProcessor+Sale.h"
#import "ZKHAppDelegate.h"
#import "ZKHContext.h"
#import "ZKHEntity.h"
#import "ZKHImageLoader.h"
#import "ZKHFavoritListCell.h"
#import "ZKHSaleDetailController.h"

static NSString *CellIdentifier = @"FavoritListCell";
@implementation ZKHSaleFavoritListController

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pullTableView.pullDelegate = self;
    self.pullTableView.dataSource = self;
    self.pullTableView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHFavoritListCell" bundle:nil];
    [self.pullTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ApplicationDelegate.zkhProcessor saleFavorits:[ZKHContext getInstance].user.uuid completionHandler:^(NSMutableArray *favorits) {
        self.saleFavorits = favorits;
        [self.pullTableView reloadData];
    } ];
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
    return [self.saleFavorits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHFavoritListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHFavoritEntity *favorit = self.saleFavorits[indexPath.row];
    cell.cellTitleLabel.text = favorit.title;
    [ZKHImageLoader showImageForName:favorit.image imageView:cell.cellImageView];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHFavoritEntity *favorit = self.saleFavorits[indexPath.row];
    [ApplicationDelegate.zkhProcessor sale:favorit.code userId:[ZKHContext getInstance].user.uuid completionHandler:^(ZKHSaleEntity *sale) {
        if (sale) {
            ZKHSaleDetailController *controller = [[ZKHSaleDetailController alloc] init];
            controller.sale = sale;
            [self.navigationController pushViewController:controller animated:YES];
        }
    } ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

@end
