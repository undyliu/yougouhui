//
//  ZKHShopEmpPwdController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-4.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHShopEmpPwdController.h"
#import "NSString+Utils.h"
#import "ZKHProcessor+Shop.h"
#import "ZKHAppDelegate.h"

@implementation ZKHShopEmpPwdController

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
    
    self.title = @"设置职员密码";
    
    self.nameLabel.text = self.emp.name;
    
    [self.pwdField becomeFirstResponder];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)save:(id)sender
{
    [self.pwdField resignFirstResponder];
    [self.pwdConfField resignFirstResponder];
    
    NSString *pwd = self.pwdField.text;
    NSString *pwdConf = self.pwdConfField.text;
    
    if ([NSString isNull:pwd] || [NSString isNull:pwdConf]) {
        return;
    }
    
    if (![pwd isEqualToString:pwdConf]) {
        return;
    }
    
    [ApplicationDelegate.zkhProcessor setShopEmpPwd:self.shop.uuid userId:self.emp.uuid pwd:pwd completionHandler:^(Boolean result) {
        if (result) {
            self.emp.pwd = pwd;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}
@end
