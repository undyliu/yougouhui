//
//  ZKHChooseShopController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChooseShopController.h"
#import "ZKHContactListCell.h"
#import "NSString+Utils.h"
#import "ZKHProcessor+Shop.h"
#import "ZKHAppDelegate.h"
#import "ZKHImageLoader.h"
#import "ZKHShopInfoController.h"
#import "ZKHViewUtils.h"

static NSString *CellIdentifier = @"ContactListCell";

@implementation ZKHChooseShopController

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
    
    self.resultView.delegate = self;
    self.resultView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHContactListCell" bundle:nil];
    [self.resultView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    UIBarButtonItem *confButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(confButtonClick:)];
    self.navigationItem.rightBarButtonItem = confButton;
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.resultView];
}

- (void)confButtonClick:(id)sender
{
    if (!selectedIndexPath || !self.actionDelegate) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self.actionDelegate confirm:result[selectedIndexPath.row] viewController:self];
}

- (void)cellSwitchChanged:(id)sender
{
    ZKHSwitch *cellSwith = sender;
    if ([cellSwith isOn]) {
        selectedIndexPath = cellSwith.indexPath;
    }else{
        selectedIndexPath = nil;
    }
    
    [self.resultView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)search:(id)sender {
    [self.searchWordField resignFirstResponder];
    
    NSString *searchWord = self.searchWordField.text;
    if ([NSString isNull:searchWord]) {
        return;
    }
    
    [ApplicationDelegate.zkhProcessor searchShop:searchWord completionHandler:^(NSMutableArray *shops) {
        result = shops;
        [self.resultView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ZKHShopEntity *shop = result[indexPath.row];
    [ZKHImageLoader showImageForName:shop.shopImg imageView:cell.cellImageView];
    cell.cellLabel.text = shop.name;
    
    cell.cellSwitch.indexPath = indexPath;
    [cell.cellSwitch addTarget:self action:@selector(cellSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    if ([indexPath isEqual:selectedIndexPath]) {
        [cell.cellSwitch setOn:true];
    }else{
        [cell.cellSwitch setOn:false];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHShopEntity *shop = result[indexPath.row];
    [ApplicationDelegate.zkhProcessor shop:shop.uuid completionHandler:^(ZKHShopEntity *shop) {
        if (shop) {
            ZKHShopInfoController *controller = [[ZKHShopInfoController alloc] init];
            controller.shop = shop;
            [self.navigationController pushViewController:controller animated:YES];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}
@end
