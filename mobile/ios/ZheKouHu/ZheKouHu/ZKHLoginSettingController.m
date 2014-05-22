//
//  ZKHLoginSettingController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHLoginSettingController.h"
#import "ZKHEntity.h"
#import "ZKHContext.h"
#import "ZKHProcessor+User.h"
#import "ZKHAppDelegate.h"
#import "ZKHConst.h"
#import "NSString+Utils.h"

@interface ZKHLoginSettingController ()

@end

@implementation ZKHLoginSettingController

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
    self.title = @"登录设置";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveLoginEnv:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    NSMutableDictionary *loginEnv = [ApplicationDelegate.zkhProcessor getLoginEnv:user.phone];
    if ([loginEnv count] > 0) {
        NSString *autoLogin = [loginEnv valueForKey:KEY_AUTO_LOGIN];
        if ([autoLogin isTrue]) {
            [self.autoLoginSwitch setOn:YES];
        }
        NSString *rememberPwd = [loginEnv valueForKey:KEY_REMEMBER_PWD];
        if ([rememberPwd isTrue]) {
            [self.rememberPwdSwitch setOn:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)rememberPwdChanged:(UISwitch *)sender {
    if (!sender.isOn) {
        [self.autoLoginSwitch setOn:FALSE animated:YES];
    }
}

- (IBAction)autoLoginChanged:(UISwitch *)sender {
    if (sender.isOn) {
        [self.rememberPwdSwitch setOn:sender.isOn animated:YES];
    }
}

- (void)saveLoginEnv:(id)sender
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    NSString *autoLogin = [self.autoLoginSwitch isOn]? @"true" : @"false";
    NSString *rememberPwd = [self.rememberPwdSwitch isOn]? @"true" : @"false";
    
    NSMutableDictionary *loginEnv = [[NSMutableDictionary alloc] init];
    [loginEnv setObject:user.phone forKey:KEY_PHONE];
    [loginEnv setObject:user.pwd forKey:KEY_PWD];
    [loginEnv setObject:autoLogin forKey:KEY_AUTO_LOGIN];
    [loginEnv setObject:rememberPwd forKey:KEY_REMEMBER_PWD];
    
    [ApplicationDelegate.zkhProcessor saveLoginEnv:user.phone value:loginEnv];
}
@end
