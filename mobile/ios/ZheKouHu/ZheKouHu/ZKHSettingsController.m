//
//  ZKHSettingsController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHSettingsController.h"
#import "ZKHEntity.h"
#import "ZKHAppDelegate.h"
#import "ZKHContext.h"
#import "ZKHProcessor+User.h"

#define SETTING_CODE_LOGIN @"login"
#define SETTING_CODE_RADAR @"radar"
#define SETTING_CODE_LOGOUT @"logout"

static NSString *CellIdentifier = @"Cell";

@implementation ZKHSettingsController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    [ApplicationDelegate.zkhProcessor settings:^(NSMutableArray *settings) {
        settingItems = settings;
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
    return [settingItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHSettingEntity *setting = settingItems[indexPath.row];
    cell.textLabel.text = setting.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHSettingEntity *setting = settingItems[indexPath.row];
    if ([SETTING_CODE_LOGOUT isEqualToString:setting.code]) {
        ZKHContext *context = [ZKHContext getInstance];
        
        [ApplicationDelegate.zkhProcessor deleteLoginEnv:context.user.phone];
        
        context.user = nil;
        context.sessionId = nil;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
