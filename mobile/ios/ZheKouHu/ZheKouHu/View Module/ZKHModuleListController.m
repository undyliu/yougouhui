//
//  ZKHModuleListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHModuleListController.h"
#import "ZKHEntity.h"
#import "ZKHSettingsController.h"
#import "ZKHAppDelegate.h"
#import "ZKHContext.h"
#import "ZKHShopLoginController.h"
#import "ZKHRaderMainController.h"
#import "ZKHLoginController.h"
#import "ZKHRegiserUserController.h"
#import "ZKHContactListController.h"
#import "ZKHMyFavoritController.h"
#import "ZKHViewUtils.h"
#import "ZKHFriendShareListController.h"
#import "ZKHMyShareListController.h"

#define kModuleFriends @"friends"
#define kModuleRadar @"radar"

#define kModuleSettings @"settings"
#define kModuleContactList @"contact_list"
#define kModuleMyFavorite @"my_favorite"
#define kModuleMyShare @"my_share"
#define kModuleMyShop @"my_shop"
#define kModuleMyGrade @"my_grade"
#define kModuleMyMessage @"my_message"

#define anonymousAccessModules @[kModuleRadar, kModuleMyShop]

static NSString *CellIdentifier = @"ModuleCellIdentifier";

@interface ZKHModuleListController ()

@end

@implementation ZKHModuleListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ZKHModuleListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.tableView];
    
    NSString *type = [self getModuleType];
    if(type != nil){
        [ApplicationDelegate.zkhProcessor modulesForType:type
                               completionHandler:^(NSMutableArray *modules) {
                                   self.modules = modules;
                                   [self.tableView reloadData];
                               }
                                    errorHandler:^(NSError *error) {
                                        
                                    }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (NSString *)getModuleType
{
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear:");
    [self.navigationController viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modules count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHModuleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ZKHModuleEntity *module = self.modules[indexPath.row];
    cell.nameLabel.text = module.name;
    if (module.icon != nil && [module.icon length] > 0) {
        cell.image.image = [UIImage imageNamed:module.icon];
    }else{
        cell.image.image = [UIImage imageNamed:@"default_pic.png"];
    }
    
    if ([[ZKHContext getInstance] isAnonymousUserLogined]
        && ![anonymousAccessModules containsObject:module.code]) {
        cell.forbiddenLabel.text = @"仅会员可用";
    }else{
        cell.forbiddenLabel.text = nil;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHModuleEntity *module = self.modules[indexPath.row];
    if ([[ZKHContext getInstance] isAnonymousUserLogined]
        && ![anonymousAccessModules containsObject:module.code]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"此功能仅会员可用，请选择"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:NSLocalizedString(@"LABEL_LOGIN", @"login"),
                                      NSLocalizedString(@"LABEL_REGISTER_USER", @"register user"), nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [actionSheet showInView:self.navigationController.view];
        return;
    }
    
    UIViewController *viewController;
    
    NSString *code = module.code;
    if ([code isEqualToString:kModuleFriends]) {
        viewController = [[ZKHFriendShareListController alloc] init];
    }else if ([code isEqualToString:kModuleRadar]){
        viewController = [[ZKHRaderMainController alloc] init];
    }else if([code isEqualToString:kModuleSettings]){
        viewController = [[ZKHSettingsController alloc] init];
    }else if ([code isEqualToString:kModuleContactList]){
        viewController = [[ZKHContactListController alloc] init];
        ((ZKHContactListController *)viewController).readonly = true;
    }else if ([code isEqualToString:kModuleMyFavorite]){
        viewController = [[ZKHMyFavoritController alloc] init];
    }else if ([code isEqualToString:kModuleMyShare]){
        viewController = [[ZKHMyShareListController alloc] init];
    }else if ([code isEqualToString:kModuleMyShop]){
        viewController = [[ZKHShopLoginController alloc] init];
    }else if ([code isEqualToString:kModuleMyGrade]){
        
    }else if ([code isEqualToString:kModuleMyMessage]){
        
    }
    
    if (viewController != nil) {
        viewController.title = module.name;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIViewController *controller;
    switch (buttonIndex) {
        case 0://login
            controller = [[ZKHLoginController alloc] init];
            break;
        case 1://register user
            controller = [[ZKHRegiserUserController alloc] init];
            break;
        default:
            break;
        }
    
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end


@implementation ZKHDiscoverListController
- (NSString *)getModuleType
{
    return @"discover";
}
@end

@implementation ZKHProfileListController
- (NSString *)getModuleType
{
    return @"me";
}
@end

@implementation ZKHModuleCell

@end
