//
//  ZKHShopMainController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopMainController.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectionCell.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "ZKHShopModuleCell.h"
#import "ZKHShopInfoController.h"
#import "ZKHContext.h"
#import "ZKHChangeShopPwdController.h"
#import "ZKHAppDelegate.h"
#import "ZKHShopEmpSettingController.h"
#import "ZKHShopSaleListController.h"

static NSString *CellIdentifier = @"ShopModuleCell";

@implementation ZKHShopMainController

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
    
    self.title = @"我的店铺";
    self.statusLabel.text = @"";
    
    loginedUser = [[ZKHContext getInstance].user copy];
    [ZKHContext getInstance].user = self.shopUser;
    [ZKHContext getInstance].shopLogined = true;
    
    ZKHShopEntity *shop = self.shops[0];
    if (shop != nil) {
        [self shopSelected:shop];
        currentShopIndex = 0;
    }
    
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickMore:)];
    self.navigationItem.rightBarButtonItem = moreButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"退出店铺" style:UIBarButtonItemStyleBordered target:self action:@selector(shopLogout:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    isOpened = NO;
    int count = [self.shops count];
    
    [self.tb initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return count;
        
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        
        ZKHShopEntity *shop = self.shops[indexPath.row];
        cell.lb.text = shop.name;
        
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        currentShopIndex = indexPath.row;
        ZKHShopEntity *shop = self.shops[currentShopIndex];
        [self shopSelected:shop];
        [_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    
    [_tb.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_tb.layer setBorderWidth:2];
    
    UINib *nib = [UINib nibWithNibName:@"ZKHShopModuleCell" bundle:nil];
    [self.modulesView registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    self.modulesView.backgroundColor = [UIColor whiteColor];
    
    //强制加载所有的主营业务
    [ApplicationDelegate.zkhProcessor trades:true completionHandler:^(NSMutableArray *trades) {
        
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void) shopSelected:(ZKHShopEntity *) shop
{
    if (shop != nil) {
        self.inputTextField.text = shop.name;
        NSString *status = shop.status;
        if ([@"1" isEqualToString:status]) {
            self.statusLabel.text = @"已审核";
        }else if ([@"0" isEqualToString:status]){
            self.statusLabel.text = @"已注册";
        }else if ([@"2" isEqualToString:status]){
            self.statusLabel.text = @"已注销";
        }
    }
}

- (void)shopLogout:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"退出店铺"
                          message:@"是否退出店铺？下次进入店铺需重新登录."
                          delegate:self
                          cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://取消
            
            break;
        case 1://确认
        {
            ZKHContext *context = [ZKHContext getInstance];
            context.user = loginedUser;
            context.shopLogined = false;
            context.shouldRelogin = true;
            [self.navigationController popToRootViewControllerAnimated:YES];
            //[self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)clickMore:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                   initWithTitle:nil
                   delegate:self
                   cancelButtonTitle:@"取消"
                   destructiveButtonTitle:nil
                   otherButtonTitles:@"修改密码",@"发布新活动",
                   nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIViewController *controller;
    switch (buttonIndex) {
        case 0://changge pwd
        {
            ZKHChangeShopPwdController *controller = [[ZKHChangeShopPwdController alloc] init];
            ((ZKHChangeShopNameController *)controller).shop = self.shops[currentShopIndex];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1://publish now sale
            break;
        default:
            break;
    }
    
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeOpenStatus:(id)sender {
    
    if (isOpened) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=_tb.frame;
            
            frame.size.height=1;
            [_tb setFrame:frame];
            self.modulesView.hidden = false;
        } completion:^(BOOL finished){
            
            isOpened=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [_openButton setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=_tb.frame;
            frame.size.height = 35 * [self.shops count];
            [_tb setFrame:frame];
            self.modulesView.hidden = true;
        } completion:^(BOOL finished){
            
            isOpened=YES;
        }];
        
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHShopModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    int row = indexPath.row;
    if (row == 0) {
        cell.mImageView.image = [UIImage imageNamed:@"shop_info.png"];
        cell.mNameLabel.text = @"基本信息";
    }else if (row == 1){
        cell.mImageView.image = [UIImage imageNamed:@"emp_setting.png"];
        cell.mNameLabel.text = @"职员设置";
    }else if (row == 2){
        cell.mImageView.image = [UIImage imageNamed:@"sale_info.png"];
        cell.mNameLabel.text = @"促销活动";
    }else if (row == 3){
        cell.mImageView.image = [UIImage imageNamed:@"share_interact.png"];
        cell.mNameLabel.text = @"分享互动";
    }
        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHShopEntity *shop = self.shops[currentShopIndex];
    
    int row = indexPath.row;
    if (row == 0) {
        ZKHShopInfoController *controller = [[ZKHShopInfoController alloc] init];
        controller.shop = shop;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (row == 1){
        ZKHUserEntity *user = [ZKHContext getInstance].user;
        if ([user.uuid isEqualToString:shop.owner]) {
            ZKHShopEmpSettingController *controller = [[ZKHShopEmpSettingController alloc] init];
            controller.shop = shop;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
         //TODO
        }
    }else if (row == 2){
        ZKHShopSaleListController *controller = [[ZKHShopSaleListController alloc] init];
        controller.shop = shop;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (row == 3){
        
    }
}
@end
