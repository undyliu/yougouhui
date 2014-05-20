//
//  ZKHLoginController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHLoginController.h"
#import "ZKHRegiserUserController.h"
#import "ZKHAppDelegate.h"
#import "ZKHConst.h"

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
    [self.phoneText becomeFirstResponder];
    
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

- (IBAction)autoLoginChanged:(UISwitch *)sender {
    if (sender.isOn) {
        [self.rememberPwdSwitch setOn:sender.isOn animated:YES];
    }
}


- (IBAction)login {
    NSString *phone = self.phoneText.text;
    NSString *pwd = self.pwdText.text;
    
    if ([phone length] == 0) {
        [self.phoneText becomeFirstResponder];
        return;
    }
    
    if ([pwd length] == 0) {
        [self.pwdText becomeFirstResponder];
        return;
    }
    
    [ApplicationDelegate.zkhProcessor login:phone pwd:pwd completionHandler:^(NSMutableDictionary *authObj) {
        NSString *authed = [authObj objectForKey:KEY_AUTHED];
        if ([authed isEqualToString:@"true"]) {
            ZKHUserEntity *user = [authObj objectForKey:KEY_USER];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSString *error = [authObj objectForKey:KEY_ERROR_TYPE];
        }
        
    } errorHandler:^(NSError *error) {
        
    }];
    
}

- (IBAction)registerUser {
    ZKHRegiserUserController *controller = [[ZKHRegiserUserController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
