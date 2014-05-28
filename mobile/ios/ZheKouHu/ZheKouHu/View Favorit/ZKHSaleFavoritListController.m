//
//  ZKHSaleFavoritListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-28.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHSaleFavoritListController.h"
#import "ZKHProcessor+Favorit.h"
#import "ZKHAppDelegate.h"
#import "ZKHContext.h"
#import "ZKHEntity.h"
#import "ZKHImageLoader.h"
#import "ZKHFavoritListCell.h"

static NSString *CellIdentifier = @"FavoritListCell";
@implementation ZKHSaleFavoritListController

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
    
    [ApplicationDelegate.zkhProcessor saleFavorits:[ZKHContext getInstance].user.uuid completionHandler:^(NSMutableArray *favorits) {
        self.saleFavorits = favorits;
        [self.tableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
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

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
