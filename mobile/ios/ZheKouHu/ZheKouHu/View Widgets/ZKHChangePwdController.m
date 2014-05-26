//
//  ZKHChangePwdController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChangePwdController.h"

@interface ZKHChangePwdController ()

@end

@implementation ZKHChangePwdController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"修改密码";
    
    [[NSBundle mainBundle] loadNibNamed:@"ZKHChangePwdController" owner:self options:nil];
    
    orginalPwd = [[self getOriginalPwd] copy];
    
    [self.oldPwdField becomeFirstResponder];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSString *)getOriginalPwd
{
    return nil;
}

- (void)save:(id)sender
{
    [self.oldPwdField resignFirstResponder];
    [self.pwdNewField resignFirstResponder];
    [self.pwdNewConfField resignFirstResponder];
    
    Boolean cancel = false;
    NSString *oldPwd = self.oldPwdField.text;
    if ([oldPwd length] == 0) {
        cancel = true;
    }
    
    if (orginalPwd != nil && ![orginalPwd isEqualToString:oldPwd]) {
        cancel = true;
    }
    
    NSString *newPwd = self.pwdNewField.text;
    NSString *newConfPwd = self.pwdNewConfField.text;
    if ([newPwd length] < 4 || [newConfPwd length] < 4) {
        cancel = true;
    }
    
    if (![newPwd isEqualToString:newConfPwd]) {
        cancel = true;
    }
    
    if (cancel) {
        return;
    }
    
[self doSave:oldPwd newPwd:newPwd];
}

- (void)doSave:(NSString *)oldPwd newPwd:(NSString *)newPwd
{
    
}

@end
