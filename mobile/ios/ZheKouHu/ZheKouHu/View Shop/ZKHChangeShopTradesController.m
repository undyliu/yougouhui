//
//  ZKHShopTradesController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChangeShopTradesController.h"
#import "ZKHSwitchCell.h"
#import "ZKHProcessor.h"
#import "ZKHAppDelegate.h"

static NSString *switchCellIdentifier = @"SwitchCell";

@implementation ZKHChangeShopTradesController

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
    
    self.title = @"店铺-修改主营业务";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHSwitchCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:switchCellIdentifier];
    
    [ApplicationDelegate.zkhProcessor trades:^(NSMutableArray *trades) {
        _trades = trades;
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
    return [_trades count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchCellIdentifier];
    ZKHTradeEntity *trade = _trades[indexPath.row];
    cell.cellLabel.text = trade.name;
    
    NSMutableArray *shopTrades = self.shop.trades;
    for (ZKHShopTradeEntity *shopTrade in shopTrades) {
        if ([trade isEqual:shopTrade.trade]) {
            [cell.cellSwitch setOn:TRUE];
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
