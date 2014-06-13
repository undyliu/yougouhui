//
//  ZKHLoginController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ZKHLoginController.h"
#import "ZKHRegiserUserController.h"
#import "ZKHAppDelegate.h"
#import "ZKHConst.h"
#import "ZKHProcessor+User.h"
#import "ZKHContext.h"
#import "NSString+Utils.h"

@interface ZKHLoginController ()

@end

@implementation ZKHLoginController

- (id)init
{
    if (self = [super init]) {
        self.title = NSLocalizedString(@"LABEL_LOGIN", @"login");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self.phoneText.text length] == 0) {
        [self.phoneText becomeFirstResponder];
    }else if ([self.pwdText.text length] == 0){
        [self.pwdText becomeFirstResponder];
    }
    
    NSMutableDictionary *loginEnv = [ApplicationDelegate.zkhProcessor getLastLoginEnv];
    if (loginEnv != nil && [loginEnv count] > 0) {
        NSString *phone = [loginEnv valueForKey:KEY_PHONE];
        NSString *pwd = [loginEnv valueForKey:KEY_PWD];
        NSString *autoLogin = [loginEnv valueForKey:KEY_AUTO_LOGIN];
        NSString *rememberPwd = [loginEnv valueForKey:KEY_REMEMBER_PWD];
        
        if ([rememberPwd isTrue]) {
            self.phoneText.text = phone;
            self.pwdText.text = pwd;
            [self.rememberPwdSwitch setOn:true];
        }
        if ([autoLogin isTrue]) {
            [self.autoLoginSwitch setOn:true];
            
            [self login];
        }
    }
    
    self.phoneText.popMessageWhenEmptyText = @"手机号不能为空.";
    self.pwdText.popMessageWhenEmptyText = @"密码不能为空.";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pwdFieldDoneEditing:(id)sender {
    [self.pwdText resignFirstResponder];
}

- (IBAction)phoneFieldDoneEditing:(id)sender {
    [self.phoneText resignFirstResponder];
    NSString *pwd = self.pwdText.text;
    if ([pwd length] == 0) {
        [self.pwdText becomeFirstResponder];
    }
}

- (IBAction)backgroupTap:(id)sender
{
    [self.phoneText resignFirstResponder];
    [self.pwdText resignFirstResponder];
}

- (IBAction)rememberPwdChanged:(UISwitch *)sender {
    if (!sender.isOn) {
        [self.autoLoginSwitch setOn:FALSE animated:YES];
    }
}

- (IBAction)phoneFieldEditingEnd:(id)sender {
    NSString *phone = self.phoneText.text;
    if ([phone length] == 0) {
        self.phoneText.layer.cornerRadius = 8.0f;
        self.phoneText.layer.masksToBounds = YES;
        self.phoneText.layer.borderColor = [[UIColor redColor] CGColor];
        self.phoneText.layer.borderWidth = 2.0f;
    }
}

- (IBAction)autoLoginChanged:(UISwitch *)sender {
    if (sender.isOn) {
        [self.rememberPwdSwitch setOn:sender.isOn animated:YES];
    }
}


- (IBAction)login {
    [self.phoneText endEditing:true];
    [self.pwdText endEditing:true];
    
    NSString *phone = self.phoneText.text;
    NSString *pwd = self.pwdText.text;
    
    Boolean cancel = false;
    
    if ([pwd length] == 0) {
        self.pwdText.layer.borderColor = [[UIColor redColor] CGColor];
        cancel = true;
        [self.pwdText showTipView];
    }
    
    if ([phone length] == 0) {
        self.phoneText.layer.borderColor = [[UIColor redColor] CGColor];
        cancel = true;
        [self.phoneText showTipView];
    }
    
    if (cancel) {
        return;
    }
    
    
    
    [ApplicationDelegate.zkhProcessor login:phone pwd:pwd completionHandler:^(NSMutableDictionary *authObj) {
        NSString *authed = [authObj objectForKey:KEY_AUTHED];
        if ([authed isTrue]) {
            ZKHUserEntity *user = [authObj objectForKey:KEY_USER];
            [[ZKHContext getInstance] setUser:user];
            
            NSString *autoLogin = [self.autoLoginSwitch isOn]? @"true" : @"false";
            NSString *rememberPwd = [self.rememberPwdSwitch isOn]? @"true" : @"false";
            
            NSMutableDictionary *loginEnv = [[NSMutableDictionary alloc] init];
            [loginEnv setObject:user.phone forKey:KEY_PHONE];
            [loginEnv setObject:user.pwd forKey:KEY_PWD];
            [loginEnv setObject:autoLogin forKey:KEY_AUTO_LOGIN];
            [loginEnv setObject:rememberPwd forKey:KEY_REMEMBER_PWD];
            
            [ApplicationDelegate.zkhProcessor saveLoginEnv:user.phone value:loginEnv];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            //NSString *error = [authObj objectForKey:KEY_ERROR_TYPE];
        }
        
    } errorHandler:^(ZKHErrorEntity *error) {
        
    }];
    
}

- (IBAction)registerUser {
    ZKHRegiserUserController *controller = [[ZKHRegiserUserController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
