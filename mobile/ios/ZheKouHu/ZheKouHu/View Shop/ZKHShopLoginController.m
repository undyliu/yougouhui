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
    self.phoneField.popMessageWhenEmptyText = @"手机号不能为空.";
    self.pwdField.popMessageWhenEmptyText = @"密码不能为空.";
    
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
    
    Boolean cancel = false;
    if ([phone length] == 0) {
        [self.phoneField showTipView];
        cancel = true;
    }else if ([phone length] != 11) {
        [self.phoneField showTipView:@"请输入11位手机号."];
        cancel = true;
    }
    
    if ([pwd length] == 0) {
        [self.pwdField showTipView];
        cancel = true;
    }else if([pwd length] < 4){
        [self.pwdField showTipView:@"密码至少4位."];
        cancel = true;
    }
    
    if (cancel) {
        return;
    }
    
    [ApplicationDelegate.zkhProcessor loginShopByPhone:phone pwd:pwd completionHandler:^(NSMutableDictionary *authObj) {
        NSString *authed = [authObj objectForKey:KEY_AUTHED];
        if ([authed isTrue]) {
            ZKHShopMainController *controller = [[ZKHShopMainController alloc] init];
            controller.shopUser = [authObj valueForKey:KEY_USER];
            controller.shops = [authObj valueForKey:KEY_SHOP_LIST];
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            NSString *error = [authObj objectForKey:KEY_ERROR_TYPE];
            if ([error isEqualToString:kAuth_user_error]) {
                [self.phoneField showTipView:@"此手机号还未注册店铺."];
            }else if ([error isEqualToString:kAuth_pass_error]){
                [self.pwdField showTipView:@"密码错误."];
            }
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        
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
