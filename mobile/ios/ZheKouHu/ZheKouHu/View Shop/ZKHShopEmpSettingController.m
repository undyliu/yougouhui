//
//  ZKHShopEmpSettingController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopEmpSettingController.h"
#import "ZKHEntity.h"
#import "ZKHProcessor+Shop.h"
#import "ZKHAppDelegate.h"
#import "NSString+Utils.h"
#import "ZKHImageLoader.h"
#import "ZKHViewUtils.h"
#import "ZKHContactListController.h"

#define kHasNotSetLoginPwd @"尚未设置登录密码"

static NSString *CellIdentifier = @"ShopEmpSettingCell";

@implementation ZKHShopEmpSettingController

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

    self.title = @"职员设置";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.tableView];
    
    UINib *nib = [UINib nibWithNibName:@"ZKHShopEmpSettingCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    [self initializeNavigationItem];
    
    [ApplicationDelegate.zkhProcessor shopEmps:self.shop.uuid completionHandler:^(NSMutableArray *shopEmpsResult) {
        shopEmps = shopEmpsResult;
        [self.tableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)updateNavToolBarFrame
{
    navToolBar.frame = CGRectMake(0, 0, 90, self.navigationController.navigationBar.frame.size.height + 1);
}

- (void)initializeNavigationItem
{
    navToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, self.navigationController.navigationBar.frame.size.height + 1)];
    
    [navToolBar setTintColor:[self.navigationController.navigationBar tintColor]];
    [navToolBar setAlpha:[self.navigationController.navigationBar alpha]];
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *insertButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addFriendClick:)];
    
    [buttons addObject:insertButton];
    [buttons addObject:self.editButtonItem];
    
    [navToolBar setItems:buttons animated:NO];
    
    UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:navToolBar];
    self.navigationItem.rightBarButtonItem = myBtn;
}

- (void)addFriendClick:(id)sender
{
    ZKHContactListController *controller = [[ZKHContactListController alloc] init];
    controller.actionDelegate = self;
    controller.readonly = false;
    controller.selectedUsers = shopEmps;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - zkhcontactActionDelegate
- (void)confirm:(NSMutableArray *)users viewController:(UIViewController *)viewController
{
    if ([users count] > 0) {
        [ApplicationDelegate.zkhProcessor addShopEmps:self.shop.uuid emps:users completionHandler:^(Boolean result) {
            if (result) {
                [shopEmps addObjectsFromArray:users];
                [viewController.navigationController popViewControllerAnimated:YES];
            }
        } errorHandler:^(NSError *error) {
            
        }];
    }else{
        [viewController.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shopEmps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHShopEmpSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    ZKHUserEntity *emp = shopEmps[indexPath.row];
    ZKHFileEntity *photo = emp.photo;
    if (photo == nil || ([NSString isNull:photo.aliasName])) {
        cell.photoView.image = [UIImage imageNamed:@"default_user_photo.png"];
    }else{
        [ZKHImageLoader showImageForName:photo.aliasName imageView:cell.photoView];
    }
    
    cell.nameLabel.text = emp.name;
    
    if ([NSString isNull:emp.pwd]) {
        cell.pwdHitLabel.text = kHasNotSetLoginPwd;
    }else{
        cell.pwdHitLabel.text = @"......";
    }
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZKHUserEntity *emp = shopEmps[indexPath.row];
        [ApplicationDelegate.zkhProcessor deleteShopEmps:self.shop.uuid emps:[@[emp] mutableCopy] completionHandler:^(Boolean result) {
            if (result) {
                [shopEmps removeObject:emp];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        } errorHandler:^(NSError *error) {
            
        }];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateNavToolBarFrame];
}
@end

@implementation ZKHShopEmpSettingCell

@end