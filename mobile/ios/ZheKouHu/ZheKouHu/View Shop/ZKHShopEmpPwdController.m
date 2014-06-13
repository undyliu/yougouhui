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
    
    self.pwdField.popMessageWhenEmptyText = @"密码不能为空.";
    self.pwdConfField.popMessageWhenEmptyText = @"密码确认不能为空.";
    
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
    
    Boolean cancel = false;
    if ([NSString isNull:pwd]) {
        cancel = true;
        [self.pwdField showTipView];
    }else if ([pwd length] < 4){
        cancel = true;
        [self.pwdField showTipView:@"密码至少4位."];
    }
    
    if ([NSString isNull:pwdConf]) {
        cancel = true;
        [self.pwdConfField showTipView];
    }
    else if (![pwd isEqualToString:pwdConf]) {
        cancel = true;
        [self.pwdConfField showTipView:@"两次密码不一致."];
    }
    
    if (cancel) {
        return;
    }

    
    [ApplicationDelegate.zkhProcessor setShopEmpPwd:self.shop.uuid userId:self.emp.uuid pwd:pwd completionHandler:^(Boolean result) {
        if (result) {
            self.emp.pwd = pwd;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        
    }];
}
@end
