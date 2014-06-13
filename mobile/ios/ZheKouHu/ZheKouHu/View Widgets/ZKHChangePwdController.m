//
//  ZKHChangePwdController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-26.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChangePwdController.h"
#import "NSString+Utils.h"

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
    
    self.oldPwdField.popMessageWhenEmptyText = @"原密码不能为空.";
    self.pwdNewField.popMessageWhenEmptyText = @"新密码不能为空.";
    self.pwdNewConfField.popMessageWhenEmptyText = @"新密码确认不能为空.";
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
        [self.oldPwdField showTipView];
    }else if (orginalPwd != nil && ![orginalPwd isEqualToString:oldPwd]) {
        cancel = true;
        [self.oldPwdField showTipView:@"原密码输入错误."];
    }
    
    NSString *newPwd = self.pwdNewField.text;
    NSString *newConfPwd = self.pwdNewConfField.text;
    
    if ([NSString isNull:newPwd]) {
        cancel = true;
        [self.pwdNewField showTipView];
    }else if ([newPwd length] < 4){
        cancel = true;
        [self.pwdNewField showTipView:@"密码至少4位."];
    }
    
    if ([NSString isNull:newConfPwd]) {
        cancel = true;
        [self.pwdNewConfField showTipView];
    }
    else if (![newPwd isEqualToString:newConfPwd]) {
        cancel = true;
        [self.pwdNewConfField showTipView:@"新密码不一致."];
    }
    
    if (cancel) {
        return;
    }
    
[self doSave:oldPwd newPwd:newPwd];
}

- (void)doSave:(NSString *)oldPwd newPwd:(NSString *)newPwd
{
    
}

- (IBAction)backgroupTap:(id)sender {
    [self.oldPwdField resignFirstResponder];
    [self.pwdNewField resignFirstResponder];
    [self.pwdNewConfField resignFirstResponder];
}

@end
