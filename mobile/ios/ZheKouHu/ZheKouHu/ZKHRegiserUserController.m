//
//  ZKHRegiserUserController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRegiserUserController.h"

@interface ZKHRegiserUserController ()

@end

@implementation ZKHRegiserUserController

- (id)init
{
    if (self = [super init]) {
        self.title = NSLocalizedString(@"LABEL_REGISTER_USER", @"register user");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(registerUser:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fieldDoneEdting:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroupTap:(id)sender
{
    [self.phoneField resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.pwdField resignFirstResponder];
    [self.pwdConfField resignFirstResponder];
}
- (void)registerUser:(id)sender
{
    
}
@end
