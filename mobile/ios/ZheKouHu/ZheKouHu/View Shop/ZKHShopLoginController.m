//
//  ZKHShopLoginController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopLoginController.h"
#import "ZKHRegisterShopController.h"
#import "ZKHShopMainController.h"
#import "ZKHAppDelegate.h"
#import "NSString+Utils.h"
#import "ZKHProcessor+Shop.h"
#import "ZKHConst.h"

@interface ZKHShopLoginController ()

@end

@implementation ZKHShopLoginController

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
    self.title = @"登录店铺";
    
    //test
    self.phoneField.text = @"13651083480";
    self.pwdField.text = @"11111";
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.phoneField.text length] == 0) {
        [self.phoneField becomeFirstResponder];
    }else if ([self.pwdField.text length] == 0){
        [self.pwdField becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)fieldDonEditing:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)shopLogin:(UIButton *)sender {
    NSString *phone = self.phoneField.text;
    NSString *pwd = self.pwdField.text;
    
    if ([phone length] == 0) {
        [self.phoneField becomeFirstResponder];
        return;
    }
    
    if ([pwd length] == 0) {
        [self.pwdField becomeFirstResponder];
        return;
    }
    
    [ApplicationDelegate.zkhProcessor loginShopByPhone:phone pwd:pwd completionHandler:^(NSMutableDictionary *authObj) {
        NSString *authed = [authObj objectForKey:KEY_AUTHED];
        if ([authed isTrue]) {
            ZKHShopMainController *controller = [[ZKHShopMainController alloc] init];
            controller.user = [authObj valueForKey:KEY_USER];
            controller.shops = [authObj valueForKey:KEY_SHOP_LIST];
            [self.navigationController pushViewController:controller animated:YES];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

- (IBAction)registerShop:(UIButton *)sender {
    ZKHRegisterShopController *controller = [[ZKHRegisterShopController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)backgroupTap:(id)sender
{
    [self.phoneField resignFirstResponder];
    [self.pwdField resignFirstResponder];
}

@end
